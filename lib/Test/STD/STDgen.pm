#!perl
#
# Documentation, copyright and license is at the end of this file.
#

package  Test::STD::STDgen;

use 5.001;
use strict;
use warnings;
use warnings::register;

use File::Glob ':glob';
use File::Spec;
use Text::Column;
use Text::Replace;
use File::AnySpec;
use File::Package;
use File::Data;
use Cwd;

use vars qw($VERSION $DATE);
$VERSION = '1.04';
$DATE = '2003/07/05';

########
# Inherit Test::STD::FileGen
#
use Test::STD::FileGen;
use vars qw(@ISA);
@ISA = qw(Test::STD::FileGen);


sub extension { '.pm' }
sub file_out { $_[0]->{std_file} }

sub start
{
    my ($self) = @_;
    my $module = ref($self);
    my $module_db = $self->{$module};

    #####
    # Document wide initialization
    # 
    $module_db->{ok} = 1;
    $module_db->{Test_Descriptions} = '';
    $module_db->{trace_req} = {};
    $module_db->{trace_test} = {};

    $self->test_cleanup(); # test step cleanup
    $self->{STD_PACKAGE} = File::AnySpec->fspec2pm($self->{File_Spec},  $self->{STD});
    $self->{STD_PM} = Text::Column->fspec2pm($self->{File_Spec},  $self->{std} );
    $self->{UUT_PM} = Text::Column->fspec2pm($self->{File_Spec},  $self->{UUT} );

    << "EOF"
#!perl
#
#
package $self->{STD_PACKAGE};

use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw(\$VERSION \$DATE);
\$VERSION = '0.01';   # automatically generated file
\$DATE = '$self->{Date}';

##### Software Test Description ####
#
# The module STD::TestGen generated this program module from the contents of
#
# $self->{std}
#
# Don't edit this program module file. Edit instead
#
# $self->{std}
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time STD::TestGen generates this program module file.
#
#

EOF

}


sub finish
{
    my ($self) = @_;
    my $module = ref($self);
    my $module_db = $self->{$module};

    ######
    # Build macro substitutes
    #
    $module_db->{Trace_Requirement_Table} = "No requirements specified.\n";
    if( $module_db->{trace_req} ) {
       $module_db->{Trace_Requirement_Table} = Text::Column->format_hash_table( $module_db->{trace_req}, [64,64], ["Requirement", "Test"] );
       $module_db->{trace_req} = {};
    }

    $module_db->{Trace_Test_Table} = '';
    if( $module_db->{trace_test} ) {
       $module_db->{Trace_Test_Table} = Text::Column->format_hash_table( $module_db->{trace_test}, [64,64], ["Test", "Requirement"] );
       $module_db->{trace_test} = {};
    }
    $module_db->{Test_Script} = $self->{Verify};
    $module_db->{Tests} = $module_db->{ok};    

    my $template = $self->{Template};
    unless( $template ) {
        warn "No STD template\n";
        return 0;
    }

    #########
    # Get the STD2167 template
    #  
    my ($error, $template_contents);
    if( $self->{STD2167_Template} ) {
        $error = File::Package->load_package( $self->{STD2167_Template} );
        $template_contents = File::Data->pm2data( $self->{STD2167_Template} );
    }
    $template_contents = default_template() unless $template_contents;

    my @vars = qw(
      Test_Script Tests Test_Descriptions 
      Trace_Requirement_Table Trace_Test_Table);

    Text::Replace->replace_variables(\$template_content, $module_db, \@vars);

    @vars = qw(
      Date UUT_PM STD_PM Revision End_User Author Classification 
      SVD  See_Also Copyright);

    Text::Replace->replace_variables(\$template_content, $self, \@vars);

    $module_db->{ok} = 0;
    $module_db->{Test_Descriptions} = '';
    $module_db->{Trace_Test_Table} = '';
    $module_db->{Trace_Requirement_Table} = '';

    $template;

}


sub test_cleanup
{
    my ($self) = @_;
    my $module = ref($self);
    my $module_db = $self->{$module};
    $module_db->{stop} = 0;
    $module_db->{setup} = [];
    $module_db->{input} = '';
    $module_db->{expected} = [];
    $module_db->{skip}  = '';
    $module_db->{todo} = 0;
    $module_db->{name} = ''; 
    $module_db->{requirements} = [];
}


sub  T { '' };
sub VO { '' };

sub C
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);

    $data =~ s/(.*?)\n*$/$1/sg;
    $data .= ';' if substr( $data, length($data)-1,1) ne ';';
    $data .= "\n";
    push @{$self->{$module}->{setup}}, $data;
    ''
}

sub R
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    while( chomp $data ) {};
    my @data = split /(?:,|;|\n)+/, $data;
    push @{$self->{$module}->{requirements}}, @data;
    ''
}

sub S
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    $self->{$module}->{skip} = $data;
    ''
}

sub U
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    return '' if  $self->{$module}->{demo_only};
    $self->{$module}->{todo} = ($data) ? $data : 'Feature';
    ''
}


sub N
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    $self->{$module}->{name} = $data;
    ''
}



sub A
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    $self->{$module}->{input} = $data;
    ''
}


sub SE
{
    my ($self) = @_;
    my $module = ref($self);
    $self->{$module}->{stop}=1;
    E(@_);
}


sub E
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    return '' if $self->{$module}->{demo_only};
    if( $self->{$module}->{skip} ) {
       $self->{$module}->{expected} = "Test skipped because the following evaluated true:\n\n $data";
       return ''; 
    }
    $self->{$module}->{expected} = $data;
    ''
}




sub ok 
{
    my ($self, $command, $test_num) = @_;
    my $module = ref($self);
    my $module_db = $self->{$module};

    $module_db->{ok} = $test_num;
    my $trace_req_p = $module_db->{trace_req};
    my $trace_test_p = $module_db->{trace_test};


    ######
    # Provide a link to this test for each data requirement
    # for later output of tracebility matrices. 
    #
    # Tracebility matrices are very important for bean counters
    # who do not understand the code.
    # 
    # 
    my $unique_test_id = sprintf "Test %03d", $test_num;
    $unique_test_id .= " - $module_db->{name}" if $module_db->{name} ;

    my $requirement;
    my @clean_requirement = ();
    my $std_pm = File::AnySpec->fspec2pm($self->{File_Spec}, $self->{STD});
    foreach $requirement (@{$module_db->{requirements}}) {
        ($requirement) = $requirement =~ /^\s*(.*)\s*$/; # remove leading and tailing white space
        next unless $requirement;
        push @clean_requirement, $requirement;
      
        #####
        # Enter test into trace requirement matrix hash
        #
        $trace_req_p->{$requirement}->{"L<$std_pm/$unique_test_id>"} = 1;

        ######
        # Enter requirement into trace test matrix hash
        #  
        $trace_test_p->{"L<$std_pm/$unique_test_id>"}->{$requirement} = 1;
    }  

    my $requirements = join ', ', @clean_requirement;
    if($requirements) {
        while(chomp $requirements) {};
    }
    else {
        $requirements = 'None.' ;
    }

    my $setup = '';
    if(@{$module_db->{setup}}) {
        $setup = join '', @{$module_db->{setup}};
        if( $setup  ) {
            while(chomp $setup) {};
            $setup =~ s/(\n+)/$1 /g;     
        }
        ($setup) = $setup =~ /^\n*(.*)\n*$/s; # drop beginning trailing newlines
        $setup .= "\n";
    }

    my $input = $module_db->{input};
    while(chomp $input) {};
    $input =~ s/(\n+)/$1 /g;     

    my $stop='';
    $stop = "Skip rest of tests on failure. " if $module_db->{stop};

    my $todo = '';
    $todo = "Skip. $module_db->{todo} under development.\n\n" if $module_db->{todo};

    my $conditions = '';
    if( $stop || $todo ) {

        $conditions = <<"EOF";
=item $unique_test_id - Test procedure Conditions

$stop
$todo
EOF

    }

    my $expected = $module_db->{expected}; 
    $expected =~ s/(\n+)/$1 /g; # space tells POD code its code

    my $msg = << "EOF";

=head2 $unique_test_id

=over 4

=item $unique_test_id - Requirements addressed

$requirements

=item $unique_test_id - Test

 $setup$input

=item $unique_test_id - Expected Test Results

 $expected

$conditions

=back

=cut

EOF

    $self->test_cleanup();
    $module_db->{Test_Descriptions} .= $msg;  # save for template merge
    ''

}


sub AUTOLOAD
{
    our $AUTOLOAD;
    return undef if $AUTOLOAD =~ /DESTROY/;
    warn "Method $AUTOLOAD not supported by STD::Gen::STD";
    undef;
}



sub default_template
{
    << 'EOF';

=head1 TITLE PAGE

 Software Test Description (STD)

 for

 Perl ${UUT_PM}

 Revision: ${Revision}

 Date: ${Date}

 Prepared for: ${End_User} 

 Prepared by:  ${Author}

 Classification: ${Classification}

=cut

#######
#  
#  1. SCOPE
#
#  1.1 Identification
#
#  1.2 System overview
#

=head1 SCOPE

This STD establishes the tests to verify
the requirements for the 
Perl L<${UUT_PM}|${UUT_PM}> 

=head2 Identification

This <Software Test Description (STD) 
establihes the tests that verify the requirements
for ${UUT_PM}.

=head2 System overview

The system is the Perl programming language software
established by the L<SEE ALSO|SEE ALSO> references.

=head2 1.3 Document overview

This document establishes the tests to verify the requirements
specified in the Perl Plain Old Documentation (POD)
of the L<${UUT_PM}|${UUT_PM}>.
The L<SEE ALSO|SEE ALSO> references literature on PODs.

The format is a L<2167A|US_DOD::STD2167A> 
L<SVD Data Item Description (DID)|US_DOD::STD
tailored in accordance with the L<Tailor01|Test::Template::Tailor01>
document.

=cut

#######
#
#  3. TEST PREPARATIONS
#
#  3.1 Hardware preparation
#
#  3.2 Software preparation
#
#  3.3 Other pre-test preparations
#
#  3.4. Criteria for evaluating results.
#
#  3.5 Test procedure.
#
#  3.6 Assumptions and constraints.
#

=head1 TEST PREPARATIONS

There are no safety precautions or privacy considerations
for these tests.

=head2 Hardware preparation

Prepare the site hardware by following general
operating procedure to apply power the computer
running Perl under the site operating system.

=head2 Software preparation

There are no preparations. The tests will
determine if the ${UUT_PM} program module is installed.
If any test fails, contact

 ${Author}

for consultation on corrective actions.

=head2 Other pre-test preparations

None.

=head2 Criteria for evaluating results.

The criteria for tests and test cases
is an exact match of the acutual test results
and the expected test results.
The Perl L<Test|Test> module determines whether
the actual test results are exactly the same as the expected
test results. 

=head2 Test procedure.

All test and test cases are performed by running the following test script:

 ${Test_Script}

=head2 Assumptions and constraints.

There are no assumptions or constraints. 

=cut

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

These test descriptions verify the requirments 
as specifed in the L<${UUT_PM}|${UUT_PM}>, 
Plain Old Documentation (POD).
These test descriptions contain ${Tests} tests.

A unique test identification used herein consists of the
the test number that is produce by executing the Perl 
test script file:

 ${Test_Script}

The unique test number id within this module
and the the unique Perl identification for
this module, L<${STD_PM}|${STD_PM}>, 
provide an unique Perl system wide identifier of the test.

There are no safety procautions or security
and privacy considerations for any of the tests
or test cases.

${Test_Descriptions}

^

=cut

#######
#  
#  5. REQUIREMENTS TRACEABILITY
#
#

=head1 REQUIREMENTS TRACEABILITY

 ${Trace_Requirement_Table}

 ${Trace_Test_Table}

=cut

#######
#  
#  6. NOTES
#
#

=head1 NOTES

=head2 Acronyms

This document uses the following acronyms:

=over 4

=item POD

Plain Old Documentation

=item .pm

extension for a Perl Module

=item .t

extension for a Perl test script file

=item .d

extension for a Perl demonstration script file

=item DID

Data Item Description

=back

=head2 Copyright

${Copyright}

#######
#
#  2. REFERENCED DOCUMENTS
#
#
#

=head1 SEE ALSO

${See_Also}

=back

=for html
${HTML}

=cut

}


1


__END__

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

