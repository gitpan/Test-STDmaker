#!perl
#
#

use strict;
use warnings;
use warnings::register;
use 5.001;

use Getopt::Long;
use Test::STDmaker;
use Pod::Usage;

use vars qw($VERSION $DATE);
$VERSION = '1.03';
$DATE = '2003/06/14';

my $output = 'all';
my $man = '0';
my $help = '0';
my %options;
my $list_file;

unless ( GetOptions( 
            'output=s' => \$output,
            'help|?!' => \$help,
            'man!' => \$man,
            'list_file=s' => $list_file,
            'output=s' => \$options{output},
            'replace!' => \$options{replace},
            'nounlink!' => \$options{nounlink},
            'fspec_out!' => \$options{fspec_out},
            'STD2167!' => \$options{STD2167},
            'verbose!' => \$options{verbose},
            'perform|execute|run!' => \$options{run},
            'file_out=s' => \$options{file_out},
           ) ) {
   pod2usage(1);
}

#####
# Help section. Note the pod2usage(2) has big problems
# with the spaces in WIN32 file names. Thus, simply
# supply the perdoc system command directly that
# pod2usage supplies. Actually faster and cleaner.
#
pod2usage(1) if ( $help || !@ARGV);
if($man) {
   system "perldoc \"$0\"";
   exit 1;
}


my @files = @ARGV;
if( $list_file ) {
   if( open LIST, "< $list_file" ) {
       my @list_files = <LIST>;
       push @files,@list_files;
       close LIST;
   }
   else {
      warn( "Cannot open < $list_file\n");
   }
}



#####
# Generate test document.
#
Test::STDmaker->fgenerate(@files, \%options);

__END__


=head1 SYNOPSIS
 
 tg [-help|?] [-man] [-list_file=I<file>] [-out=I<list>] [-dir_path]
    [-replace] [-nounlink] [-fspec_in=I<spec>] [-fspec_out=I<spec>]
    [-verbose] {perform|execute|run] std ... std

=DESCRIPTION

The tg command is a cover command for the following function:

    STD::TestGen->fgenerate(@files, \%options);

See L<STD::TestGen|STD::TestGen>

=OPTIONS

For all options not listed, see L<STD::TestGen|STD::TestGen/Options>

=over 4

=item C<-help|?>  

This option tells C<sdbuild> to output this 
Plain Old Documentation (POD) SYNOPSIS and OPTIONS 
instead of its normal processing.

=item C<-man>

This option tells C<sdbuild> to output all of this 
Plain Old Documentation (POD) 
instead of its normal processing.

=item C<-list_file>

Add the files in the list file to the std .. std files.

=back

=head1 NOTES

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
L<STD|US_DOD::STD>
L<SVD|US_DOD::SVD>
L<DOD STD 490A|US_DOD::STD490A>
L<DOD STD 2167A|US_DOD::STD2167A>

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


















