#!perl
#
# Documentation, copyright and license is at the end of this file.
#

package  Test::STDtype::Verify;

use 5.001;
use strict;
use warnings;
use warnings::register;

use File::Spec;
use Test::TestUtil;
use Test::Harness;

use vars qw($VERSION $DATE);
$VERSION = '1.04';
$DATE = '2003/06/14';

########
# Inherit Test::STD::FileGen
#
use Test::STD::FileGen;
use vars qw(@ISA);
@ISA = qw(Test::STD::FileGen);


sub extension { '.t' };

sub start
{
    my ($self) = @_;
    my $module = ref($self);
    my $module_db = $self->{$module};

    my ($VERSION, $DATE) = ('$VERSION', '$DATE');

    $module_db->{'requirement'} = '';
    $module_db->{test_name} = '';

    ######
    # Build reference files
    #
    my (undef,undef,$test_script) = File::Spec->splitpath( $self->{Verify} );
    my $uut = Test::TestUtil->fspec2pm($self->{File_Spec},  $self->{UUT}  );


    << "EOF";
#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.01';   # automatically generated file
$DATE = '$self->{'Date'}';

use Test::Tech;
use Getopt::Long;
use Cwd;
use File::Spec;

##### Test Script ####
#
# Name: $test_script
#
# UUT: $uut
#
# The module Test::STDmaker generated this test script from the contents of
#
# $self->{std_pm};
#
# Don't edit this test script file, edit instead
#
# $self->{std_pm};
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time Test::STDmaker generates this script file.
#
#

EOF

}


sub finish
{
     my ($self) = @_;

    ########
    #  End the test
    #
    my $data =  "\n\$T->finish();\n\n";
    $data .= $self->podgen( ); 
    $data;
}


#####
#
# Start generating the file 
#
sub post_generate
{
     my ($self) = @_;

     return 1 unless $self->{options}->{run};

     my $module = ref($self);

     print( "~~~~\nRunning Tests\n\n" ) if $self->{options}->{verbose};

     $Test::Harness::verbose = $self->{options}->{verbose};

     ########
     # Run under eval because runtests is loaded with dies
     #
     eval 'runtests( @{$self->{$module}->{generated_files}} )';
     print $@ if $@; # send any die messages to standard out
     @{$self->{$module}->{generated_files}} = ();

}


sub VO { '' }

#######
# Condition to skip a test
#
sub DO
{
    my ($self, $command,$data) = @_;
    my $module = ref($self);
    $self->{$module}->{demo_only} = "    $data";
    ''
}


sub T
{
    my ($self, $command, $data) = @_;

    ###########
    # use in variables without have to backslash escape the dollar sign
    # every which way in the below << here statement
    #   
    my ($test_log,$T,$work_dir,$lib_dir) = ('$test_log','$T','$work_dir','$lib_dir');
    my ($vol, $dirs, $__restore_dir__) = ('$vol', '$dirs', '$__restore_dir__');
    $@='$@';  # cannot put globals under a my

    my ($tests, $todo ) = split ' - ', $data;

    my $plan = "tests => $tests";
    $plan .= ", todo => [$todo]" if $todo;
    

    << "EOF";
######
#
# ${command}:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
BEGIN { 
   use vars qw( $T $__restore_dir__ \@__restore_inc__);

   ##########
   # Pick up a output redirection file and tests to skip
   # from the command line.
   #
   my $test_log = '';
   GetOptions('log=s' => \\$test_log);

   ########
   # Start a test with a new tech
   #
   $T = new Test::Tech( $test_log );

   ########
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   $T->work_breakdown($plan);

   ########
   # Working directory is that of the script file
   #
   $__restore_dir__ = cwd();
   my ($vol, $dirs, undef) = File::Spec->splitpath( \$0 );
   chdir $vol if $vol;
   chdir $dirs if $dirs;

   #######
   # Add the library of the unit under test (UUT) to @INC
   #
   \@__restore_inc__ = $T->test_lib2inc();

}

END {

   #########
   # Restore working directory and \@INC back to when enter script
   #
   \@INC = \@__restore_inc__;
   chdir $__restore_dir__;
}

EOF

}


sub N 
{ 
   my ($self, $command, $data) = @_;
   my $module = ref($self);
   return '' if  $self->{$module}->{demo_only};
   $self->{$module}->{test_name} = $data;
   '' 
};


sub ok
{
   my ($self, $command,$data) = @_;

   << "EOF";
#  ${command}:  $data

EOF

}

sub U
{
   my ($self, $command,$data) = @_;
   my $module = ref($self);
   return '' if  $self->{$module}->{demo_only};

   << "EOF";
###
#  $data
#  Under development, i.e todo
EOF

}


sub R
{
   my ($self, $command,$data) = @_;
   my $module = ref($self);
   return '' if  $self->{$module}->{demo_only};

   ######
   # Accumulate for the next expected statement
   #
   $data .= "\n" if substr( $data, length($data)-1,1) ne "\n";
   $self->{$module}->{'requirement'} .= "$data";
   '';
}


sub S
{
   my ($self, $command,$data) = @_;
   my $module = ref($self);
   $self->{$module}->{skip} = $data;
   '';
}


sub C
{
   my ($self, $command, $data) = @_;
   my $module = ref($self);

   $data .= ';' if substr( $data, length($data)-1,1) ne ';';

   << "EOF";
   # Perl code from ${command}:
$data

EOF
 
}


sub A
{
   my ($self, $command,$data) = @_;
   my $module = ref($self);
   my $module_db = $self->{$module};
   if ( $module_db->{demo_only} ) {
       $module_db->{requirement} = '';
       $module_db->{demo_only} = '';
       $module_db->{demo_only_expected} = 1;
       $module_db->{skip} = '';
       $module_db->{test_name} = '';
       return '';
   }
   $module_db->{demo_only_expected} = '';

   ######
   # Save for expected the next statement
   #
   $self->{$module}->{actual} = $data;

   ''  # writing actual out in the expected statement
}


sub SE { E(@_) };
sub E
{
   my ($self, $command, $data) = @_;
   my $module = ref($self);
   my $module_db = $self->{$module};

   if ( $module_db->{demo_only_expected} ) {
       $module_db->{requirement} = '';
       $module_db->{demo_only_expected} = '';
       $module_db->{skip} = '';
       $module_db->{test_name} = '';
       return '';
   }

   my $T = '$T';
   my $msg = '';

   my $skip = $module_db->{skip};
   my $requirement = $module_db->{requirement};
   $module_db->{skip} = '';
   $module_db->{requirement} = '';

   if($requirement) {
       $requirement =~ s/\n/\n# /g;
       $msg = "\n####\n# verifies requirement(s):\n# $requirement\n\n#####\n";
   }

   if(  $command eq 'SE' ) {

       #######
       # Skip stop statement
       #
       if( $skip ) {
           $msg .=  << "EOF";
$T->skip_rest() unless $T->verify(
    $skip, # condition to skip test   
    [$module_db->{actual}], # actual results
    [$data],  # expected results
    '$module_db->{test_name}');
 
EOF
       }
       
       #######
       # ok stop statement
       #
       else {

           $msg .=  << "EOF";
$T->skip_rest() unless $T->test(
    [$module_db->{actual}], # actual results
    [$data], # expected results
    '$module_db->{test_name}'); 

EOF

       }
  

   }
   else {

       #######
       # Skip ok statement
       #
       if( $skip ) {
           $msg .=  << "EOF";
$T->verify( $skip, # condition to skip test   
            [$module_db->{actual}], # actual results
            [$data], # expected results
            '$module_db->{test_name}');

EOF
       }
       
       #######
       # ok statement
       #
       else {

           $msg .=  << "EOF";
$T->test( [$module_db->{actual}], # actual results
          [$data], # expected results
          '$module_db->{test_name}');

EOF
       }
       $self->{test_name} = '';
   }

   $msg;

}



sub podgen
{

    my ($self) = @_;

    my (undef,undef,$test_script) = File::Spec->splitpath( $self->{'Verify'} );

    my $msg = << "EOF";

=head1 NAME

$test_script - test script for $self->{UUT}

=head1 SYNOPSIS

 $test_script -log=I<string>

=head1 OPTIONS

All options may be abbreviated with enough leading characters
to distinguish it from the other options.

=over 4

=item C<-log>

$test_script uses this option to redirect the test results 
from the standard output to a log file.

=back

=head1 COPYRIGHT

$self->{Copyright}

=cut

## end of test script file ##

EOF

}

sub AUTOLOAD
{
    our $AUTOLOAD;
    return undef if $AUTOLOAD =~ /DESTROY/;
    warn "Method $AUTOLOAD not supported by STD::Gen::Verify";
    undef;
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

L<Test|Test> 
L<Test::Harness|Test::Harness> 
L<tg|STD::t::tg>
L<STDtailor|STD::STDtailor>
L<STD|Military::STD>
L<SVD|Military::SVD>
L<DOD STD 490A|Military::STD490A>
L<DOD STD 2167A|Military::STD2167A>

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

