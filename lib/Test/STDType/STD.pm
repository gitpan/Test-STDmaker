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

use DataPort::FileType::FormDB;
use File::AnySpec;
use Test::STD::STDutil;
use File::Package;
use File::Data;

use vars qw($VERSION $DATE);
$VERSION = '1.05';
$DATE = '2003/07/04';

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

    $module_db->{trace_req} = {};
    $module_db->{trace_test} = {};
    $module_db->{requirements} = [];
    $self->{Test_Descriptions} = '';
    $module_db->{test} = '';

    my $dbh = new  DataPort::FileType::FormDB();

    my $fields = "\n";
    my $fspec_out = $self->{options}->{fspec_out};
    $fspec_out = 'Unix' unless $fspec_out;
    my $file_out;
    foreach my $item (@{$self->{required_data}}) {
        next if $item eq 'Copyright' || $item eq 'See_Also' || $item eq 'HTML';
        if( $item eq 'File_Spec') {
             $dbh->encode_field( ['File_Spec', $fspec_out], \$fields);
             next;
        }
        elsif( $item eq 'Temp') {
            $file_out = File::AnySpec->fspec2os($fspec_out, $self->{Temp});
            $dbh->encode_field( ['Temp', $file_out], \$fields);
            next;
        }
        $dbh->encode_field( [$item, $self->{$item}], \$fields);
    }

    #########
    # 
    #
    my ($package);
    foreach my $generator (@{$self->{generators}}) {
        $package = "Test::STDtype::" . $generator;        
        next if $package->can( 'file_out' );
        $file_out = File::AnySpec->fspec2os($fspec_out, $self->{$generator});
        $dbh->encode_field( [$generator, $file_out], \$fields);
    }

    $fields .= "\n\n";
    $module_db->{fields} = $fields;
    $module_db->{dbh} = $dbh;
    ''

} 

sub finish
{
    my ($self) = @_;
    my $module = ref($self);
    my $module_db = $self->{$module};
    my $std_db = $self->{std_db};

    my $dbh = $module_db->{dbh};
       
    my $fields = "\n";
    $dbh->encode_field( ['See_Also', $self->{'See_Also'}], \$fields );
    $dbh->encode_field( ['Copyright', $self->{'Copyright'}], \$fields );
    $dbh->encode_field( ['HTML', $self->{'HTML'}], \$fields );
    $fields  .= "\n\n";
    $fields  = $module_db->{fields} . $fields;
    $module_db->{fields} = '';

    my $record = '';
    $dbh->encode_record(\$fields, \$record);
    $dbh->finish();
    $record = "__DATA__\n" . $record;

    my $header = <<"EOF";      
#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
package  $self->{std_pm};

EOF

    $header .= <<'EOF';      
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE );
$VERSION = '0.01';
$DATE = '2003/06/07';
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

EOF

    ######
    # Build macro substitutes
    #
    $self->{Trace_Requirement_Table} = "No requirements specified.\n";
    if( $module_db->{trace_req} ) {
       $self->{Trace_Requirement_Table} = Test::STD::STDutil->format_hash_table( $module_db->{trace_req}, [64,64], ["Requirement", "Test"] );
       $module_db->{trace_req} = {};
    }

    $self->{Trace_Test_Table} = '';
    if( $module_db->{trace_test} ) {
       $self->{Trace_Test_Table} = Test::STD::STDutil->format_hash_table( $module_db->{trace_test}, [64,64], ["Test", "Requirement"] );
       $module_db->{trace_test} = {};
    }

    $self->{Test_Descriptions} =~ s/\n \n/\n\n/g; # no white space lines
 
    #########
    # Get the STD detail template
    #  
    my ($error, $template_contents);
    if( $self->{Detail_Template} ) {
        $error = File::Package->load_package( $self->{Detail_Template} );
        $template_contents = File::Data->pm2data( $self->{Detail_Template} );
    }
    $template_contents = default_template() unless $template_contents;

    my @vars = qw(UUT Revision Date End_User Author Classification
      Copyright See_Also Test_Descriptions Version
      Trace_Requirement_Table Trace_Test_Table HTML);

    Test::STD::STDutil->replace_variables(\$template_contents, $self, \@vars);

    $template_contents =~ s/\n\\=/\n=/g; # unescape POD directives
    $template_contents =~ s/\n \n/\n\n/g; # no white space lines

    $header . $template_contents . $record;

}


sub T
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    my $module_db = $self->{$module};
    $self->format( $command, $data );
    $self->{Test_Descriptions} .= "=head2 Test Plan\n\n" . $module_db->{test} . "\n";
    $module_db->{test} = '';
    ''
}

sub R
{

    my ($self, $command, $data) = @_;
    my $module = ref($self);
    while( chomp $data ) {};
    my @data = split /(?:,|;|\n)+/, $data;
    push @{$self->{$module}->{requirements}}, @data;
    $self->format( $command, $data );
    ''
}


sub N
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    $self->{$module}->{name} = $data;
    $self->format( $command, $data );
    ''
}


sub ok 
{
    my ($self, $command, $test_nums) = @_;
    my $module = ref($self);
    my $module_db = $self->{$module};

    my $trace_req_p = $module_db->{trace_req};
    my $trace_test_p = $module_db->{trace_test};

    my @test_num = split /[ ;,]/, $test_nums;
    my $std_pm = $self->{std_pm};

    my $test_num;
    for $test_num (@test_num) {

        ######
        # Provide a link to this test for each data requirement
        # for later output of tracebility matrices. 
        #
        # Tracebility matrices are very important for bean counters
        # who do not understand the code.
        # 
        # 
        my $requirement;
        foreach $requirement (@{$module_db->{requirements}}) {
            ($requirement) = $requirement =~ /^\s*(.*)\s*$/; # remove leading and tailing white space
            next unless $requirement;

            #####
            # Enter test into trace requirement matrix hash
            #
            $trace_req_p->{$requirement}->{"L<$std_pm/ok: $test_nums>"} = undef;

            ######
            # Enter requirement into trace test matrix hash
            #  
            $trace_test_p->{"L<$std_pm/ok: $test_nums>"}->{$requirement} = undef;
        }  

    }
    $module_db->{name} = '';
    $module_db->{requirements} = [];

    $self->format( $command, $test_nums );

    $self->{Test_Descriptions} .= "=head2 ok: $test_nums\n\n";
    $self->{Test_Descriptions} .= ' ' . $module_db->{test} . "\n";
    $module_db->{test} = '';

    ''
}


sub format
{

    my ($self, $command, $data) = @_;
    my $module = ref($self);
    my $module_db = $self->{$module};

    my $precision   = $self->{precision};
    $precision = 2 unless $precision;
    $command = sprintf("%${precision}s", $command);
    my $field = '';
    $self->{$module}->{dbh}->encode_field( [$command, $data], \$field );            
    $field .= "\n" if ($command =~ /\s*ok\s*/ | $command =~ /\s*T\s*/);
    $self->{$module}->{fields} .= $field;
    $field =~ s/\n/\n /g;   # tell Perl POD it is code
    $field =~ s/\n \n/\n/g; # no white space blank lines
    $module_db->{test} .= $field;
    ''
}


AUTOLOAD
{
    our $AUTOLOAD;
    return '' if $AUTOLOAD =~ /DESTROY/;
    my $self = shift @_;
    $self->format( @_ );

}


#####
#
# Default SVD template
# 
#
sub default_template
{
    <<'EOF';

=head1 TITLE PAGE

 Detailed Software Test Description (STD)

 for

 Perl ${UUT} Program Module

 Revision: ${Revision}

 Version: ${Version}

 Date: ${Date}

 Prepared for: ${End_User} 

 Prepared by:  ${Author}

 Classification: ${Classification}

=head1 SCOPE

This detail STD and the 
L<General Perl Program Module (PM) STD|Test::STD::PerlSTD>
establishes the tests to verify the
requirements of Perl Program Module (PM) L<${UUT}|${UUT}>

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

${Test_Descriptions}

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

EOF

}


1


__END__


=head1 AUTHOR

The holder of the copyright and maintainer is

 E<lt>support@SoftwareDiamonds.comE<gt>

=head2 COPYRIGHT NOTICE

Copyrighted (c) 2002 Software Diamonds

All Rights Reserved

=head2 BINDING REQUIREMENTS NOTICE

Binding requirements are indexed with the
pharse 'shall[dd]' where dd is an unique number
for each header section.
This conforms to standard federal
government practices, 490A (L<STD490A/3.2.3.6>).
In accordance with the License, Software Diamonds
is not liable for any requirement, binding or otherwise.

=head2 LICENSE

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

