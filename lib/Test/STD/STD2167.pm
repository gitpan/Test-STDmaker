#!perl
#
# Documentation, copyright and license is at the end of this file.
#
###########################

package  Test::STDtype::STD;

use 5.001;
use strict;
use warnings;
use warnings::register;

use File::Spec;
use vars qw($VERSION $DATE);
use Cwd;
use DataPort::FileType::FormDB;
use Test::STD::STDgen;

$VERSION = '1.04';
$DATE = '2003/07/05';

########
# Inherit Test::STD::FileGen
#
use Test::STD::FileGen;
use vars qw(@ISA);
@ISA = qw(Test::STD::FileGen);

use vars qw(@required_data_base); 
@required_data_base = qw(
    File_Spec UUT Revision End_User Author
    SVD Template Classification Temp See_Also Copyright);

sub extension { '.pm' }
sub file_out { $_[0]->{std_file} }

sub start
{

    my ($self) = @_;
    my $module = ref($self);

    #######
    # Create a temporary script
    #
    $self->{'STD::STDgen'}->{file_out} = $self->{$module}->{file_out};
    $self->{Temp} = 'temp.pl' unless $self->{'Temp'};
    $self->{$module}->{file_out} = $self->{'Temp'};
    $self->{$module}->{skip} = '';

    ###########
    # use in variables without have to backslash escape the dollar sign
    # every which way in the below << here statement
    #   
    my ($__test__, $__restore_dir__) = ('$__test__', '$__restore_dir__');
    my ($vol, $dirs, $T) = ('$vol', '$dirs', '$T');

    << "EOF";
#!perl
#
#
use Cwd;
use File::Spec;
use DataPort::FileType::FormDB;
use Data::Dumper;
use STD::Tester;

BEGIN { 

   use vars qw(%__tests__ $__test__ $__restore_dir__);

   $__test__ = 0;

   ########
   # Start a test with a new tester
   #
   $T = new STD::Tester(  );

   ########
   # Working directory is that of the script file
   #
   $__restore_dir__ = cwd();
   my ($vol, $dirs, undef) = File::Spec->splitpath( \$0 );
   chdir $vol if $vol;
   chdir $dirs if $dirs;

}

END {

   #########
   # Restore working directory back to when enter script
   #
   chdir $__restore_dir__;
}

EOF


}

sub finish { 

  << 'EOF';  
  
######
# Actual, expected data
#
sub __std_command__
{
   my ($command, $data) = @_;

   my $dbh = new DataPort::FileType::FormDB( );
   my $encode = '';
   $dbh->encode_field( [$command, $data], \$encode );
   print $encode;
}


######
# Psudeo linearize the actual, expected data
#
sub __std_test__
{
   my ($test, $command, $actual, $expected, $skip, $reason) = @_;
  
   $Data::Dumper::Terse = 1;
   $expected = Dumper(@$expected);
   $expected =~ s/(\n+)/$1 /g;
   $expected =~ s/\\\\/\\/g;
   $expected =~ s/\\'/'/g;
   $expected =~ s/^\s*(.*?)\s*$/$1/s;

   my $dbh = new DataPort::FileType::FormDB( );
   my $encode = '';
   if( $skip ) {
       $reason = '' unless $reason;
       $dbh->encode_field( ['S', '1', 'A', $actual, $command, $reason, 'ok', $test], \$encode );
   }
   else {
       $dbh->encode_field( ['A', $actual, $command, $expected, 'ok', $test], \$encode );
   }
   print $encode;

}

EOF

}   

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

sub A
{
   my ($self, $command,$data) = @_;
   my $module = ref($self);
   my $module_db = $self->{$module};
   return '' if $module_db->{demo_only};

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

    if ( $module_db->{demo_only} ) {
        $module_db->{demo_only} = '';
        return '';
    }

    my ($T,$__test__) = ('$T','$__test__');
    my $actualmeta = quotemeta($module_db->{actual});
    $module_db->{actual} = '';
    my $skip = $module_db->{skip};
    my $skipmeta = quotemeta($skip);
    $module_db->{skip} = '';
    unless( $skip ) {
        $skip = 0;
        $skipmeta = '0';
    }
    
    << "EOF";
__std_test__( ++$__test__, $command,
          "$actualmeta", # actual results
          [$data], # expected results
          $skip, $skipmeta); 
EOF

}


sub VO { '' }
sub ok { '' }
sub U { R(@_) }
sub T { R(@_) }
sub  N { R(@_) }

sub  R
{ 
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    return '' if $self->{$module}->{demo_only};

    my $datameta = quotemeta($data);
    << "EOF";
__std_command__( $command, "$datameta"); 

EOF

};


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
    push @{$self->{$module}->{test_db}}, ($command, $data);

    $data .= ';' if substr( $data, length($data)-1,1) ne ';';
    my $datameta = quotemeta($data);
    my $T = '$T';

    << "EOF";
   # Perl code from ${command}:
$data
__std_command__( $command, "$datameta"); 

EOF
 
}


#####
#
# post print processing
#
sub post_print
{

    my ($self) = @_;
    my $module = ref($self);

    my $std = `perl $self->{$module}->{file_out}`;
    unlink $self->{$module}->{file_out} unless $self->{options}->{nounlink};

    my $dbh = new DataPort::FileType::FormDB;
    my $old_std_db = $self->{std_db};
    $self->{std_db} = [];  # new array reference
    $dbh->decode_field( \$std, $self->{std_db} );

    my $old_class = ref($self);
    $self = bless $self,'STD::STDgen'; # change the class
    return undef unless $self->generate( );
    return undef unless $self->print( );
    $self = bless $self,$old_class;  # restore the original class
    $self->{std_db} = $old_std_db;
   
    1

}

1

__END__

=head1 NOTES

=head2 Author

The holder of the copyright and maintainer is

 E<lt>support@SoftwareDiamonds.comE<gt>

=head2 Copyright

Copyrighted (c) 2002 Software Diamonds

All Rights Reserved

=head2 Binding Requirements

Binding requirements are indexed with the
pharse 'shall[dd]' where dd is an unique number
for each header section.
This conforms to standard federal
government practices, 490A (L<STD490A/3.2.3.6>).
In accordance with the License, Software Diamonds
is not liable for any requirement, binding or otherwise.

=head2 License

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

=over 4

=item 1

Redistributions of source code must retain
the above copyright notice, this list of
conditions and the following disclaimer. 

=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

=back

SOFTWARE DIAMONDS PROVIDES THIS SOFTWARE 
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

=for html
<p><br>
<!-- BLK ID="HEALTH_PITCH_NOTEXT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="EMAIL" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="COPYRIGHT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut


### end of file ###

