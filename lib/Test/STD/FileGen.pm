#!perl
#
# Documentation, copyright and license is at the end of this file.
#
package  Test::STD::FileGen;

use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '1.07';
$DATE = '2004/04/09';

use File::Spec;
use Cwd;
use DataPort::FileType::FormDB;
use Test::STD::Check;
use File::AnySpec;
use File::SmartNL;

#####
# New class that formats the input data and stores it as object data
#
sub new
{
     return undef unless @_;
     my ($class, $inherit_hash) = @_;
     $class = ref($class) if ref($class);
     $inherit_hash = {} unless ref($inherit_hash);
     bless $inherit_hash, $class;

}


######
# Bring the data in from an input file
#
sub load_std
{
    my ($self, $std_pm ) = @_;

    unless( $std_pm ) {
       warn "No file specified\n";
       return undef;
    } 
    return 1 if $self->{std_pm} && $self->{std_pm} eq $std_pm;  # $file_in all cleaned

    $self->{std_db} = '';
    $self->{std_pm} = $std_pm;
    $self->{Date} = '';
    $self->{file} = '';
    $self->{vol} = '';
    $self->{dir} = '';
    
    #########
    # Record file load stats in the object database
    #
    $self->{std_db} = $self->{FormDB};
    $self->{Date} = get_date( );
    $self->{Record} = $self->{FormDB_Record};
    $self->{std_file} = $self->{FormDB_File};
    ($self->{vol}, $self->{dir}, $self->{file}) = File::Spec->splitpath( $self->{FormDB_File});

    #######
    # Clean up and standardize the file database.
    #
    my $old_class = ref($self);
    $self = bless $self,'Test::STD::Check'; # change the class
    $self->{Temp} = 'temp.pl' unless $self->{'Temp'};
    $self->{'Test::STD::Check'}->{file_out} = $self->{'Temp'};
    return undef unless $self->generate( );
    return undef unless $self->print( );
    $self = bless $self,$old_class;  # restore the original class

    1;

}



sub generate
{
    my ($self) = @_;

    my $data_out;

    my $restore_dir = cwd();
    chdir $self->{vol} if $self->{vol};
    chdir $self->{dir} if $self->{dir};

    ########
    #  Start generating the output file
    #
    #  Start is a method supplied by the
    #  class that inherits this base file
    #  generation class
    #
    my $success = 1;
    if ($self->can( 'start' )) {
        $data_out = $self->start();
    }
    else {
        $success = 0;
        $data_out .= "***ERROR*** No start method available.";
    }    

    my ($command, $data, $result);
    my $type = ref($self);
    my $std_db = $self->{std_db};
    unless ($std_db) {
        $data_out .= "No std_db to process\n";
        return 0;       
    }
    for (my $i=0; $i < @$std_db; $i +=2) {
      
        ($command,$data) = ($std_db->[$i],$std_db->[$i+1]);
        $result = $self->$command( $command, $data );
        if( defined( $result ) ) {
            $data_out .= $result; 
        }
        else {
            $success = 0;
            $data_out .= "***ERROR*** No $type->$command method available.";
        }   
    }

    ########
    #  Finish generating the output file
    #
    #  Start is a method supplied by the
    #  class that inherits this base file
    #  generation class
    #
    #
    if ($self->can( 'finish' )) {
        $data_out .= $self->finish();
    }
    else {
        $success = 0;
        $data_out .= "***ERROR*** No finish method available.";
    }    

    chdir $restore_dir;

    ########
    # Determine the class of the object that
    # inherited these methods
    #
    $self->{$type}->{data_out} = \$data_out;
    $success

}


######
# Print the output data
#
sub print
{
    my ($self, $file_out) = @_;

    my $success = 1;

    ########
    # Determine the type of the object that
    # inherited these methods
    #
    my $type = ref($self);
 
    #######
    # Determine the output data
    #
    my $data_out_p = $self->{$type}->{data_out};
    return 1 unless ref($data_out_p) eq 'SCALAR'; # only print scalars
    
    #######
    # Determine the output file
    #
    unless ($file_out) {

        unless( $file_out = $self->{$type}->{file_out} ) {
            warn "No output file specified\n";
            return undef;
        }

        #####
        # Does not work without parens around $file_out
        #
        ($file_out) = File::AnySpec->fspec2os( $self->{File_Spec}, $file_out );
    }

    ######
    # Finally print the output files, store absolute file name of output
    # in $self 
    #
    my $restore_dir = cwd();
    chdir $self->{vol} if $self->{vol};
    chdir $self->{dir} if $self->{dir};
    File::SmartNL->fout( $file_out, $$data_out_p ) if $file_out && $data_out_p && $$data_out_p;
    $self->{$type}->{generated_files} = [] unless $self->{$type}->{generated_files};
    push  @{$self->{$type}->{generated_files}},File::Spec->rel2abs($file_out);
    $self->{$type}->{data_out} = undef;  # do not want to send 2nd time

    $success = $self->post_print( ) if $self->can( 'post_print');

    ###########
    # Sometimes have untentional unlinks
    # 
    unless( $success && !$self->{options}->{nounlink}) {
        File::SmartNL->fout( $file_out, $$data_out_p ) if $file_out && $data_out_p && $$data_out_p;
    }

    chdir $restore_dir;

    $success;

}


######
# Date with year first
#
sub get_date
{
   my @d = localtime();
   @d = @d[5,4,3];
   $d[0] += 1900;
   $d[1] += 1;
   sprintf( "%04d/%02d/%02d", @d[0,1,2]);

}



1;


__END__



=head1 NAME

STD::Testgen - generates test scripts

=head1 SYNOPSIS

 use STD::TestGen

 $success = STD::TestGen->fgenerate($gen, $std ... $std [\%options])
 $success = STD::TestGen->fgenerate($gen, $std, [\%options]) 

=head1 DESCRIPTION

The C<fgenerate> subroutine automates the
generation of Software Test Descriptions (STD)
Plain Old Documentation (POD), test scripts,
demonstrations scripts and the execution of the
generated test scripts and demonstration scripts.
It will automatically insert the output from the
demonstration script into the POD I<-headx Demonstration>
section of the file being tested.

=head2 Capabilities

The C<fgenerate> subroutine provides the following capabilities:

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

Provide in a the POD of a  STD file information required by
a Military/Federal Government 
Software Test Description (L<STD>) document
that may easily be index and accessed by
automated Test software. 

=item 5

Automate generation of test information required by
(L<STD2167A|Military::STD2167A>) from the STD file
making it economical to provide this information 
for even commercial projects.
The ISO standards and certification are pushing
commercial projects more and more toward
using 2167 nomenclature and providing L<STD2167A|Military::STD2167A> information.

=back

=head2 Generated files

The C<fgenerate> subroutine will read the data 
from a C<.std> database file, clean it, and use the cleaned
data to generate the output files 
based on the L<C<output option>|/output option>.
Unless overriden by an L<C<file_out option>|/file_out option>,
the output file is as specified in the
input C<.std> database file field for a
L<C<output option>|/output option> type.

In the unlikely event, the file is not entered in
the C<.std> database, the C<fgenerate> subroutine will enter
an output file with the same base name
as the <$std> file with the extension changed 
depending upon L<C<output option>|/output option> into the C<.std> database.
The output file specifications are relative
to the C<.std> database file.

=head2 Options

The C[%options] hash provides for the following options:

=over 4

=item output option

Valid values for L<C<output option>|/output option> are

 Clean Verify Demo STD

as defined as follows:

=over 4

=item Clean output

 extension: .std

The generate file contains the clean data from $std.

=item Verify output

 extension: .t

The generated file is a test script.

=item Demo output

 extension: .d

The generated file is a demonstration script.

=item STD output

 extension: -STD.pm

The generated file is a software test description (STD) POD

=back

The C<fgenerate> subroutine will handle multiple values for 
L<C<output option>|/output option> and substitute C<'Verify Demo STD'> for 'all'.
The L<C<output option>|/output option> values are case insensitive. For example,
C<'verify Demo' 'clean all' 'clean STD'> are all valid
for L<C<output option>|/output option>

=item replace option

 replace => 1

run the all demo scripts and use there output to replace the C<UUT> 
file specified in C<.std> file C<=headx Demonstration> POD section

=item  run option

 run => 1

run all generated test scripts using L<Test::Harness|Test::Harness>

=item verbose option

 verbose => 1           

use verbose mode when using the L<Test::Harness|Test::Harness>

=item file_out option

  file_out => $file_name

Use C<$file_name> for the output file when only one L<C<output option>|/output option> and
one C<.std> are provided.

=item fspec_out option

Specifies the operating system file specification to use
in writing out a cleaned <.std> file output.
It overrides the L<File_Spec Field|/File_Spec field>
when writing out a <.std> file. 

This directly impacts the following <.std> file fields

L<Template|/Template field>
L<File_Spec|/File_Spec field>
L<Clean|/Clean field>
L<Demo|/Demo field>
L<Verify|/Verify field>
L<STD|/STD field>

The scope is very limited
Valid values are as follows:

MacOS MSWin32 os2 VMS epoc Unix

=item fspec_in option

the operating file specification for the
<.std> input files. The default is Unix.

Valid values are as follows:

MacOS MSWin32 os2 VMS epoc Unix

=item dir_path option

Normally the C<fgenerate> subroutine looks for the
files specified in the C<.std> data base file in
all the directories in C<@INC> in order and then
in the C<$ENV{PATH}> directories in order.

Supplying a C<$dir_path>, tells the
C<fgenerate> subroutine to look in 
the directories C<$dir_path> before the others.

=back


=head2 STD database file format

The primary input for the C<fgenerate> subroutine
is C<.std> database files. 
The suggested file extension is
C<.std>.
C<.std> file data consists of series
of I<field name> and I<field data> pairs.

The format uses separator strings are as follows:

 End of Field Name:  [^:]:[^:]
 ENd of Field     :  [^\^]\^[^\^]

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

An example of a C<.std> file follows:

 File_Spec: Unix^
 UUT: STD/t/TestGen1.pm^
 Revision: -^
 End_User: General Public^
 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
 SVD: SVD: STD-TestGen-0.01^
 Template: STD/STD001.frm^
 Classification: None^
 Clean: STD/t/TestGen1.std^
 Demo: STD/t/TestGen1.d^
 STD: STD/t/TestGen1-STD.pm^
 Verify: STD/t/TestGen1.t^

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

  U: ^  Test under development
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

The following fields are information
need to generate the documentation files
and not information about the tests themselve:

=over 4

=item File_Spec field

the operating system file specification
used for the following files:

 UUT Template Verify Demo Clean STD

Valid values are Unix MacOS MSWin32 os2 VMS epoc.
The scope of this value is very limited.
It does not apply to any file specification
used in the test steps nor the files used
for input to the C<fgenerate> subroutine.

=item UUT field

The Unit Under Test (UUT) file
relative to C<@INC>.

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

=item SVD field

The Software Version Description
(SVD) file 
relative to C<@INC>.

=item Template field

This is the template that the
C<fgenerate> subroutine uses to generate
the C<STD> file.
The C<fgenerate> subroutine merges the
following variables with the template
in generating the C<STD> file:

Date UUT_PM Revision End_User Author Classification 
Test_Script SVD Tests STD_PM Test_Descriptions See_Also
Trace_Requirement_Table Trace_Test_Table Copyright

The distribution provides the following base STD template

 F<STD/STD001.frm>

=item Copyright field

Any copyright and license requirements.
This is integrated into the Demo Script, Test Script
and the STD module.

=item See_Also field

This is integrated into the STD module.

=item Clean field

The file for the C<Clean> output
relative to the C<.std> file directory.

=item Demo field

The file for the C<Demo> output
relative to the C<.std> file directory.

=item STD field

The file for the C<STD> output
relative to the C<.std> file directory.

=item Verify field

The file for the C<Verify> output
relative to the C<.std> file directory.

=back

The C<fgenerate> subroutine strips
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
The C<fgenerate> subroutine
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

 L<STD 4.x.y.1 Requirements addressed.|STD/Military::4.x.y.1 Requirements addressed.> 

Many times the relationship between binding requirements and
the a test is vague and can even stretch the imagination.
Perhaps by tracing the binding requirement down to an actual
test number,
will help force requirements that have clean cut
tests in qualitative terms that can verify and/or validate
a requirement.

=item C: setup-expression

The C<code> are free form Perl code.
This is generally used for the following:

 L<STD 4.x.y.2 Prerequisite conditions.|Military::STD/4.x.y.2 Prerequisite conditions.> 

=item A: actual-expression 

This is the actual Perl expression under test and used for
the following:

 L<STD 4.x.y.3 Test inputs.|Military::STD/4.x.y.3 Test inputs.> 

=item E: expected-expression 

This is the expected results. This should be raw Perl
values and used for the following:

 L<STD 4.x.y.4 Expected test results.|Military::STD/4.x.y.4 Expected test results.>

This field triggers processing of the previous fields as a test.
It must always be the last field of a test.
On failure, testing continues.

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

=item U: 

This tags a test as testing a feature or capability
under development. The test is added to the I<todo>
list.

=item ok: test_number

The C<ok: test_number> is a the test number that 
results from the execution of C<&TEST::ok>
by the previous C<E: data> or C<SE: data> expression.
A STD file does not require any C<ok:> fields since
The C<fgenerate> subroutine will automatically 
generate the C<ok: test_number> fields.

=back

=head1 REQUIREMENTS

This section establishes the functional requirements for the C<STD::TestGen>
module and the C<fgenerate> subroutine.
All other subroutines in the F<STD::TestGen> module and modules used
by the C<STD::TestGen> module support the C<fgenerate> subroutine.
Their requirements are of a design nature and not included.
All design requirements may change at any time without notice to
improve performance as long as the change does not
impact the functional requirements and the test results of
the functional requirements.

Binding functional requirements, 
in accordance with L<DOD STD 490A|Military::STD490A/3.2.3.6>,
are uniquely identified  with the pharse 'shall[dd]' 
where dd is an unique number for each section.
The phrases such as I<will, should, and may> do not identified
binding requirements. 
They provide clarifications of the requirements and hints
for the module design.

The general C<STD::TestGen> Perl module requirements are as follows:

=over 4

=item load [1]

shall[1] load without error and

=item pod check [2] 

shall[2] passed the L<Pod::Checker|Pod::Checker> check
without error.

=back

=head2 Clean output file requirements

When the L<C<output option>|/output option> input list contains C<clean>, case insensitive, 
the C<fgenerate> subroutine, for each C<.std> input file,
will produce a clean ouput file. 
The C<Clean> output file is basically a carbon copy of
the C<.std> input file except as noted below.
The requirements for the generated clean output file are as follow:

=over 4

=item clean file [1]

The C<fgenerate> subroutine shall[1] obtained the name for the clean output file
from the C<Clean> field in the C<.std> database file, convert it from
the file specification, in the C<File_Spec> field of the C<.std> database file,
to the file specification of the native operating system, and
find the file in the C<@INC> and the C<$ENV{PATH}> directory paths.

=item clean file [2]

The C<fgenerate> subroutine shall[2] ensure there is a test 
step number field C<ok: $test_number^> 
after each C< E: $expected ^> and each C<E: $expected^> field.
The C<$test_number> will apply to all fields preceding the C<ok: $test_number^>
to the previous C<ok: $test_number^> or <T: $total_tests^> field

=item clean file [3]

The C<fgenerate> subroutine shall[4] ensure all test numbers in 
the C<ok: test_number^> fields are sequentially 
numbered.

=item clean file [4]

The C<fgenerate> subroutine shall[4] ensure the first test field is C<T: $total_tests^> where C<$total_tests>
is the number of C<ok: $test_number^> fields.

=item clean file [5]

The C<fgenerate> subroutine shall[5] include a C<$todo_list> in the C<T: $total_tests - $todo_list^> field
where each number in the list is the $test_number for a C<U: ^> field.
If there are no C<U: ^> fields the C<T: ^> format will be C<T: $total_tests^>

=back

The C<fgenerate> subroutine will perform this processing as soon as it reads in the
C<.std> file.
All file generation including the C<Clean> will use the processed, cleaned
C<.std> internal test data instead of the raw data directly from the
C<.std> file.

=head2 Verify output file

When the L<C<output option>|/output option> input list contains C<verify> or C<all>, case insensitive, 
the C<fgenerate> subroutine, for each C<.std> input file,
will produce an verify ouput file. 
The functional requirements specify the results of executing the
verify output file.
The contents of the verify output file are of a design nature.

The requirements for the generated verify output file are as follow:

=over 4

=item verify file [1]

The C<fgenerate> subroutine shall[1] obtained the name for the verify output file
from the C<Verify> field in the C<.std> database file and assume it is
a UNIX file specification relative to C<.std> database file
except when overriden by the L<file_out option|/file_out option [1]>. 

=item verify file [2]

The C<fgenerate> subroutine shall[2] generate a test script that when executed
will, for each test, execute the C<C: $code> fields and 
compared the results obtained from the C<A: $actual^> actual expression with the
results from the C<E: $epected^> expected expression and 
produce an output compatible with the L<<C<Test::Harness>|Test::Harness> module.
A test is the fields between the C<ok: $test_number> fields of a cleaned <$std> file.
The C<fgenerate> subroutine will provide skip test functionality by processing
the C<S: $skip-condition> test fields and producing suitable
L<<C<Test::Harness>|Test::Harness> output.

=item verify file [3]

The C<fgenerate> subroutine shall[3] output the
C<N: $name^> field data as a L<<C<Test::Harness>|Test::Harness> compatible comment.

=back

The C<fgenerate> subroutine will properly compare complex data structures 
produce by the C<A: $actual^> and C<E: $epected^> expressions by
utilizing modules such as L<Data::Dumper|Data::Dumper>.

=head2 Demo output file

When the L<C<output option>|/output option> input list contains C<demo> or C<all>, case insensitive, 
the C<fgenerate> subroutine, for each C<.std> input file,
will produce a demo ouput file. 
The functional requirements specify the results of executing the
demo output file.
The contents of the demo output file are of a design nature.

The requirements for the generated demo output file are as follow:

=over 4

=item demo file [1]

The C<fgenerate> subroutine shall[1] obtained the name for the demo output file
from the C<Demo> field in the C<.std> database file and assume it is
a UNIX file specification relative to C<.std> database file
except when overriden by the L<file_out option|/file_out option [1]>. 

=item demo file [2]

The C<fgenerate> subroutine shall[2] generate the a demo script that when executed
will produce an output that appears as if the actual C<C: ^> and C<A: ^> where
typed at a console followed by the results of the execution of the C<A: ^> field.
The purpose of the demo script is to provide automated, complete examples, of
the using the Unit Under Test.

=back

=head2 STD output file

When the L<C<output option>|/output option> input list contains C<STD> or C<all>, case insensitive, 
the C<fgenerate> subroutine, for each C<.std> input file,
will produce a STD ouput file. 
The requirements for the generated STD output file are as follow:

=over 4

=item STD file [1]

The C<fgenerate> subroutine shall[1] obtained the name for the STD output file
from the C<STD> field in the C<.std> database file and assume it is
a UNIX file specification relative to C<.std> database file
except when overriden by the L<file_out option|/file_out option [1]>.

=item STD file [2]

The C<fgenerate> subroutine shall[2] produce the STD output file by taking
the merging STD template file from the C<Template> field in the C<.std>
database file with the 

C<Copyright Revision End_User Author SVD Classification>

fields from the C<.std> and the generated  

C<Date UUT_PM STD_PM Test_Descriptions
Test_Script Tests Trace_Requirement_Table Trace_Requirement_Table>

fields.

=back

The C<fgenerate> subroutine will generate fields for merging with
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
The test descriptions will be in a L<STD|Military::STD> format
as tailored by L<STDtailor|STD::STDtailor>

=item Trace_Requirement_Table

A table that relates the C<R:> requirement fields to the test number
in the C<.std> database.

=item Trace_Test_Table

A table that relates the test number in the C<.std> database
to the C<R:> requirement fields.

=back

The usual template file is the C<STD/STD001.fmt> file. 
This template is in the L<STD|Military::STD> format
as tailored by L<STDtailor|STD::STDtailor>.

=head2 Options requirements

The C<fgenerate> option processing requirements are as follows:

=over 

=item file_out option [1]

When the input L<C<output option>|/output option> has only one value and there is only one C<.std> input
file, specifying the option

 { file_out => $file_out }

shall[1] cause the C<fgenerate> subroutine to print the ouput to the file C<$file_out>
instead of the file specified in the C<.std> file.
The $file_out specification will be in the UNIX specification relative
to the C<.std> database file.

=item replace option [2]

Specifying the option

 { replace => 1 }

with the L<C<output option>|/output option> list containg C<Demo>, 
shall[2] cause the c<fgenerate> subroutine to execute the demo script that it generates
and replace the C</(\n=head\d\s+Demonstration).*?\n=/i> section in
the module named by the C<UUT> field in C<.std> with the output from the
demo script. 

=item run option [3]

Specifying the option

 { run => 1 }

with the L<C<output option>|/output option> list containg C<Verify>, 
shall[3] cause the c<fgenerate> subroutine to run the
C<Test::Harness> with the test script in non-verbose mode.

=item verbose option [4]

Specifying the options

 { run => 1, verbose => 1 }

with the L<C<output option>|/output option> list containg C<Verify>, 
shall[4] cause the C<fgenerate> subroutine to run the
C<Test::Harness> with the test script in verbose mode.

=item fspec_out option [5]

Specifying the option

 { fspec_out => I<$file_spec> }

shall[5] cause the C<fgenerate> subroutine to translate the
file names in the C<Clean> file output to the file specification
I<$file_spec>.

=item fspec_in option [6]

Specifying the option

 { fspec_in => I<$file_spec> }

shall[6] cause the C<fgenerate> subroutine to translate the
files in the input <.std> files from the file specification
I<$file_spec>.

=item dir-path option [7]

Specifying the option

 { dir_path => I<$dir_path> }

shall[7] cause the C<fgenerate> subroutine to 
seach for the input <.std> file in the directories
of $dir_path before looking in the C<@INC> and
C<$ENC{PATH}> directories.


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

 =>     use File::Glob ':glob';
 =>     use File::Copy;
 =>     my $loaded = 0; 
 =>     my @outputs;
 =>     my $test_results;
 => $T->load_package( 'STD::TestGen' )
 ''

 =>     #####
 =>     # Make sure there is no residue outputs hanging
 =>     # around from the last test series.
 =>     #
 =>     @outputs = bsd_glob( 'tg*1.*' );
 =>     unlink @outputs;
 =>     @outputs = bsd_glob( 'tg*1-STD.pm');
 =>     unlink @outputs;
 => copy 'tgA0.std', 'tgA1.std'
 => $T->fin('tgA1.std')
 '

 UUT: STD/t/tg1.pm^
 Revision: -^
 End_User: General Public^
 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
 SVD: None^
 Template: STD/STD001.frm^
 Classification: None^
 Clean: tgA1.std^
 Demo: tgA1.d^
 STD: tgA1-STD.pm^
 Verify: tgA1.t^

  T: 0^

  C: use STD::t::tg1^

  N: Pass test^
  R: L<STD::t::tg1/capability-A [1]>^
  C: my $x = 2^
  C: my $y = 3^
  A: $x + $y^
 SE: '5'^

  N: Todo test that passes^
  U: xy feature^
  A: ($x+$y,$y-$x)^
  E: '5','1'^

  R: 
     L<STD::t::tg1/capability-A [2]>
     L<STD::t::tg1/Capability-B [1]>
  ^
  N: Test that fails^
  A: ($x+4,$x*$y)^
  E: '6','5'^

  N: Skipped tests^
  S: 1^
  A: $x*$y*2^
  E: '6'^

  N: Todo Test that Fails^
  U: zyw feature^
  S: 0^
  A: $x*$y*2^
  E: '6'^

  N: Failed test that skips the rest^
  R: L<STD::t::tg1/Capability-B [2]>^
  A: $x + $y^
 SE: '6'^

  N: A test to skip^
  A: $x + $y + $x^
  E: '9'^

  N: A not skip to skip^
  S: 0^
  R: L<STD::t::tg1/Capability-B [3]>^
  A: $x + $y + $x + $y^
  E: '10'^

  N: A skip to skip^
  S: 1^
  R: L<STD::t::tg1/Capability-B [3]>^
  A: $x + $y + $x + $y + $x^
  E: '10'^

 See_Also: 
 http://perl.softwarediamonds.com
 L<STD::t::tg1>
 ^

 Copyright: Public Domain^

 '

 => copy 'tg0.pm', 'tg1.pm'
 => $T->fin('tg1.pm')
 '#!perl
 #
 # Documentation, copyright and license is at the end of this file.
 #
 package  Test::t::Case0A;

 use 5.001;
 use strict;
 use warnings;
 use warnings::register;

 use vars qw($VERSION);

 $VERSION = '0.01';

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

 => copy 'tgA0.std', 'tgA1.std'
 => STD::TestGen->fgenerate('STD/t/tgA1.std', {fspec_in=>'Unix', output=>'clean all'} )
 => $T->fin('tgA1.std')
 '

 File_Spec: Unix^
 UUT: STD/t/tg1.pm^
 Revision: -^
 End_User: General Public^
 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
 SVD: None^
 Template: STD/STD001.frm^
 Classification: None^
 Clean: tgA1.std^
 Demo: tgA1.d^
 STD: tgA1-STD.pm^
 Verify: tgA1.t^

  T: 9 - 2,5^

  C: use STD::t::tg1^
  N: Pass test^
  R: L<STD::t::tg1/capability-A [1]>^
  C: my $x = 2^
  C: my $y = 3^
  A: $x + $y^
 SE: '5'^
 ok: 1^

  N: Todo test that passes^
  U: xy feature^
  A: ($x+$y,$y-$x)^
  E: '5','1'^
 ok: 2^

  R:
     L<STD::t::tg1/capability-A [2]>
     L<STD::t::tg1/Capability-B [1]>
 ^

  N: Test that fails^
  A: ($x+4,$x*$y)^
  E: '6','5'^
 ok: 3^

  N: Skipped tests^
  S: 1^
  A: $x*$y*2^
  E: '6'^
 ok: 4^

  N: Todo Test that Fails^
  U: zyw feature^
  S: 0^
  A: $x*$y*2^
  E: '6'^
 ok: 5^

  N: Failed test that skips the rest^
  R: L<STD::t::tg1/Capability-B [2]>^
  A: $x + $y^
 SE: '6'^
 ok: 6^

  N: A test to skip^
  A: $x + $y + $x^
  E: '9'^
 ok: 7^

  N: A not skip to skip^
  S: 0^
  R: L<STD::t::tg1/Capability-B [3]>^
  A: $x + $y + $x + $y^
  E: '10'^
 ok: 8^

  N: A skip to skip^
  S: 1^
  R: L<STD::t::tg1/Capability-B [3]>^
  A: $x + $y + $x + $y + $x^
  E: '10'^
 ok: 9^

 See_Also:
 http://perl.softwarediamonds.com
 L<STD::t::tg1>
 ^

 Copyright: Public Domain^

 '

 => STD::TestGen->fgenerate('STD/t/tgA1.std', {fspec_in=>'Unix', output=>'demo', replace => 1});
 => $T->fin('tg1.pm')
 '#!perl
 #
 # Documentation, copyright and license is at the end of this file.
 #
 package  Test::t::Case0A;

 use 5.001;
 use strict;
 use warnings;
 use warnings::register;

 use vars qw($VERSION);

 $VERSION = '0.01';

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

  => use STD::t::tg1
  => my $x = 2
  => my $y = 3
  => $x + $y
  '5'

  => ($x+$y,$y-$x)
  '5'
  '1'

  => ($x+4,$x*$y)
  '6'
  '6'

  => $x*$y*2
  '12'

  => $x + $y
  '5'

  => $x + $y + $x
  '7'

  => $x + $y + $x + $y
  '10'

 =head1 SEE ALSO

 http://perl.SoftwareDiamonds.com

 '

 =>     no warnings;
 =>     open SAVEOUT, ">&STDOUT";
 =>     open STDOUT, ">tgA1.txt";
 =>     STD::TestGen->fgenerate('STD/t/tgA1.std', {fspec_in=>'Unix', output=>'verify', run=>1, verbose=>1});
 =>     close STDOUT;
 =>     open STDOUT, ">&SAVEOUT";
 =>     use warnings;
 =>     
 =>     ######
 =>     # For some reason, test harness puts in a extra line when running u
 =>     # under the Active debugger on Win32. So just take it out.
 =>     # Also the script name is absolute which is site dependent.
 =>     # Take it out of the comparision.
 =>     #
 =>     $test_results = $T->fin('tgA1.txt');
 =>     $test_results =~ s/.*?1..9/1..9/; 
 =>     $test_results =~ s/------.*?\n(\s*\()/\n $1/s;
 =>     $T->fout('TgA1.txt',$test_results);
 => $test_results
 '1..9 todo 2 5;
 # Pass test
 ok 1
 # Todo test that passes
 ok 2 # (E:\User\SoftwareDiamonds\installation\lib\STD\t\tgA1.t at line 109 TODO?!)
 # Test that fails
 not ok 3
 # Test 3 got: '$VAR1 = '6';
 $VAR2 = '6';
 ' (E:\User\SoftwareDiamonds\installation\lib\STD\t\tgA1.t at line 123)
 #   Expected: '$VAR1 = '6';
 $VAR2 = '5';
 '
 # Skipped tests
 ok 4 # skip
 # Todo Test that Fails
 not ok 5
 # Test 5 got: '$VAR1 = '12';
 ' (E:\User\SoftwareDiamonds\installation\lib\STD\t\tgA1.t at line 139 *TODO*)
 #   Expected: '$VAR1 = '6';
 '
 # Failed test that skips the rest
 not ok 6
 # Test 6 got: '$VAR1 = '5';
 ' (E:\User\SoftwareDiamonds\installation\lib\STD\t\tgA1.t at line 153)
 #   Expected: '$VAR1 = '6';
 '
 # A test to skip
 # Test invalid because of previous failure.
 ok 7 # skip
 # A not skip to skip
 # Test invalid because of previous failure.
 ok 8 # skip
 # A skip to skip
 # Test invalid because of previous failure.
 ok 9 # skip
 FAILED tests 3, 6
 	Failed 2/9 tests, 77.78% okay (-4 skipped tests: 3 okay, 33.33%)
 Failed Test                      Status Wstat Total Fail  Failed  List of Failed

   (1 subtest UNEXPECTEDLY SUCCEEDED), 4 subtests skipped.
 Failed 1/1 test scripts, 0.00% okay. 2/9 subtests failed, 77.78% okay.
 '

 =>     sub __warn__ 
 =>     { 
 =>        my ($text) = @_;
 =>        return $text =~ /STDOUT/;
 =>        CORE::warn( $text );
 =>     };

 =>     #####
 =>     # Make sure there is no residue outputs hanging
 =>     # around from the last test series.
 =>     #
 =>     @outputs = bsd_glob( 'tg*1.*' );
 =>     unlink @outputs;
 =>     @outputs = bsd_glob( 'tg*1-STD.pm');
 =>     unlink @outputs;

=head1 QUALITY ASSURANCE

The file F<STD/t/testgen.std> is the Software
Test Description file for the C<Test::Testgen>
module. This file contains all the information
necessary for this module to verify that
this module meets its requirements.
In other words, this module will verify
itself. This is valid because if something
is wrong with this module, it will not be
able to verify itself. And if it cannot
verify itself, it cannot verify that another
module meets its requirements.

To generate all the test output files, 
run the generated test script F<Test/t/Testgen.t>
and the demonstration script F<Test/t/Testgen.d>,
execute the following in the F<Test/t>
directory:

 tg -o="clean all" -v -r -e STD/t/TestGen.std

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

