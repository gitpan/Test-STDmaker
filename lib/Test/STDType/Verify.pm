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
use File::AnySpec;
use Test::Harness;

use vars qw($VERSION $DATE);
$VERSION = '1.06';
$DATE = '2003/07/04';

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

    $module_db->{'requirement'} = '';
    $module_db->{test_name} = '';



}


sub finish
{
     my ($self) = @_;

    ########
    #  End the test
    #
    $self->podgen( ); 
}


#####
#
# Start generating the file 
#
sub post_generate
{
     my ($self) = @_;

     my $module = ref($self);
     unless ($self->{options}->{run}) {
         @{$self->{$module}->{generated_files}} = ();
         return 1 
     }
     if( $self->{options}->{test_verbose} ) {
         print( "~~~~\nRunning Tests\n\n" );
         $Test::Harness::verbose = 1;
     }
     else {
         $Test::Harness::verbose = 0;
     } 

     ########
     # Run under eval because runtests is loaded with dies
     #
     eval 'runtests( @{$self->{$module}->{generated_files}} )';
     print $@ if $@; # send any die messages to standard out
     @{$self->{$module}->{generated_files}} = ();

     print( "~~~~\nFinished running Tests\n\n" ) if $self->{options}->{test_verbose};

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
    my ($test_log,$work_dir,$lib_dir) = ('$test_log','$work_dir','$lib_dir');
    my ($vol, $dirs, $__restore_dir__) = ('$vol', '$dirs', '$__restore_dir__');
    $@='$@';  # cannot put globals under a my

    my ($tests, $todo ) = split ' - ', $data;

    my $plan = "tests => $tests";
    $plan .= ", todo => [$todo]" if $todo;
    
    my ($VERSION, $DATE, $FILE) = ('$VERSION', '$DATE', '$FILE');

    ######
    # Build reference files
    #
    my (undef,undef,$test_script) = File::Spec->splitpath( $self->{Verify} );
    my $uut = File::AnySpec->fspec2pm($self->{File_Spec},  $self->{UUT}  );


    << "EOF";
#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE);
$VERSION = '0.01';   # automatically generated file
$DATE = '$self->{'Date'}';
$FILE = __FILE__;

use Test::Tech;
use Getopt::Long;
use Cwd;
use File::Spec;
use File::TestPath;

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

######
#
# ${command}:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
BEGIN { 
   use vars qw( $__restore_dir__ \@__restore_inc__);

   ########
   # Working directory is that of the script file
   #
   $__restore_dir__ = cwd();
   my ($vol, $dirs, undef) = File::Spec->splitpath(__FILE__);
   chdir $vol if $vol;
   chdir $dirs if $dirs;

   #######
   # Add the library of the unit under test (UUT) to \@INC
   #
   \@__restore_inc__ = File::TestPath->test_lib2inc();

   unshift \@INC, File::Spec->catdir( cwd(), 'lib' ); 

   ##########
   # Pick up a output redirection file and tests to skip
   # from the command line.
   #
   my $test_log = '';
   GetOptions('log=s' => \\$test_log);

   ########
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   require Test::Tech;
   Test::Tech->import( qw(plan ok skip skip_tests tech_config) );
   plan($plan);

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
skip_tests( 1 ) unless skip(
      $skip, # condition to skip test   
      $module_db->{actual}, # actual results
      $data,  # expected results
      '',
      '$module_db->{test_name}');
 
EOF
       }
       
       #######
       # ok stop statement
       #
       else {

           $msg .=  << "EOF";
skip_tests( 1 ) unless ok(
      $module_db->{actual}, # actual results
      $data, # expected results
      '',
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
skip( $skip, # condition to skip test   
      $module_db->{actual}, # actual results
      $data, # expected results
      '',
      '$module_db->{test_name}');

EOF
       }
       
       #######
       # ok statement
       #
       else {

           $msg .=  << "EOF";
ok(  $module_db->{actual}, # actual results
     $data, # expected results
     '',
     '$module_db->{test_name}');

EOF
       }
   }

   $module_db->{test_name} = '';
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

