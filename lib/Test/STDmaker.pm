#!perl
#
# Documentation, copyright and license is at the end of this file.
#
package  Test::STDmaker;

use 5.001;
use strict;
use warnings;
use warnings::register;

use File::Spec;
use Cwd;
use File::AnySpec;
use File::TestPath;
use File::SubPM;
use File::Where;

use vars qw($VERSION $DATE);
$VERSION = '1.11';
$DATE = '2004/04/09';

use DataPort::Maker;
use vars qw(@ISA);
@ISA = qw( DataPort::Maker );  # inherit the new and make_pm methods

my %targets = (
    all => [ [qw(generate Demo)], [qw(generate STD)], [qw(generate Verify)] ],
    Demo => [ [qw(generate Demo)] ],
    STD => [ [qw(generate STD)] ],
    Verify => [ [qw(generate Verify)] ],
    test  => [ 'test' ],
    __no_target__ => [ qw(target_error) ],
);


######
# Write out files
#
sub tmake
{
     my ($self, @targets) = @_;

     $self->{options} = pop @targets if ref($targets[-1]) eq 'HASH';

     my $restore_class = ref($self);
     my $options = $self->{options};

     print( "SoftwareDiamonds.com - Harnessing the power of automation.\n\n" ) if $options->{verbose};


     ########
     # Load output generators
     #
     my @generators = File::SubPM->sub_modules( __FILE__, 'STDtype');
     my ($error,$generator);
     foreach $generator (@generators) {
          $error = File::Package->load_package( "Test::STDtype::$generator" );
          if( $error ) {
             warn "\t$error\n";
             next;
          }
     }
     $self->{generators} = \@generators;
     @targets = @generators if 0 == @targets || (join ' ',@targets) =~ /all/;

     ##########
     # Santize targets
     #     
     for my $target (@targets) {
         next if ref($target);
         $generator = File::SubPM->is_module($target, @generators );
         $target = ($generator) ? $generator : lc($target);         
     }

     ########
     # Default FormDB program module is "STD"
     #
     my @t_inc = File::TestPath->find_t_roots( );
     $self->{Load_INC} = \@t_inc ;
     my $success = $self->make_pm( \%targets, @targets);

     ######
     # If have not picked up a pm and there are no test scripts
     #
     unless ($options->{pm} || $options->{test_scripts} ) {
         $options->{pm} = 'STD';
         $success = $self->make_pm( \%targets, @targets);
     }

     ######
     # Add test script to the Verify generated files that
     # will be ran using the test harness. 
     #
     if( $self->{options}->{run} && $options->{test_scripts} ) {
         my @restore_inc = @INC;
         unshift @INC, @t_inc;
         my $test_fspec = $options->{test_fspec};
         $test_fspec = 'Unix' unless $test_fspec;
         my @test_scripts = split /(?: |,|;|\n)+/, $options->{test_scripts};
         my $test_script;
         foreach $test_script (@test_scripts) {
             $test_script = File::AnySpec->fspec2os( $test_fspec, $test_script);
             unshift   @{$self->{'Test::STDtype::Verify'}->{generated_files}} ,File::Where->where( $test_script );
         } 
         @INC = @restore_inc; 
     }

     ########
     # Post process any generated files
     #
     if( $success ) {
         my $target;
         foreach $target (@targets) {
             $self = bless $self, "Test::STDtype::$target";
             $self->post_generate( ) if $self->can( 'post_generate');
         }
     }

     print( "****\nFinish Processing\n****\n" ) if $options->{verbose};

     $self = bless($self, $restore_class);

     return $success;
}


sub test
{
    
}


sub target_error
{
     my $self = shift @_;
     warn "Bad target $self->{target}\n";
}


sub generate
{
     my ($self, $output_type) = @_;
     my $restore_class = ref($self);

     my $generator = "Test::STDtype::$output_type";
     $self = $generator->new( $self );  
     last unless $self->load_std( $self->{FormDB_PM} );
     return undef unless defined ($self->generate($output_type));
     $self->print();

     $self = bless($self, $restore_class);

}


1;

__END__


=head1 NAME

Test::STDmaker - generates test scripts, demo scripts and STD program module sections

=head1 SYNOPSIS

 use Test::STDmaker

 $std = new Test::STDmaker( @options );
 $std = new Test::STDmaker( \%options );

 $std->tmake( @targets, \%options ); 
 $std->tmake( @targets ); 
 $std->tmake( \%options  ); 

=head1 DESCRIPTION

The C<fgenerate> method automates the
generation of Software Test Descriptions (STD)
Plain Old Documentation (POD), test scripts,
demonstrations scripts and the execution of the
generated test scripts and demonstration scripts.
It will automatically insert the output from the
demonstration script into the POD I<-headx Demonstration>
section of the file being tested.

The input to "L<Test::STDmaker|Test::STDmaker>" is the C<__DATA__>
section of Software Test Description (STD)
program module.
The __DATA__ section must contain a STD
forms text database in the
L<DataPort::FileType::DataDB|DataPort::FileType::DataDB> format.
The STD program modules should reside in a C<'t'> subtree whose root
is the same as the C<'lib'> subtree.
For the host site development and debug, 
the C<lib> directory is most convenient for test program modules.
However, for when building the distribution
file for installation on a target site, test library program
modules should be placed at the same level as the test script.

For example, while debugging and development the directory
structure may look as follows:

 development_dir   
   lib
     MyTopLevel
       MyUnitUnderTest.pm  # code program module
     Data::xxxx.pm  # test library program modules
 
     File::xxxx.pm  # test library program modules
   t
     MyTopLevel
       MyUnitUnderTest.pm  # STD program module

 # @INC contains the absolute path for development_dir

while a target site distribution directory for
the C<MyUnitUnderTest> would be as follows:

 devlopment_dir 
   release_dir
     MyUnitUnderTest_dir
       lib
         MyTopLevel
           MyUnitUnderTest.pm  # code program module
       t
         MyTopLevel
           MyUnitUnderTest.pm  # STD program module

           Data::xxxx.pm  # test library program modules

           File::xxxx.pm  # test library program modules

 # @INC contains the absolute path for MyUnitUnderTest_dir 
 # and does not contain the absolute path for devlopment_dir

When "Test::STDmaker" searches for a STD program module,
it looks for it first under all the directories in @INC
This means the STD program module name must start with C<"t::">.
Thus the program module name for the Unit Under
Test (UUT), C<MyTopLevel::MyUnitUNderTest>,
and the UUT STD program module, C<t::MyTopLevel::MyUnitUNderTest>,
are always different.

Use the C<tmake.pl> (test make), found in the distribution file,
cover script for  L<Test::STDmaker|Test::STDmaker> to process a STD database
module to generate a test script for debug and development as follows:

  tmake -verbose -nounlink -pm=t::MyTopLevel::MyUnitUnderTest

The C<tmake> script creates a C<$std> object and runs the C<tmake> method

 my $std = new Test::STDmaker(\%options);
 $std->tmake(@ARGV);

which replaces the POD in C<t::MyTopLevel::MyUnitUNderTest> STD program
module and creates the following files

 development_dir
   t
     MyTopLevel
       MyUnitUNderTest.t  # test script
       MyUnitUNderTest.d  # demo script
       temp.pl            # calculates test steps and so forth

The names for these three files are determined by fields
in the C<__DATA__> section of the C<t::MyTopLevel::MyUnitUNderTest> 
STD program module. All geneated scripts will contain Perl
code to change the working directory to the same directory
as the test script and add this directory to C<@INC> so
the Perl can find any test library program modules placed
in the same directory as the test script.

The first step is to debug temp.pl in the C<development_dir>

 perl -d temp.pl

Make any correction to the STD program module 
C<t::MyTopLevel::MyUnitUNderTest> not to C<temp.pl>
and repeat the above steps.
After debugging C<temp.pl>, use the same procedure to
debug C<MyUnitUnderTest.t>, C<MyUnitUnderTest.d>
 
  perl -d MyUnitUnderTest.t
  perl -d MyUnitUnderTest.d

Again make any correction to the STD program module 
C<t::MyTopLevel::MyUnitUNderTest> not to C<MyUnitUnderTest.t>
C<MyUnitUnderTest.d>
 
Once this is accomplished, develop and degug the UUT using
the test script as follows:

 perl -d MyUnitUnderTest.t

Finally, when the C<MyTopLevel::MyUnitUNderTest> is working
replace the C<=head1 DEMONSTRATION> in the C<MyTopLevel::MyUnitUNderTest>
with the output from C<MyUnitUnderTest.d> and run the 
C<MyUnitUnderTest.t> under C<Test::Harness> with the following:

 tmake -verbose -test_verbose -replace -run -pm=t::MyTopLevel::MyUnitUnderTest

Since there is no C<-unlink> option, C<tmake>
removes the C<temp.pl> file.

Keep the C<t> subtree under the C<development library> for regression testing of
the development library.

Use L<ExtUtils::SVDmaker|> to automatically build a release
directory from the development directory,
run the test script using only the files in the release directory,
bump revisions for files that changed since the
last distribution,
and package the UUT program module, test script and
test library program modules and other
files for distrubtion.

=head2 Capabilities

The C<fgenerate> method provides the following capabilities:

=over 4

=item 1

Automate Perl related programming needed to create a
test script resulting in reduction of time and cost.

=item 2

Translate a short hand Software Test Description (STD)
file into a Perl test script that eventually makes use of 
the L<Test|Test> module.

=item 3

Translate the sort hand STD data file into a Perl test 
script that demonstrates the features of the 
the module under test.

=item 4

Provide in a the POD of a STD file information required by
a Military/Federal Government 
Software Test Description (L<STD>) document
that may easily be index and accessed by
automated Test software. 

=item 5

Automate generation of test information required by
(L<STD2167A|Docs::US_DOD::STD2167A>) from the STD file
making it economical to provide this information 
for even commercial projects.
The ISO standards and certification are pushing
commercial projects more and more toward
using 2167 nomenclature and providing L<STD2167A|Docs::US_DOD::STD2167A> information.

=back

=head2 Generated files

The C<fgenerate> method will read the data 
from the form database (FormDB) section of a
Software Test Description program module (STD PM), 
clean it, and use the cleaned
data to generate the output file(s)
specified by the L<C<output option>|/output option>.
The STD PM is a Perl program module specified using
the Perl '::' notation. 
The module must be in one of the directories in the
@INC array.
Unless overriden by an L<C<file_out option>|/file_out option>,
the output file name is as specified in the
FormDB field for that output. 

In the unlikely event, there is no output file name
the C<fgenerate> method will enter
an output file with the same base name
as the STD PM with the appropriate extension 
into the FormDB.
The output file specifications are relative
to the FormDB database file.

=head2 Options

The C<[%options]> hash provides for the following options:

=over 4

=item output option

Valid values for L<C<output option>|/output option> are
as follows:

=over 4

=item Verify output

 default extension: .t

The generated file is a test script.

=item Demo output

 default extension: .d

The generated file is a demonstration script.

=item STD output

Generates the Code Section and the POD section
of the STD PM. The STD PM sections are described
below.

=back

The C<fgenerate> method will handle multiple values for 
L<C<output option>|/output option> and substitute 'Verify Demo STD' for 'all'.
The L<C<output option>|/output option> values are case insensitive. For example,
'verify Demo' 'Demo STD' are valid
for the L<C<output option>|/output option>

=item replace option

 replace => 1

run the all demo scripts and use thier output to replace the
Unit Under Test (UUT)  =headx Demonstration POD section.
The STD PM  UUT field specified the UUT file.

=item  run option

 run => 1

run all generated test scripts using the L<Test::Harness|Test::Harness>

=item verbose option

 verbose => 1           

use verbose mode when using the L<Test::Harness|Test::Harness>

=item file_out option

  file_out => $file_name

Use C<$file_name> for the output file when only one L<C<output option>|/output option> and
one C<.std> are provided.

=item fspec_out option

  fspec_out => $fspec_out

Specifies the operating system file specification to use
in writing out a file names in the STD database.

This directly impacts the following STD PM fields

L<Demo|/Demo field>
L<Verify|/Verify field>

Valid values are as follows:

MacOS MSWin32 os2 VMS epoc Unix

=item nounlink option

   nounlink => 1

Do not unlink temporary files.

=item STD2167 option

  STD2167 => 1   

Generate a STD2167 STD POD instead of
a Detail STD POD. 
A STD2167 STD POD is described in the
L<STD2167 STD Format|Test::STDmaker/STD2167 STD Format>
paragraph.
A Detail STD POD
is described in the
L<Detail STD Format|Test::STDmaker/Detail STD Format>
paragraph.

=back

=head2 STD Program Module Format

The input(s) for the C<fgenerate> method
are Softare Test Description Program Modules (STM PM).

A STD PM consists of three sections as follows:

=over 4

=item Perl Code Section

The code section contains the following
Perl scalars: $VERSION, $DATE, and $FILE.
STDmaker automatically generates this section.

=item STD POD Section

The STD POD section is either a tailored Detail STD format
or a tailored STD2167 format described below.
STDmaker automatically generates this section.

=item STD Form Database Section

This section contains a STD Form Database that
STDmaker uses (only when directed by specifying
STD as the output option) to generate the
Perl code section and the STD POD section.

=back

=head2 Detail STD Format

L<490A 3.1.2|Docs::STD_DOD::490A/3.1.2 Coverage of specifications.>
allows for general/detail separation of requirement for a group
of configuration items with a set of common requirements.
Perl program modules qualify as such.
This avoids repetition of common requirements
in detail specifications.
The detail specification and the referenced general specification
then constitute the total requirements.

In accordance with
L<490A 3.1.2.2|Docs::STD_DOD::490A/3.1.2.2 Detail specification.>
detail specifications may take the form of a specification sheet.
Traditional specification sheets contain many abbreviated legends
and is more of a form or table variant instead of a formal
technical document with paragraph numbers and complete English
sentences and paragraphs.

Following this tradition, the c<fgenerate> method
detail STD is basically the FormDB described below with some
POD =headx inserted to provide links to sections of interest.


=head2 STD2167 STD Format

The STD2167 format is a tailored 
Software Test Description (STD) 
Data Item Description (DID), L<STD|Docs::US_DOD::STD> 
that eliminates paragraphs that are not
applicable for Perl POD modules.
This greatly improves the
readability of the document without any loss 
of information.

The tailoring removes paragraph levels, reducing
the number of paragraph levels from four to two.

While the tailoring improves the readability
considerably, all tailoring is reversible 
for strict, conserative compliance to the DID
by an appropriate special POD translator.

The tailoring is as follows:

=over 4

=item Paragraph Numbers

The tailoring removed paragraph numbers in the 
Plain Old Documentation (POD) file.
Normal POD processing or post-processing of the
normal POD processing, html html whatever, can
add the paragraph numbers and other requirements
that large number of technical communities are
so fond. POD processing is the proper place
for such window dressing, not the POD itself.

=item 2. REFERENCE DOCUMENTS

Tailoring renames this section to I<SEE ALSO> and
moved it to the end of the document.
This is the customary location for this info
for the Unix community and where the Unix
community expects to find this information.

=item 3. TEST PREPARATIONS

The test preparations are the same for all tests.
The addition of Perl modules is straight forward,
consistent and the same for all new Perl moduels.

To improve readability with no loss of data provided, 
the test paragraph level x,
3.x.1, 3.x.2, 3.x.3, 3.x.4, 
of the Software Test Description (L<STD|Docs::US_DOD::STD>)
Data Item Description (DID),
has been tailored out. 

Similarily sections 4.x.y.5, 4.x.y.6, 4.x.y.7, are
the same for all tests. The tailoring removes the
x.y levels and moves this sections to 3.4, 3.5 and
3.6 respectively.

The tailored Section 3 is as follows:

 3. TEST PREPARATIONS

 3.1 Hardware preparation

 3.2 Software preparation

 3.3 Other pre-test preparations

 3.4 Criteria for evaluating results.

 3.5 Test procedure.

 3.6 Assumptions and constraints 

=item Section 4. TEST DESCRIPTIONS 

For the addition of Perl program modules and
scripts the paragraphs
4.x.y.1, 4.x.y.2, 4.x.y.3 and
4.x.y.4 are one-liners herein,
and there is only one test case per test.
Tailoring removes the confusing level y,
and replaces the lower level with a
simple item list.

POD processing has the flexibility of changing
a item list into a level 3 paragraph.

The tailored Section 4 is as follows:
 
  4. TEST DESCRIPTIONS

  4.1 ${Unique Test ID 1}

   (a) ${Unique Test ID 1} Requirements addressed:
   (b) ${Unique Test ID 1} Test:
   (c) ${Unique Test ID 1} Expected test results:


  ..


  4.x ${Unique Test ID x}

   (a) ${Unique Test ID x} Requirements addressed:
   (b) ${Unique Test ID x} Test:
   (c) ${Unique Test ID x} Expected test results:

=back

=head2 STD FormDB format

The C<Test::STDmaker> module uses the
L<DataCop::FileType::FormDB|DataCop::FileType::FormDB>
lenient format to access the data in the Data Section.

The requirements of 
L<DataCop::FileType::FormDB|DataCop::FileType::FormDB>
lenient format govern in case of a conflict with the description
herein.

In accordance with 
L<DataCop::FileType::FormDB|DataCop::FileType::FormDB>,
STD PM data consists of series
of I<field name> and I<field data> pairs.

The L<DataCopy::FileType::FormDB|DataCopy::FileType::FormDB>
format separator strings are as follows:

 End of Field Name:  [^:]:[^:]
 ENd of Field Data:  [^\^]\^[^\^]
 End of Record    :  ~-~

In other words, the separator strings 
have a string format of the following:

 (not_the_char) . (char) . (not_the_char)

The following are valid I<FormDB> fields:

 name: data^

 name:
 data
  ..
 data
 ^

Separator strings are escaped by added
an extra chacater.
For example,

=over 4

=item  DIR:::Module: $data ^

  unescaped field name:  DIR::MOdule

=item  DIR::Module:: : $data ^

  unescaped field name: DIR:Module:

Since the field name ends in a colon
the format requires a space
between the field name and 
the I<end of field name colon>.
Since the I<FormDB> format ignores
leading and trailing white space
for field names, this space is
not part of the field name.
space.

=back

This is customary form that 
all of us have been forced to fill out
through out our lives with the addition
of ending field punctuation.
Since the separator sequences
are never part of the field name and data,
the code
to read it is trivial.
For being computer friendly it is
hard to beat. 
And, altough most of us are adverse to
forms, it makes good try of being
people friendly.

An example of a STD FormDB follows:

 File_Spec: Unix^
 UUT: Test::STDmaker::tg1^
 Revision: -^
 End_User: General Public^
 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
 STD2167_Template: ^
 Detail_Template: ^
 Classification: None^
 Demo: TestGen1.d^
 Verify: TestGen1.t^

  T: 0^

  C: use Test::t::TestGen1^

  R: L<Test::t::TestGen1/Description> [1]^

  C: 
     my $x = 2
     my $y = 3
 ^

  A: $x + $y^
 SE: 5^

  N: Two Additions 
  A: ($x+$y,$y-$x)^
  E: (5,1)^

  N: Two Requirements^

  R: 
     L<Test::t::TestGen1/Description> [2]
     L<Test::t::TestGen1/Description> [3]
  ^

  A: ($x+4,$x*$y)^
  E: (6,5)^

  U:  Test under development ^ 
  S: 1^
  A: $x*$y*2^
  E: 6^

  S: 0^
  A: $x*$y*2^
  E: 6^

 See_Also: http://perl.SoftwareDiamonds.com^
 Copyright: copyright © 2003 Software Diamonds.^

This is a very compact database form. The actual
test code is Perl snippets that will
be passed to the appropriate build-in,
behind the scenes Perl subroutines.

=head2 STD FormDB Documentation Fields

The following database file fields are information
needed to generate the documentation files
and not information about the tests themselves:

=over 4

=item File_Spec field

the operating system file specification
used for the following fields:

 Verify Demo

Valid values are Unix MacOS MSWin32 os2 VMS epoc.
The scope of this value is very limited.
It does not apply to any file specification
used in the test steps nor the files used
for input to the C<fgenerate> method.

=item UUT field

The Unit Under Test (UUT).

=item  Revision field

Enter the revision for the STD POD.
Revision numbers, in accordance
with standard engineering drawing
practices are letters A .. B AA .. ZZ
except for the orginal revision which
is -.

=item  End_User field

The I<prepare for> STD title page
entry.

=item Author field

The I<prepare for> STD title page
entry.

=item Classification field

Security classification.


=item Detail_Template field

This field contains a template program module
that the C<fgenerate> method uses to generate
the STD POD section of the STD PM.
Normally this field is left blank and
the C<fgenerate> method uses its
built-in detail template.

The C<fgenerate> method merges the
following variables with the template
in generating the C<STD> file:

Date UUT_PM Revision End_User Author Classification 
Test_Script SVD Tests STD_PM Test_Descriptions See_Also
Trace_Requirement_Table Trace_Test_Table Copyright

=item STD2167_Template field

Similar to the Detail_Template field except that
the template is a tailored STD2167 template.

=item Copyright field

Any copyright and license requirements.
This is integrated into the Demo Script, Test Script
and the STD module.

=item See_Also field

This section provides links to other resources.


=item Demo field

The file for the L<C<Demo output>|Test::STDmaker/Demo output>
relative to the STD PM directory.

=item Verify field

The file for the L<C<Verify output>|Test::STDmaker/Verify output>
relative to the STD PM directory.

=back

=head2 STD FormDB Test Description Fields

The C<fgenerate> method strips
these fields out and stores them in
a hash for use in generating the output
files.
The C<fgenerate> fucntions converts
the C<File_Spec> file specification into the
native operating system file specification.

The rest of the of the fields are
order sensitive test
data as follows: 

=over 4

=item T: number_of_tests - todo tests

This field provides the number of tests
and the number of the todo tests.
The C<fgenerate> method
will automatically fill in this field.

=item N: name_data

This field provides a name for the test.
This is usually the same name as
the base name for the STD file. 

=item X: comment

This field excludes a test from
being included in the C<Demo> output
file. 

=item R: requirement_data

The I<requirement_data> cites a binding requirement
that is verified by the test.
The test software uses the I<requirement_data> to automatically generate
tracebility information that conforms to the
following:

 L<STD 4.x.y.1 Requirements addressed.|STD/Docs::US_DOD::4.x.y.1 Requirements addressed.> 

Many times the relationship between binding requirements and
the a test is vague and can even stretch the imagination.
Perhaps by tracing the binding requirement down to an actual
test number,
will help force requirements that have clean cut
tests in qualitative terms that can verify and/or validate
a requirement.

=item C: code

The C<code> field data is free form Perl code.
This field is generally used for the following:

 L<STD 4.x.y.2 Prerequisite conditions.|Docs::US_DOD::STD/4.x.y.2 Prerequisite conditions.> 

=item A: actual-expression 

This is the actual Perl expression under test and used for
the following:

 L<STD 4.x.y.3 Test inputs.|Docs::US_DOD::STD/4.x.y.3 Test inputs.> 

=item E: expected-expression 

This is the expected results. This should be raw Perl
values and used for the following:

 L<STD 4.x.y.4 Expected test results.|Docs::US_DOD::STD/4.x.y.4 Expected test results.>

This field triggers processing of the previous fields as a test.
It must always be the last field of a test.
On failure, testing continues.

=item EC: code

This field is the same as a C<C: code> field except that
the code is required for the correct evaluation of
the L<E: expected-expression|Test::STDmaker/E: expected-expression> and
the L<S: expression|Test::STDmaker/S: expression>
field data.
This field is very necessary for reports,
such as the L<C<STD output>|Test::STDmaker/STD output>,
that only evaluates C<E: expected-expression> fields and
none of the C<E: code> fields.

=item SE: expected-expression

This is the same as L<E: expected-expression|/E: expected-expression>
except that testing stops on failure.

=item S: expression

The mode C<S: expression> provides means to
conditionally preform a test. 
The condition is usually platform dependent.
In other words, a feature may be provided, say
for a VMS platform that is not available on a
Microsoft platform.

=item U: comment

This tags a test as testing a feature or capability
under development. The test is added to the I<todo>
list.

=item DO: comment

This field tags all the fields up to the next
L<C<A: actual-expression>|Test::STDmaker/A: actual-expression>
for use only in generating a 
L<Demo output|Test::STDmaker/Demo output>

=item VO: comment

This field tags all the fields up to the next
L<C<E: expected-expression>|Test::STDmaker/E: expected-expression>
for use only in generating a 
L<Verify output|Test::STDmaker/Verify output>

=item ok: test_number

The C<ok: test_number> is a the test number that 
results from the execution of C<&TEST::ok>
by the previous C<E: data> or C<SE: data> expression.
A STD file does not require any C<ok:> fields since
The C<fgenerate> method will automatically 
generate the C<ok: test_number> fields.

=back

=head1 REQUIREMENTS

This section establishes the functional requirements for the C<Test::STDmaker>
module and the C<fgenerate> method.
All other subroutines in the F<Test::STDmaker> module and modules used
by the C<Test::STDmaker> module support the C<fgenerate> method.
Their requirements are of a design nature and not included.
All design requirements may change at any time without notice to
improve performance as long as the change does not
impact the functional requirements and the test results of
the functional requirements.

Binding functional requirements, 
in accordance with L<DOD STD 490A|Docs::US_DOD::STD490A/3.2.3.6>,
are uniquely identified  with the pharse 'shall[dd]' 
where dd is an unique number for each section.
The phrases such as I<will, should, and may> do not identified
binding requirements. 
They provide clarifications of the requirements and hints
for the module design.

The general C<Test::STDmaker> Perl module requirements are as follows:

=over 4

=item load [1]

shall[1] load without error and

=item pod check [2] 

shall[2] passed the L<Pod::Checker|Pod::Checker> check
without error.

=back

=head2 Clean FormDB requirements

Before generating any output from a FormDB read from a STD PM,
the C<fgenerate> method fill clean the data.
The requirements for cleaning the data are as follows:

=over 4

=item clean FormDB [1]

The C<fgenerate> method shall[1] ensure there is a test 
step number field C<ok: $test_number^> 
after each C< E: $expected ^> and each C<E: $expected^> field.
The C<$test_number> will apply to all fields preceding the C<ok: $test_number^>
to the previous C<ok: $test_number^> or <T: $total_tests^> field

=item clean FormDB [2]

The C<fgenerate> method shall[2] ensure all test numbers in 
the C<ok: test_number^> fields are sequentially 
numbered.

=item clean FormDB [3]

The C<fgenerate> method shall[3] ensure the first test field is C<T: $total_tests^> 
where C<$total_tests>
is the number of C<ok: $test_number^> fields.

=item clean FormDB [4]

The C<fgenerate> method shall[4] include a C<$todo_list> in the C<T: $total_tests - $todo_list^> field
where each number in the list is the $test_number for a C<U: ^> field.
If there are no C<U: ^> fields the C<T: ^> format will be C<T: $total_tests^>

=back

The C<fgenerate> method will perform this processing as soon as it reads in the
STD PM.
All file generation including the C<Clean> will use the processed, cleaned
C<.std> internal test data instead of the raw data directly from the
STD PM.

=head2 Verify output file

When the L<C<output option>|/output option> input list contains C<verify> or C<all>, case insensitive, 
the C<fgenerate> method, for each input STD PM,
will produce an verify ouput file. 
The functional requirements specify the results of executing the
verify output file.
The contents of the verify output file are of a design nature
and function requirements are not applicable.

The requirements for the generated verify output file are as follow:

=over 4

=item verify file [1]

The C<fgenerate> method shall[1] obtained the name for the verify output file
from the C<Verify> field in the STD PM and assume it is
a UNIX file specification relative to STD PM
except when overriden by the L<file_out option|/file_out option [1]>. 

=item verify file [2]

The C<fgenerate> method shall[2] generate a test script that when executed
will, for each test, execute the C<C: $code> fields and 
compared the results obtained from the C<A: $actual^> actual expression with the
results from the C<E: $epected^> expected expression and 
produce an output compatible with the L<<C<Test::Harness>|Test::Harness> module.
A test is the fields between the C<ok: $test_number> fields of a cleaned STD PM.
The generated test script will provide skip test functionality by processing
the C<S: $skip-condition>, C<DO: comment> and C<U: comment> test fields and producing suitable
L<<C<Test::Harness>|Test::Harness> output.


=item verify file [3]

The C<fgenerate> method shall[3] output the
C<N: $name^> field data as a L<<C<Test::Harness>|Test::Harness> compatible comment.

=back

The C<fgenerate> method will properly compare complex data structures 
produce by the C<A: $actual^> and C<E: $epected^> expressions by
utilizing modules such as L<Data::Dumper|Data::Dumper>.

=head2 Demo output file

When the L<C<output option>|/output option> input list contains C<demo> or C<all>, 
case insensitive, 
the C<fgenerate> method, for each input STD PM,
will produce a demo ouput file. 
The functional requirements specify the results of executing the
demo output file.
The contents of the demo output file are of a design nature
and function requirements are not applicable.

The requirements for the generated demo output file are as follow:

=over 4

=item demo file [1]

The C<fgenerate> method shall[1] obtained the name for the demo output file
from the C<Demo> field in the STD PM and assume it is
a UNIX file specification relative to STD PM
except when overriden by the L<file_out option|/file_out option [1]>. 

=item demo file [2]

The C<fgenerate> method shall[2] generate the a demo script that when executed
will produce an output that appears as if the actual C<C: ^> and C<A: ^> where
typed at a console followed by the results of the execution of the C<A: ^> field.
The purpose of the demo script is to provide automated, complete examples, of
the using the Unit Under Test.
The generated demo script will provide skip test functionality by processing
the C<S: $skip-condition>, C<VO: comment> and C<U: comment> test fields.

=back

=head2 STD PM POD

When the L<C<output option>|/output option> input list contains C<STD> or C<all>, 
case insensitive, 
the C<fgenerate> method, for each input STD PM,
will generate the code and POD sections of the STD PM from the FormDB section. 
The requirements for the generated STD output file are as follow:

=over 4

=item STD PM POD [1]

The C<fgenerate> method shall[2] produce the STD output file by taking
the merging STD template file from either the C<Detail_Template> field
C<STD2167_Template> field in the STD PM or a built-in template with the 

C<Copyright Revision End_User Author SVD Classification>

fields from the C<.std> and the generated  

C<Date UUT_PM STD_PM Test_Descriptions
Test_Script Tests Trace_Requirement_Table Trace_Requirement_Table>

fields.

=back

The C<fgenerate> method will generate fields for merging with
the template file as follows:

=over

=item Date

The current data

=item UUT_PM

The Perl :: module specfication for the UUT field in the C<.std> database

=item STD_PM 

The Perl :: module specification for the C<.std> Unix file specification

=item Test_Script

The the C<Verify> field in the C<.std> database

=item Tests

The number of tests in the C<.std> database

=item Test_Descriptions

A description of a test defined by the fields between
C<ok:> fields in the C<.std> database.
The test descriptions will be in a L<STD|Docs::US_DOD::STD> format
as tailored by L<STDtailor|STD::STDtailor>

=item Trace_Requirement_Table

A table that relates the C<R:> requirement fields to the test number
in the C<.std> database.

=item Trace_Test_Table

A table that relates the test number in the C<.std> database
to the C<R:> requirement fields.

=back

The usual template file is the C<STD/STD001.fmt> file. 
This template is in the L<STD|Docs::US_DOD::STD> format
as tailored by L<STDtailor|STD::STDtailor>.

=head2 Options requirements

The C<fgenerate> option processing requirements are as follows:

=over 

=item file_out option [1]

When the input L<C<output option>|/output option> has only one value and there is only one C<.std> input
file, specifying the option

 { file_out => $file_out }

shall[1] cause the C<fgenerate> method to print the ouput to the file C<$file_out>
instead of the file specified in the STD PM.
The $file_out specification will be in the UNIX specification relative
to the STD PM.

=item replace option [2]

Specifying the option

 { replace => 1 }

with the L<C<output option>|/output option> list containg C<Demo>, 
shall[2] cause the c<fgenerate> method to execute the demo script that it generates
and replace the C</(\n=head\d\s+Demonstration).*?\n=/i> section in
the module named by the C<UUT> field in C<.std> with the output from the
demo script. 

=item run option [3]

Specifying the option

 { run => 1 }

with the L<C<output option>|/output option> list containg C<Verify>, 
shall[3] cause the c<fgenerate> method to run the
C<Test::Harness> with the test script in non-verbose mode.

=item verbose option [4]

Specifying the options

 { run => 1, verbose => 1 }

with the L<C<output option>|/output option> list containg C<Verify>, 
shall[4] cause the C<fgenerate> method to run the
C<Test::Harness> with the test script in verbose mode.

=item fspec_out option [5]

Specifying the option

 { fspec_out => I<$file_spec> }

shall[5] cause the C<fgenerate> method to translate the
file names in the C<Clean> file output to the file specification
I<$file_spec>.

=item fspec_in option [6]

Specifying the option

 { fspec_in => I<$file_spec> }

shall[6] cause the C<fgenerate> method to translate the
files in the input <.std> files from the file specification
I<$file_spec>.

=back

=head1 DEMONSTRATION

 ~~~~~~ Demonstration overview ~~~~~

Perl code begins with the prompt

 =>

The selected results from executing the Perl Code 
follow on the next lines. For example,

 => 2 + 2
 4

 ~~~~~~ The demonstration follows ~~~~~

 =>     use vars qw($loaded);
 =>     use File::Glob ':glob';
 =>     use File::Copy;
 =>     use File::Package;
 =>     use File::SmartNL;
 =>     use Text::Scrub;
 =>  
 =>     #########
 =>     # For "TEST" 1.24 or greater that have separate std err output,
 =>     # redirect the TESTERR to STDOUT
 =>     #
 =>     my $restore_testerr = tech_config( 'Test.TESTERR', \*STDOUT );   

 =>     my $fp = 'File::Package';
 =>     my $snl = 'File::SmartNL';
 =>     my $s = 'Text::Scrub';

 =>     my $test_results;
 =>     my $loaded = 0;
 =>     my @outputs;
 => my $errors = $fp->load_package( 'Test::STDmaker' )
 => $errors
 ''

 => $snl->fin('tgA0.pm')
 '#!perl
 #
 # The copyright notice and plain old documentation (POD)
 # are at the end of this file.
 #
 package  t::Test::STDmaker::tgA1;

 use strict;
 use warnings;
 use warnings::register;

 use vars qw($VERSION $DATE $FILE );
 $VERSION = '0.03';
 $DATE = '2004/04/09';
 $FILE = __FILE__;

 __DATA__

 File_Spec: Unix^
 UUT: Test::STDmaker::tg1^
 Revision: -^
 Version: 0.01^
 End_User: General Public^
 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
 STD2167_Template: ^
 Detail_Template: ^
 Classification: None^
 Demo: tgA1.d^
 Verify: tgA1.t^

  T: 0^

  C: 
     #########
     # For "TEST" 1.24 or greater that have separate std err output,
     # redirect the TESTERR to STDOUT
     #
     tech_config( 'Test.TESTERR', \*STDOUT );   
 ^  

  N: Pass test^
  R: L<Test::STDmaker::tg1/capability-A [1]>^
  C: my $x = 2^
  C: my $y = 3^
  A: $x + $y^
 SE: 5^

  N: Todo test that passes^
  U: xy feature^
  A: $y-$x^
  E: 1^

  R: 
     L<Test::STDmaker::tg1/capability-A [2]>
     L<Test::STDmaker::tg1/capability-B [1]>
  ^
  N: Test that fails^
  A: $x+4^
  E: 7^

  N: Skipped tests^
  S: 1^
  A: $x*$y*2^
  E: 6^

  N: Todo Test that Fails^
  U: zyw feature^
  S: 0^
  A: $x*$y*2^
  E: 6^

  N: demo only^
 DO: ^
  A: $x^
  E: $y^

  N: verify only^
 VO: ^
  A: $x^
  E: $x^

  N: Test loop^
  C:
     my @expected = ('200','201','202');
     my $i;
     for( $i=0; $i < 3; $i++) {
  ^

  A: $i+200^
  R: L<Test::STDmaker::tg1/capability-C [1]>^
  E: $expected[$i]^

  A: $i + ($x * 100)^
  R: L<Test::STDmaker::tg1/capability-B [4]>^
  E: $expected[$i]^

 C:
     }; 
 ^

  N: Failed test that skips the rest^
  R: L<Test::STDmaker::tg1/capability-B [2]>^
  A: $x + $y^
 SE: 6^

  N: A test to skip^
  A: $x + $y + $x^
  E: 9^

  N: A not skip to skip^
  S: 0^
  R: L<Test::STDmaker::tg1/capability-B [3]>^
  A: $x + $y + $x + $y^
  E: 10^

  N: A skip to skip^
  S: 1^
  R: L<Test::STDmaker::tg1/capability-B [3]>^
  A: $x + $y + $x + $y + $x^
  E: 10^

 See_Also: 
  L<Test::STDmaker::tg1>
 ^

 Copyright: This STD is public domain.^

 HTML:
 <hr>
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="NOTICE" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="OPT-IN" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="LOG_CGI" -->
 <!-- /BLK -->
 <p><br>
 ^

 ~-~'

 =>     copy 'tgA0.pm', 'tgA1.pm';
 =>     my $tmaker = new Test::STDmaker(pm =>'t::Test::STDmaker::tgA1');
 =>     $tmaker->tmake( 'STD' );
 => $s->scrub_date_version($snl->fin('tgA1.pm'))
 '#!perl
 #
 # The copyright notice and plain old documentation (POD)
 # are at the end of this file.
 #
 package  t::Test::STDmaker::tgA1;

 use strict;
 use warnings;
 use warnings::register;

 use vars qw($VERSION $DATE $FILE );
 $VERSION = '0.00';
 $DATE = 'Feb 6, 1969';
 $FILE = __FILE__;

 ########
 # The Test::STDmaker module uses the data after the __DATA__ 
 # token to automatically generate the this file.
 #
 # Don't edit anything before __DATA_. Edit instead
 # the data after the __DATA__ token.
 #
 # ANY CHANGES MADE BEFORE the  __DATA__ token WILL BE LOST
 #
 # the next time Test::STDmaker generates this file.
 #
 #

 =head1 TITLE PAGE

  Detailed Software Test Description (STD)

  for

  Perl Test::STDmaker::tg1 Program Module

  Revision: -

  Version: 0.01

  $DATE: Feb 6, 1969

  Prepared for: General Public 

  Prepared by:  http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com

  Classification: None

 =head1 SCOPE

 This detail STD and the 
 L<General Perl Program Module (PM) STD|Test::STD::PerlSTD>
 establishes the tests to verify the
 requirements of Perl Program Module (PM) L<Test::STDmaker::tg1|Test::STDmaker::tg1>

 The format of this STD is a tailored L<2167A STD DID|Docs::US_DOD::STD>.
 in accordance with 
 L<Detail STD Format|Test::STDmaker/Detail STD Format>.

 #######
 #  
 #  4. TEST DESCRIPTIONS
 #
 #  4.1 Test 001
 #
 #  ..
 #
 #  4.x Test x
 #
 #

 =head1 TEST DESCRIPTIONS

 The test descriptions uses a legend to
 identify different aspects of a test description
 in accordance with
 L<STD FormDB Test Description Fields|Test::STDmaker/STD FormDB Test Description Fields>.

 =head2 Test Plan

  T: 16 - 2,5^

 =head2 ok: 1

   C:
      #########
      # For "TEST" 1.24 or greater that have separate std err output,
      # redirect the TESTERR to STDOUT
      #
      tech_config( 'Test.TESTERR', \*STDOUT );
  ^
   N: Pass test^
   R: L<Test::STDmaker::tg1/capability-A [1]>^
   C: my $x = 2^
   C: my $y = 3^
   A: $x + $y^
  SE: 5^
  ok: 1^

 =head2 ok: 2

   N: Todo test that passes^
   U: xy feature^
   A: $y-$x^
   E: 1^
  ok: 2^

 =head2 ok: 3

   R:
      L<Test::STDmaker::tg1/capability-A [2]>
      L<Test::STDmaker::tg1/capability-B [1]>
  ^
   N: Test that fails^
   A: $x+4^
   E: 7^
  ok: 3^

 =head2 ok: 4

   N: Skipped tests^
   S: 1^
   A: $x*$y*2^
   E: 6^
  ok: 4^

 =head2 ok: 5

   N: Todo Test that Fails^
   U: zyw feature^
   S: 0^
   A: $x*$y*2^
   E: 6^
  ok: 5^

 =head2 ok: 6

   N: demo only^
  DO: ^
   A: $x^
   E: $y^
   N: verify only^
  VO: ^
   A: $x^
   E: $x^
  ok: 6^

 =head2 ok: 7,9,11

   N: Test loop^

   C:
      my @expected = ('200','201','202');
      my $i;
      for( $i=0; $i < 3; $i++) {
  ^
   A: $i+200^
   R: L<Test::STDmaker::tg1/capability-C [1]>^
   E: $expected[$i]^
  ok: 7,9,11^

 =head2 ok: 8,10,12

   A: $i + ($x * 100)^
   R: L<Test::STDmaker::tg1/capability-B [4]>^
   E: $expected[$i]^
  ok: 8,10,12^

 =head2 ok: 13

   C:     };^
   N: Failed test that skips the rest^
   R: L<Test::STDmaker::tg1/capability-B [2]>^
   A: $x + $y^
  SE: 6^
  ok: 13^

 =head2 ok: 14

   N: A test to skip^
   A: $x + $y + $x^
   E: 9^
  ok: 14^

 =head2 ok: 15

   N: A not skip to skip^
   S: 0^
   R: L<Test::STDmaker::tg1/capability-B [3]>^
   A: $x + $y + $x + $y^
   E: 10^
  ok: 15^

 =head2 ok: 16

   N: A skip to skip^
   S: 1^
   R: L<Test::STDmaker::tg1/capability-B [3]>^
   A: $x + $y + $x + $y + $x^
   E: 10^
  ok: 16^

 #######
 #  
 #  5. REQUIREMENTS TRACEABILITY
 #
 #

 =head1 REQUIREMENTS TRACEABILITY

   Requirement                                                      Test
  ---------------------------------------------------------------- ----------------------------------------------------------------
  L<Test::STDmaker::tg1/capability-A [1]>                          L<t::Test::STDmaker::tgA1/ok: 1>
  L<Test::STDmaker::tg1/capability-A [2]>                          L<t::Test::STDmaker::tgA1/ok: 3>
  L<Test::STDmaker::tg1/capability-B [1]>                          L<t::Test::STDmaker::tgA1/ok: 3>
  L<Test::STDmaker::tg1/capability-B [2]>                          L<t::Test::STDmaker::tgA1/ok: 13>
  L<Test::STDmaker::tg1/capability-B [3]>                          L<t::Test::STDmaker::tgA1/ok: 15>
  L<Test::STDmaker::tg1/capability-B [3]>                          L<t::Test::STDmaker::tgA1/ok: 16>
  L<Test::STDmaker::tg1/capability-B [4]>                          L<t::Test::STDmaker::tgA1/ok: 8,10,12>
  L<Test::STDmaker::tg1/capability-C [1]>                          L<t::Test::STDmaker::tgA1/ok: 7,9,11>

   Test                                                             Requirement
  ---------------------------------------------------------------- ----------------------------------------------------------------
  L<t::Test::STDmaker::tgA1/ok: 13>                                L<Test::STDmaker::tg1/capability-B [2]>
  L<t::Test::STDmaker::tgA1/ok: 15>                                L<Test::STDmaker::tg1/capability-B [3]>
  L<t::Test::STDmaker::tgA1/ok: 16>                                L<Test::STDmaker::tg1/capability-B [3]>
  L<t::Test::STDmaker::tgA1/ok: 1>                                 L<Test::STDmaker::tg1/capability-A [1]>
  L<t::Test::STDmaker::tgA1/ok: 3>                                 L<Test::STDmaker::tg1/capability-A [2]>
  L<t::Test::STDmaker::tgA1/ok: 3>                                 L<Test::STDmaker::tg1/capability-B [1]>
  L<t::Test::STDmaker::tgA1/ok: 7,9,11>                            L<Test::STDmaker::tg1/capability-C [1]>
  L<t::Test::STDmaker::tgA1/ok: 8,10,12>                           L<Test::STDmaker::tg1/capability-B [4]>

 =cut

 #######
 #  
 #  6. NOTES
 #
 #

 =head1 NOTES

 This STD is public domain.

 #######
 #
 #  2. REFERENCED DOCUMENTS
 #
 #
 #

 =head1 SEE ALSO

  L<Test::STDmaker::tg1>

 =back

 =for html
 <hr>
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="NOTICE" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="OPT-IN" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="LOG_CGI" -->
 <!-- /BLK -->
 <p><br>

 =cut

 __DATA__

 File_Spec: Unix^
 UUT: Test::STDmaker::tg1^
 Revision: -^
 End_User: General Public^
 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
 Detail_Template: ^
 STD2167_Template: ^
 Version: 0.01^
 Classification: None^
 Temp: temp.pl^
 Demo: tgA1.d^
 Verify: tgA1.t^

  T: 16 - 2,5^

  C:
     #########
     # For "TEST" 1.24 or greater that have separate std err output,
     # redirect the TESTERR to STDOUT
     #
     tech_config( 'Test.TESTERR', \*STDOUT );
 ^

  N: Pass test^
  R: L<Test::STDmaker::tg1/capability-A [1]>^
  C: my $x = 2^
  C: my $y = 3^
  A: $x + $y^
 SE: 5^
 ok: 1^

  N: Todo test that passes^
  U: xy feature^
  A: $y-$x^
  E: 1^
 ok: 2^

  R:
     L<Test::STDmaker::tg1/capability-A [2]>
     L<Test::STDmaker::tg1/capability-B [1]>
 ^

  N: Test that fails^
  A: $x+4^
  E: 7^
 ok: 3^

  N: Skipped tests^
  S: 1^
  A: $x*$y*2^
  E: 6^
 ok: 4^

  N: Todo Test that Fails^
  U: zyw feature^
  S: 0^
  A: $x*$y*2^
  E: 6^
 ok: 5^

  N: demo only^
 DO: ^
  A: $x^
  E: $y^
  N: verify only^
 VO: ^
  A: $x^
  E: $x^
 ok: 6^

  N: Test loop^

  C:
     my @expected = ('200','201','202');
     my $i;
     for( $i=0; $i < 3; $i++) {
 ^

  A: $i+200^
  R: L<Test::STDmaker::tg1/capability-C [1]>^
  E: $expected[$i]^
 ok: 7,9,11^

  A: $i + ($x * 100)^
  R: L<Test::STDmaker::tg1/capability-B [4]>^
  E: $expected[$i]^
 ok: 8,10,12^

  C:     };^
  N: Failed test that skips the rest^
  R: L<Test::STDmaker::tg1/capability-B [2]>^
  A: $x + $y^
 SE: 6^
 ok: 13^

  N: A test to skip^
  A: $x + $y + $x^
  E: 9^
 ok: 14^

  N: A not skip to skip^
  S: 0^
  R: L<Test::STDmaker::tg1/capability-B [3]>^
  A: $x + $y + $x + $y^
  E: 10^
 ok: 15^

  N: A skip to skip^
  S: 1^
  R: L<Test::STDmaker::tg1/capability-B [3]>^
  A: $x + $y + $x + $y + $x^
  E: 10^
 ok: 16^

 See_Also:  L<Test::STDmaker::tg1>^
 Copyright: This STD is public domain.^

 HTML:
 <hr>
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="NOTICE" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="OPT-IN" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="LOG_CGI" -->
 <!-- /BLK -->
 <p><br>
 ^

 ~-~
 '

 => $snl->fin('tgB0.pm')
 '#!perl
 #
 # The copyright notice and plain old documentation (POD)
 # are at the end of this file.
 #
 package  t::Test::STDmaker::tgB1;

 use strict;
 use warnings;
 use warnings::register;

 use vars qw($VERSION $DATE $FILE );
 $VERSION = '0.01';
 $DATE = '2004/04/09';
 $FILE = __FILE__;

 ########
 # The Test::STDmaker module uses the data after the __DATA__ 
 # token to automatically generate the this file.
 #
 # Don't edit anything before __DATA_. Edit instead
 # the data after the __DATA__ token.
 #
 # ANY CHANGES MADE BEFORE the  __DATA__ token WILL BE LOST
 #
 # the next time Test::STDmaker generates this file.
 #
 #

 __DATA__

 File_Spec: Unix^
 UUT: Test::STDmaker::tg1^
 Revision: -^
 End_User: General Public^
 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
 Detail_Template: ^
 STD2167_Template: ^
 Version: 0.01^
 Classification: None^
 Temp: temp.pl^
 Demo: tgB1.d^
 Verify: tgB1.t^

  T: 2^

  C: 
     #########
     # For "TEST" 1.24 or greater that have separate std err output,
     # redirect the TESTERR to STDOUT
     #
     tech_config( 'Test.TESTERR', \*STDOUT );   
 ^  

  R: L<Test::STDmaker::tg1/capability-A [1]>^
  C: my $x = 2^
  C: my $y = 3^
  A: $x + $y^
 SE: 5^
 ok: 1^

  A: [($x+$y,$y-$x)]^
  E: [5,2]^
 ok: 2^

 See_Also: L<Test::STDmaker::tg1>^
 Copyright: This STD is public domain^

 HTML:
 <hr>
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="NOTICE" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="OPT-IN" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="LOG_CGI" -->
 <!-- /BLK -->
 <p><br>
 ^

 ~-~
 '

 =>     copy 'tgB0.pm', 'tgB1.pm';
 =>     $tmaker->tmake('STD', 'verify', {pm => 't::Test::STDmaker::tgB1'} );
 => $s->scrub_date_version($snl->fin('tgB1.pm'))
 '#!perl
 #
 # The copyright notice and plain old documentation (POD)
 # are at the end of this file.
 #
 package  t::Test::STDmaker::tgB1;

 use strict;
 use warnings;
 use warnings::register;

 use vars qw($VERSION $DATE $FILE );
 $VERSION = '0.00';
 $DATE = 'Feb 6, 1969';
 $FILE = __FILE__;

 ########
 # The Test::STDmaker module uses the data after the __DATA__ 
 # token to automatically generate the this file.
 #
 # Don't edit anything before __DATA_. Edit instead
 # the data after the __DATA__ token.
 #
 # ANY CHANGES MADE BEFORE the  __DATA__ token WILL BE LOST
 #
 # the next time Test::STDmaker generates this file.
 #
 #

 =head1 TITLE PAGE

  Detailed Software Test Description (STD)

  for

  Perl Test::STDmaker::tg1 Program Module

  Revision: -

  Version: 0.01

  $DATE: Feb 6, 1969

  Prepared for: General Public 

  Prepared by:  http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com

  Classification: None

 =head1 SCOPE

 This detail STD and the 
 L<General Perl Program Module (PM) STD|Test::STD::PerlSTD>
 establishes the tests to verify the
 requirements of Perl Program Module (PM) L<Test::STDmaker::tg1|Test::STDmaker::tg1>

 The format of this STD is a tailored L<2167A STD DID|Docs::US_DOD::STD>.
 in accordance with 
 L<Detail STD Format|Test::STDmaker/Detail STD Format>.

 #######
 #  
 #  4. TEST DESCRIPTIONS
 #
 #  4.1 Test 001
 #
 #  ..
 #
 #  4.x Test x
 #
 #

 =head1 TEST DESCRIPTIONS

 The test descriptions uses a legend to
 identify different aspects of a test description
 in accordance with
 L<STD FormDB Test Description Fields|Test::STDmaker/STD FormDB Test Description Fields>.

 =head2 Test Plan

  T: 2^

 =head2 ok: 1

   C:
      #########
      # For "TEST" 1.24 or greater that have separate std err output,
      # redirect the TESTERR to STDOUT
      #
      tech_config( 'Test.TESTERR', \*STDOUT );
  ^
   R: L<Test::STDmaker::tg1/capability-A [1]>^
   C: my $x = 2^
   C: my $y = 3^
   A: $x + $y^
  SE: 5^
  ok: 1^

 =head2 ok: 2

   A: [($x+$y,$y-$x)]^
   E: [5,2]^
  ok: 2^

 #######
 #  
 #  5. REQUIREMENTS TRACEABILITY
 #
 #

 =head1 REQUIREMENTS TRACEABILITY

   Requirement                                                      Test
  ---------------------------------------------------------------- ----------------------------------------------------------------
  L<Test::STDmaker::tg1/capability-A [1]>                          L<t::Test::STDmaker::tgB1/ok: 1>

   Test                                                             Requirement
  ---------------------------------------------------------------- ----------------------------------------------------------------
  L<t::Test::STDmaker::tgB1/ok: 1>                                 L<Test::STDmaker::tg1/capability-A [1]>

 =cut

 #######
 #  
 #  6. NOTES
 #
 #

 =head1 NOTES

 This STD is public domain

 #######
 #
 #  2. REFERENCED DOCUMENTS
 #
 #
 #

 =head1 SEE ALSO

 L<Test::STDmaker::tg1>

 =back

 =for html
 <hr>
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="NOTICE" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="OPT-IN" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="LOG_CGI" -->
 <!-- /BLK -->
 <p><br>

 =cut

 __DATA__

 File_Spec: Unix^
 UUT: Test::STDmaker::tg1^
 Revision: -^
 End_User: General Public^
 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
 Detail_Template: ^
 STD2167_Template: ^
 Version: 0.01^
 Classification: None^
 Temp: temp.pl^
 Demo: tgB1.d^
 Verify: tgB1.t^

  T: 2^

  C:
     #########
     # For "TEST" 1.24 or greater that have separate std err output,
     # redirect the TESTERR to STDOUT
     #
     tech_config( 'Test.TESTERR', \*STDOUT );
 ^

  R: L<Test::STDmaker::tg1/capability-A [1]>^
  C: my $x = 2^
  C: my $y = 3^
  A: $x + $y^
 SE: 5^
 ok: 1^

  A: [($x+$y,$y-$x)]^
  E: [5,2]^
 ok: 2^

 See_Also: L<Test::STDmaker::tg1>^
 Copyright: This STD is public domain^

 HTML:
 <hr>
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="NOTICE" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="OPT-IN" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="LOG_CGI" -->
 <!-- /BLK -->
 <p><br>
 ^

 ~-~
 '

 =>     $test_results = `perl tgB1.t`;
 =>     $snl->fout('tgB1.txt', $test_results);
 => $s->scrub_probe($s->scrub_file_line($test_results))
 '1..2
 ok 1
 not ok 2
 # Test 2 got: 'L[4]
   A[0] 
   A[5] ARRAY
   A[1] 5
   A[1] 1
 ' (xxxx.t at line 000)
 #   Expected: 'L[4]
   A[0] 
   A[5] ARRAY
   A[1] 5
   A[1] 2
 '
 # Failed : 2
 # Passed : 1/2 50%
 '

 => $snl->fin( 'tg0.pm'  )
 '#!perl
 #
 # Documentation, copyright and license is at the end of this file.
 #
 package  Test::STDmaker::tg1;

 use 5.001;
 use strict;
 use warnings;
 use warnings::register;

 use vars qw($VERSION);

 $VERSION = '0.03';

 1

 __END__

 =head1 Requirements

 =head2 Capability-A 

 The requriements are as follows:

 =over 4

 =item capability-A [1]

 This subroutine shall[1] have feature 1. 

 =item capability-A [2]

 This subroutine shall[2] have feature 2.

 =back

 =head2 Capability-B

 =over 4

 =item Capability-B [1]

 This subroutine shall[1] have feature 1.

 =item Capability-B [2]

 This subroutine shall[2] have feature 2.

 =item Capability-B [3]

 This subroutine shall[3] have feature 3.

 =back

 =head1 DEMONSTRATION

 =head1 SEE ALSO

 http://perl.SoftwareDiamonds.com

 '

 =>     #########
 =>     #
 =>     # Individual generate outputs using options
 =>     #
 =>     ########
 =>     #####
 =>     # Make sure there is no residue outputs hanging
 =>     # around from the last test series.
 =>     #
 =>     @outputs = bsd_glob( 'tg*1.*' );
 =>     unlink @outputs;
 =>     copy 'tg0.pm', 'tg1.pm';
 =>     copy 'tgA0.pm', 'tgA1.pm';
 =>     my @cwd = File::Spec->splitdir( cwd() );
 =>     pop @cwd;
 =>     pop @cwd;
 =>     unshift @INC, File::Spec->catdir( @cwd );  # put UUT in lib path
 =>     $tmaker->tmake('demo', { pm => 't::Test::STDmaker::tgA1', replace => 1});
 =>     shift @INC;
 => $s->scrub_date_version($snl->fin('tg1.pm'))
 '#!perl
 #
 # Documentation, copyright and license is at the end of this file.
 #
 package  Test::STDmaker::tg1;

 use 5.001;
 use strict;
 use warnings;
 use warnings::register;

 use vars qw($VERSION);

 $VERSION = '0.00';

 1

 __END__

 =head1 Requirements

 =head2 Capability-A 

 The requriements are as follows:

 =over 4

 =item capability-A [1]

 This subroutine shall[1] have feature 1. 

 =item capability-A [2]

 This subroutine shall[2] have feature 2.

 =back

 =head2 Capability-B

 =over 4

 =item Capability-B [1]

 This subroutine shall[1] have feature 1.

 =item Capability-B [2]

 This subroutine shall[2] have feature 2.

 =item Capability-B [3]

 This subroutine shall[3] have feature 3.

 =back

 =head1 DEMONSTRATION

  ~~~~~~ Demonstration overview ~~~~~

 Perl code begins with the prompt

  =>

 The selected results from executing the Perl Code 
 follow on the next lines. For example,

  => 2 + 2
  4

  ~~~~~~ The demonstration follows ~~~~~

  =>     #########
  =>     # For "TEST" 1.24 or greater that have separate std err output,
  =>     # redirect the TESTERR to STDOUT
  =>     #
  =>     tech_config( 'Test.TESTERR', \*STDOUT );
  => my $x = 2
  => my $y = 3
  => $x + $y
  5

  => $y-$x
  1

  => $x+4
  6

  => $x*$y*2
  12

  => $x
  2

  =>     my @expected = ('200','201','202');
  =>     my $i;
  =>     for( $i=0; $i < 3; $i++) {
  => $i+200
  200

  => $i + ($x * 100)
  200

  =>     };
  => $i+200
  201

  => $i + ($x * 100)
  201

  =>     };
  => $i+200
  202

  => $i + ($x * 100)
  202

  =>     };
  => $x + $y
  5

  => $x + $y + $x
  7

  => $x + $y + $x + $y
  10

 =head1 SEE ALSO

 http://perl.SoftwareDiamonds.com

 '

 =>     no warnings;
 =>     open SAVEOUT, ">&STDOUT";
 =>     use warnings;
 =>     open STDOUT, ">tgA1.txt";
 =>     $tmaker->tmake('verify', { pm => 't::Test::STDmaker::tgA1', run => 1, test_verbose => 1});
 =>     close STDOUT;
 =>     open STDOUT, ">&SAVEOUT";
 =>     
 =>     ######
 =>     # For some reason, test harness puts in a extra line when running u
 =>     # under the Active debugger on Win32. So just take it out.
 =>     # Also the script name is absolute which is site dependent.
 =>     # Take it out of the comparision.
 =>     #
 =>     $test_results = $snl->fin('tgA1.txt');
 =>     $test_results =~ s/.*?1..9/1..9/; 
 =>     $test_results =~ s/------.*?\n(\s*\()/\n $1/s;
 =>     $snl->fout('tgA1.txt',$test_results);
 => $s->scrub_probe($s->scrub_test_file($s->scrub_file_line($test_results)))
 '~~~~
 ok 1 - Pass test 
 ok 2 - Todo test that passes  # (xxxx.t at line 000 TODO?!)
 not ok 3 - Test that fails 
 # Test 3 got: '6' (xxxx.t at line 000)
 #   Expected: '7'
 ok 4 - Skipped tests  # skip
 not ok 5 - Todo Test that Fails 
 # Test 5 got: '12' (xxxx.t at line 000 *TODO*)
 #   Expected: '6'
 ok 6 - verify only 
 ok 7 - Test loop 
 ok 8
 ok 9 - Test loop 
 ok 10
 ok 11 - Test loop 
 ok 12
 not ok 13 - Failed test that skips the rest 
 # Test 13 got: '5' (xxxx.t at line 000)
 #    Expected: '6'
 ok 14 - A test to skip  # skip
 # Test 14 got:
 # Expected: (Test not performed because of previous failure.)
 ok 15 - A not skip to skip  # skip
 # Test 15 got:
 # Expected: (Test not performed because of previous failure.)
 ok 16 - A skip to skip  # skip
 # Test 16 got:
 # Expected: (Test not performed because of previous failure.)
 # Skipped: 4 14 15 16
 # Failed : 3 5 13
 # Passed : 9/12 75%
 FAILED tests 3, 13
 	Failed 2/16 tests, 87.50% okay (less 4 skipped tests: 10 okay, 62.50%)
 Failed Test                       Stat Wstat Total Fail  Failed  List of Failed

   (1 subtest UNEXPECTEDLY SUCCEEDED), 4 subtests skipped.
 Failed 1/1 test scripts, 0.00% okay. 2/16 subtests failed, 87.50% okay.
 ~~~~
 Finished running Tests

 '

 => $snl->fin('tgC0.pm')
 '#!perl
 #
 # The copyright notice and plain old documentation (POD)
 # are at the end of this file.
 #
 package  t::Test::STDmaker::tgC1;

 use strict;
 use warnings;
 use warnings::register;

 use vars qw($VERSION $DATE $FILE );
 $VERSION = '0.03';
 $DATE = '2004/04/09';
 $FILE = __FILE__;

 ########
 # The Test::STDmaker module uses the data after the __DATA__ 
 # token to automatically generate the this file.
 #
 # Don't edit anything before __DATA_. Edit instead
 # the data after the __DATA__ token.
 #
 # ANY CHANGES MADE BEFORE the  __DATA__ token WILL BE LOST
 #
 # the next time Test::STDmaker generates this file.
 #
 #

 __DATA__

 File_Spec: Unix^
 UUT: Test::STDmaker::tg1^
 Revision: -^
 End_User: General Public^
 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
 Detail_Template: ^
 STD2167_Template: ^
 Version: 0.01^
 Classification: None^
 Temp: xx/temp.pl^
 Demo: yy/zz/tg1B.d^
 Verify: ccc/tg1B.t^

  T: 2^

  R: L<Test::STDmaker::tg1/capability-A [1]>^
  C: my $x = 2^
  C: my $y = 3^
  A: $x + $y^
 SE: 5^
 ok: 1^

  A: $y-$x^
  E: 1^
 ok: 2^

 See_Also: L<Test::STDmaker::tg1>^
 Copyright: This STD is public domain^

 HTML:
 <hr>
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="NOTICE" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="OPT-IN" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="LOG_CGI" -->
 <!-- /BLK -->
 <p><br>
 ^

 ~-~
 '

 =>     copy 'tgC0.pm', 'tgC1.pm';
 =>     $tmaker->tmake('STD', { pm => 't::Test::STDmaker::tgC1', fspec_out=>'os2'});
 => $s->scrub_date_version($snl->fin('tgC1.pm'))
 '#!perl
 #
 # The copyright notice and plain old documentation (POD)
 # are at the end of this file.
 #
 package  t::Test::STDmaker::tgC1;

 use strict;
 use warnings;
 use warnings::register;

 use vars qw($VERSION $DATE $FILE );
 $VERSION = '0.00';
 $DATE = 'Feb 6, 1969';
 $FILE = __FILE__;

 ########
 # The Test::STDmaker module uses the data after the __DATA__ 
 # token to automatically generate the this file.
 #
 # Don't edit anything before __DATA_. Edit instead
 # the data after the __DATA__ token.
 #
 # ANY CHANGES MADE BEFORE the  __DATA__ token WILL BE LOST
 #
 # the next time Test::STDmaker generates this file.
 #
 #

 =head1 TITLE PAGE

  Detailed Software Test Description (STD)

  for

  Perl Test::STDmaker::tg1 Program Module

  Revision: -

  Version: 0.01

  $DATE: Feb 6, 1969

  Prepared for: General Public 

  Prepared by:  http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com

  Classification: None

 =head1 SCOPE

 This detail STD and the 
 L<General Perl Program Module (PM) STD|Test::STD::PerlSTD>
 establishes the tests to verify the
 requirements of Perl Program Module (PM) L<Test::STDmaker::tg1|Test::STDmaker::tg1>

 The format of this STD is a tailored L<2167A STD DID|Docs::US_DOD::STD>.
 in accordance with 
 L<Detail STD Format|Test::STDmaker/Detail STD Format>.

 #######
 #  
 #  4. TEST DESCRIPTIONS
 #
 #  4.1 Test 001
 #
 #  ..
 #
 #  4.x Test x
 #
 #

 =head1 TEST DESCRIPTIONS

 The test descriptions uses a legend to
 identify different aspects of a test description
 in accordance with
 L<STD FormDB Test Description Fields|Test::STDmaker/STD FormDB Test Description Fields>.

 =head2 Test Plan

  T: 2^

 =head2 ok: 1

   R: L<Test::STDmaker::tg1/capability-A [1]>^
   C: my $x = 2^
   C: my $y = 3^
   A: $x + $y^
  SE: 5^
  ok: 1^

 =head2 ok: 2

   A: $y-$x^
   E: 1^
  ok: 2^

 #######
 #  
 #  5. REQUIREMENTS TRACEABILITY
 #
 #

 =head1 REQUIREMENTS TRACEABILITY

   Requirement                                                      Test
  ---------------------------------------------------------------- ----------------------------------------------------------------
  L<Test::STDmaker::tg1/capability-A [1]>                          L<t::Test::STDmaker::tgC1/ok: 1>

   Test                                                             Requirement
  ---------------------------------------------------------------- ----------------------------------------------------------------
  L<t::Test::STDmaker::tgC1/ok: 1>                                 L<Test::STDmaker::tg1/capability-A [1]>

 =cut

 #######
 #  
 #  6. NOTES
 #
 #

 =head1 NOTES

 This STD is public domain

 #######
 #
 #  2. REFERENCED DOCUMENTS
 #
 #
 #

 =head1 SEE ALSO

 L<Test::STDmaker::tg1>

 =back

 =for html
 <hr>
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="NOTICE" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="OPT-IN" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="LOG_CGI" -->
 <!-- /BLK -->
 <p><br>

 =cut

 __DATA__

 File_Spec: os2^
 UUT: Test::STDmaker::tg1^
 Revision: -^
 End_User: General Public^
 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
 Detail_Template: ^
 STD2167_Template: ^
 Version: 0.01^
 Classification: None^
 Temp: xx\temp.pl^
 Demo: yy\zz\tg1B.d^
 Verify: ccc\tg1B.t^

  T: 2^

  R: L<Test::STDmaker::tg1/capability-A [1]>^
  C: my $x = 2^
  C: my $y = 3^
  A: $x + $y^
 SE: 5^
 ok: 1^

  A: $y-$x^
  E: 1^
 ok: 2^

 See_Also: L<Test::STDmaker::tg1>^
 Copyright: This STD is public domain^

 HTML:
 <hr>
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="NOTICE" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="OPT-IN" -->
 <!-- /BLK -->
 <p><br>
 <!-- BLK ID="LOG_CGI" -->
 <!-- /BLK -->
 <p><br>
 ^

 ~-~
 '

 =>     #####
 =>     # Make sure there is no residue outputs hanging
 =>     # around from the last test series.
 =>     #
 =>     @outputs = bsd_glob( 'tg*1.*' );
 =>     unlink @outputs;
 =>     tech_config( 'Test.TESTERR', $restore_testerr);   

 =>     sub __warn__ 
 =>     { 
 =>        my ($text) = @_;
 =>        return $text =~ /STDOUT/;
 =>        CORE::warn( $text );
 =>     };

=head1 QUALITY ASSURANCE

The module "t::Test::STDmaker::STDmaker" is the Software
Test Description file (STD) for the "Test::STDmaker".
module. This module contains all the information
necessary for this module to verify that
this module meets its requirements.
In other words, this module will verify
itself. This is valid because if something
is wrong with this module, it will not be
able to verify itself. And if it cannot
verify itself, it cannot verify that another
module meets its requirements.

To generate all the test output files, 
run the generated test script,
run the demonstration script,
execute the following in any directory:

 tmake -verbose -replace -run -pm=t::Test::STDmaker::STDmaker

Note that F<tmake.pl> must be in the execution path C<$ENV{PATH}>
and the "t" directory on the same level as the "lib" that
contains the "Test::STDmaker" module.

=head1 NOTES

=head2 Binding Requirements

In accordance with the License, Software Diamonds
is not liable for any requirement, binding or otherwise.

=head2 Author

The author, holder of the copyright and maintainer is

E<lt>support@SoftwareDiamonds.comE<gt>

=head2 Copyright

copyright © 2003 SoftwareDiamonds.com

=head2 License

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

=over 4

=item 1

Redistributions of source code, modified or unmodified
must retain the above copyright notice, this list of
conditions and the following disclaimer. 

=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

=back

SOFTWARE DIAMONDS, http://www.SoftwareDiamonds.com,
PROVIDES THIS SOFTWARE 
'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
SHALL SOFTWARE DIAMONDS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL,EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE,DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING USE OF THIS SOFTWARE, EVEN IF
ADVISED OF NEGLIGENCE OR OTHERWISE) ARISING IN
ANY WAY OUT OF THE POSSIBILITY OF SUCH DAMAGE.

=head1 SEE ALSO

=over 4

=item L<Test|Test> 

=item L<Test::Harness|Test::Harness> 

=item  L<tg|STD::t::tg>

=item  L<STD|Docs::US_DOD::STD>

=item  L<DOD STD 490A|Docs::US_DOD::STD490A>

=item  L<DOD STD 2167A|Docs::US_DOD::STD2167A>

=back

=for html
<hr>
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="EMAIL" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut

### end of file ###

