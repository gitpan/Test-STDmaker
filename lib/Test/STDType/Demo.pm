#!perl
#
# Documentation, copyright and license is at the end of this file.
#
package  Test::STDtype::Demo;

use 5.001;
use strict;
use warnings;
use warnings::register;

use File::Spec;
use File::Glob ':glob';
use File::Spec;
use File::AnySpec;
use File::SmartNL;

use vars qw($VERSION $DATE);
$VERSION = '1.08';
$DATE = '2004/04/09';


########
# Inherit STD::FileGen
#
use Test::STD::FileGen;
use vars qw(@ISA);
@ISA = qw(Test::STD::FileGen);


sub extension { '.d' }


#####
#
# Start generating the file 
#
sub start
{
    my ($self) = @_;

    ###########
    # use in variables without have to backslash escape the dollar sign
    # every which way in the below << here statement
    #   
    my ($test_log,$T) = ('$test_log','$T');
    my ($vol, $dirs, $__restore_dir__, $VERSION, $DATE) = 
      ('$vol', '$dirs', '$__restore_dir__','$VERSION', '$DATE');


    my (undef,undef,$demo_script) = File::Spec->splitpath( $self->{Demo} );
    my $uut = File::AnySpec->fspec2pm($self->{File_Spec}, $self->{UUT}  );

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
$DATE = '$self->{Date}';


##### Demonstration Script ####
#
# Name: $demo_script
#
# UUT: $uut
#
# The module Test::STDmaker generated this demo script from the contents of
#
# $self->{std_pm} 
#
# Don't edit this test script file, edit instead
#
# $self->{std_pm}
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time Test::STDmaker generates this script file.
#
#

######
#
# The working directory is the directory of the generated file
#
use vars qw($__restore_dir__ \@__restore_inc__ );

BEGIN {
    use Cwd;
    use File::Spec;
    use FindBIN;
    use Test::Tech qw(tech_config plan demo skip_tests);

    ########
    # The working directory for this script file is the directory where
    # the test script resides. Thus, any relative files written or read
    # by this test script are located relative to this test script.
    #
    use vars qw( $__restore_dir__ );
    $__restore_dir__ = cwd();
    my ($vol, $dirs) = File::Spec->splitpath(\$FindBin::Bin,'nofile');
    chdir $vol if $vol;
    chdir $dirs if $dirs;

    #######
    # Pick up any testing program modules off this test script.
    #
    # When testing on a target site before installation, place any test
    # program modules that should not be installed in the same directory
    # as this test script. Likewise, when testing on a host with a \@INC
    # restricted to just raw Perl distribution, place any test program
    # modules in the same directory as this test script.
    #
    use lib \$FindBin::Bin;

    unshift \@INC, File::Spec->catdir( cwd(), 'lib' ); 

}

END {

    #########
    # Restore working directory and \@INC back to when enter script
    #
    \@INC = \@lib::ORIG_INC;
    chdir $__restore_dir__;

}

print << 'MSG';

 ~~~~~~ Demonstration overview ~~~~~
 
Perl code begins with the prompt

 =>

The selected results from executing the Perl Code 
follow on the next lines. For example,

 => 2 + 2
 4

 ~~~~~~ The demonstration follows ~~~~~

MSG

EOF

}

sub finish
{
    my ($self) = @_;

    ########
    #  End the test
    #
    my $data = $self->perl_podgen( );
    $data
}



#####
#
# post print processing
#
sub post_print
{
     my ($self) = @_;

     my $module = ref($self);

     unless ($self->{options}->{replace}) {
         @{$self->{$module}->{generated_files}} = ();
         return 1;
     }
 
     my $demo_script = shift @{$self->{$module}->{generated_files}};
     @{$self->{$module}->{generated_files}} = ();
    
     return 1 unless $demo_script;

     ######
     # Generate demo
     #
     my @demo = `perl $demo_script`;
     my $demo = join '',@demo;
     return undef unless $demo;

     $demo =~ s/\n\s+\n/\n\n/g;

     ######
     # Find uut file
     #
     my $uut = $self->{'UUT'};
     unless( $uut ) {
         warn("No UUT specified.\n");
         return undef;
     }
     
     my ($uut_file) = File::Where->where_pm($uut);
     return undef unless $uut_file && -e $uut_file;
     my $uut_contents = File::SmartNL->fin( $uut_file );
     $uut_contents =~ s/(\n=head\d\s+Demonstration).*?\n=/$1\n$demo\n=/si;
     File::SmartNL->fout( $uut_file, $uut_contents);
 
     1   

}



#######
# No processing
#
sub ok { '' }
sub  T { '' }
sub  R { '' }
sub SE { '' }
sub  N { '' }
sub  U { '' }
sub DO { '' }
sub DM { '' }


#####
# Reset verify only
#
sub  E 
{ 
    my ($self) = @_;
    my $module = ref($self);
    $self->{$module}->{'verify_only'} = '';
    ''
}


#######
# Condition to skip a test
#
sub VO
{
    my ($self, $command,$data) = @_;
    my $module = ref($self);
    $self->{$module}->{'verify_only'} = "    $data";
    ''
}


#######
# Condition to skip a test
#
sub S
{
    my ($self, $command,$data) = @_;
    my $module = ref($self);
    return '' if  $self->{$module}->{'verify_only'};
    $self->{$module}->{'skip'} = "    $data";
    ''
}


#########
# Print text string of the Perl expression
# and then execute the expression 
#
sub C
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    return '' if  $self->{$module}->{'verify_only'};
    my $datameta = quotemeta($data);
    my $msg = << "EOF";
demo( \"$datameta\"); # typed in command           
      $data; # execution

EOF

}


#######
# Simulate typing in commands at the terminal
#
sub A
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);

    if ( $self->{$module}->{'verify_only'} ) {
        $self->{$module}->{'verify_only'} = '';
        $self->{$module}->{'skip'} = '';
        return '';
    }

    my $msg;
    my $datameta = quotemeta($data);

   if( $self->{$module}->{'skip'} ) {

       $msg = << "EOF";
demo( \"$datameta\", # typed in command           
      $data # execution
) unless $self->{$module}->{'skip'}; # condition for execution                            

EOF

       $self->{$module}->{'skip'} = '';
   }
   else {

       $msg = << "EOF";
demo( \"$datameta\", # typed in command           
      $data); # execution


EOF
   
  }

  $msg;

}



sub perl_podgen
{
    my ($self) = @_;
    my $module = ref($self);

    my (undef,undef,$demo_script) = File::Spec->splitpath( $self->{'Demo'} );
    my $pm = File::AnySpec->fspec2pm($self->{File_Spec}, $self->{UUT});

    << "EOF";

=head1 NAME

$demo_script - demostration script for $pm

=head1 SYNOPSIS

 $demo_script

=head1 OPTIONS

None.

=head1 COPYRIGHT

$self->{Copyright}

## end of test script file ##

=cut

EOF

}


sub AUTOLOAD
{
    our $AUTOLOAD;
    return undef if $AUTOLOAD =~ /DESTROY/;
    warn "Method $AUTOLOAD not supported by Test::STDtype::Demo";
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

