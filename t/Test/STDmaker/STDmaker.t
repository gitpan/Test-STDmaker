#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE);
$VERSION = '0.04';   # automatically generated file
$DATE = '2003/06/21';
$FILE = __FILE__;

use Test::Tech;
use Getopt::Long;
use Cwd;
use File::Spec;
use File::FileUtil;

##### Test Script ####
#
# Name: STDmaker.t
#
# UUT: Test::STDmaker
#
# The module Test::STDmaker generated this test script from the contents of
#
# t::Test::STDmaker::STDmaker;
#
# Don't edit this test script file, edit instead
#
# t::Test::STDmaker::STDmaker;
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time Test::STDmaker generates this script file.
#
#

######
#
# T:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
BEGIN { 
   use vars qw( $__restore_dir__ @__restore_inc__);

   ########
   # Working directory is that of the script file
   #
   $__restore_dir__ = cwd();
   my ($vol, $dirs, undef) = File::Spec->splitpath( __FILE__ );
   chdir $vol if $vol;
   chdir $dirs if $dirs;

   #######
   # Add the library of the unit under test (UUT) to @INC
   #
   @__restore_inc__ = File::FileUtil->test_lib2inc();

   unshift @INC, File::Spec->catdir( cwd(), 'lib' ); 

   ##########
   # Pick up a output redirection file and tests to skip
   # from the command line.
   #
   my $test_log = '';
   GetOptions('log=s' => \$test_log);

   ########
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   require Test::Tech;
   Test::Tech->import( qw(plan ok skip skip_tests tech_config) );
   plan(tests => 13);

}



END {

   #########
   # Restore working directory and @INC back to when enter script
   #
   @INC = @__restore_inc__;
   chdir $__restore_dir__;
}

   # Perl code from C:
    use vars qw($loaded);
    use File::Glob ':glob';
    use File::Copy;
    use File::FileUtil;
    use Test::STD::Scrub;
 
    #########
    # For "TEST" 1.24 or greater that have separate std err output,
    # redirect the TESTERR to STDOUT
    #
    my $restore_testerr = tech_config( 'Test.TESTERR', \*STDOUT );   

    my $internal_number = tech_config('Internal_Number');
    my $fu = 'File::FileUtil';
    my $s = 'Test::STD::Scrub';
    my $tgB0_pm = ($internal_number eq 'string') ? 'tgB0s.pm' : 'tgB0n.pm';
    my $tgB2_pm = ($internal_number eq 'string') ? 'tgB2s.pm' : 'tgB2n.pm';
    my $tgB2_txt = ($internal_number eq 'string') ? 'tgB2s.txt' : 'tgB2n.txt';

    my $test_results;
    my $loaded = 0;
    my @outputs;

   # Perl code from C:
    use File::Copy;

    @outputs = bsd_glob( 'tg*1.*' );
    unlink @outputs;

    #### 
    #  Use the test software to generate the test of the test software
    #   
    #  tg -o="clean all" TestGen
    # 
    #  0 - series is used to generate an test case test script
    #
    #      generate all output files by 
    #          tg -o=clean TestGen0 TestGen1
    #          tg -o=all TestGen1
    #
    #  1 - this is the actual value test case
    #      thus, TestGen1 is used to produce actual test results
    #
    #  2 - this series is the expected test results
    # 
    #
    # make no residue outputs from last test series
    #
    #  unlink <tg1*.*>;  causes subsequent bsd_blog calls to crash
    #;

ok(  $loaded = $fu->is_package_loaded('Test::STDmaker'), # actual results
      '', # expected results
     '',
     'UUT not loaded');

#  ok:  1

   # Perl code from C:
my $errors = $fu->load_package( 'Test::STDmaker' );


####
# verifies requirement(s):
# L<Test::STDmaker/load [1]>
# 

#####
skip_tests( 1 ) unless skip(
      $loaded, # condition to skip test   
      $errors, # actual results
      '',  # expected results
      '',
      'Load UUT');
 
#  ok:  2


####
# verifies requirement(s):
# L<Test::STDmaker/pod check [2]>
# 

#####
ok(  $fu->pod_errors( 'Test::STDmaker'), # actual results
     0, # expected results
     '',
     'No pod errors');

#  ok:  3

   # Perl code from C:
    copy 'tgA0.pm', 'tgA1.pm';
    Test::STDmaker->fgenerate('t::Test::STDmaker::tgA1', {output=>'STD'});


####
# verifies requirement(s):
#     L<Test::STDmaker/clean FormDB [1]>
#     L<Test::STDmaker/clean FormDB [2]>
#     L<Test::STDmaker/clean FormDB [3]>
#     L<Test::STDmaker/clean FormDB [4]>
#     L<Test::STDmaker/file_out option [1]>
# 

#####
ok(  $s->scrub_date_version($fu->fin('tgA1.pm')), # actual results
     $s->scrub_date_version($fu->fin('tgA2.pm')), # expected results
     '',
     'Clean STD pm with a todo list');

#  ok:  4

   # Perl code from C:
    copy $tgB0_pm, 'tgB1.pm';
    Test::STDmaker->fgenerate('t::Test::STDmaker::tgB1', {output=>'STD verify'});


####
# verifies requirement(s):
#     L<Test::STDmaker/clean FormDB [1]>
#     L<Test::STDmaker/clean FormDB [2]>
#     L<Test::STDmaker/clean FormDB [3]>
#     L<Test::STDmaker/clean FormDB [4]>
#     L<Test::STDmaker/file_out option [1]>
# 

#####
ok(  $s->scrub_date_version($fu->fin('tgB1.pm')), # actual results
     $s->scrub_date_version($fu->fin($tgB2_pm)), # expected results
     '',
     'clean STD pm without a todo list');

#  ok:  5

   # Perl code from C:
    $test_results = `perl tgB1.t`;
    $fu->fout('tgB1.txt', $test_results);

ok(  $s->scrub_probe($s->scrub_file_line($test_results)), # actual results
     $s->scrub_probe($s->scrub_file_line($fu->fin($tgB2_txt))), # expected results
     '',
     'Generated and execute the test script');

#  ok:  6

   # Perl code from C:
    #####
    # Make sure there is no residue outputs hanging
    # around from the last test series.
    #
    @outputs = bsd_glob( 'tg*1.*' );
    unlink @outputs;
    copy 'tgA0.pm', 'tgA1.pm';
    Test::STDmaker->fgenerate('t::Test::STDmaker::tgA1');


####
# verifies requirement(s):
#     L<Test::STDmaker/clean FormDB [1]>
#     L<Test::STDmaker/clean FormDB [2]>
#     L<Test::STDmaker/clean FormDB [3]>
#     L<Test::STDmaker/clean FormDB [4]>
#     L<Test::STDmaker/STD PM POD [1]>
# 

#####
ok(  $s->scrub_date_version($fu->fin('tgA1.pm')), # actual results
     $s->scrub_date_version($fu->fin('tgA2.pm')), # expected results
     '',
     'Cleaned tgA1.pm');

#  ok:  7

   # Perl code from C:
    $test_results = `perl tgA1.d`;
    $fu->fout('tgA1.txt', $test_results);


####
# verifies requirement(s):
#     L<Test::STDmaker/demo file [1]>
#     L<Test::STDmaker/demo file [2]>
# 

#####
ok(  $test_results, # actual results
     $fu->fin('tgA2A.txt'), # expected results
     '',
     'Demonstration script');

#  ok:  8

   # Perl code from C:
    $test_results = `perl tgA1.t`;
    $fu->fout('tgA1.txt', $test_results);


####
# verifies requirement(s):
#     L<Test::STDmaker/verify file [1]>
#     L<Test::STDmaker/verify file [2]>
#     L<Test::STDmaker/verify file [3]>
# 

#####
ok(  $s->scrub_probe($s->scrub_file_line($test_results)), # actual results
     $s->scrub_probe($s->scrub_file_line($fu->fin('tgA2B.txt'))), # expected results
     '',
     'Generated and execute the test script');

#  ok:  9

   # Perl code from C:
    #########
    #
    # Individual generate outputs using options
    #
    ########
    #####
    # Make sure there is no residue outputs hanging
    # around from the last test series.
    #
    @outputs = bsd_glob( 'tg*1.*' );
    unlink @outputs;
    copy 'tg0.pm', 'tg1.pm';
    copy 'tgA0.pm', 'tgA1.pm';
    my @cwd = File::Spec->splitdir( cwd() );
    pop @cwd;
    pop @cwd;
    unshift @INC, File::Spec->catdir( @cwd );  # put UUT in lib path
    Test::STDmaker->fgenerate('t::Test::STDmaker::tgA1', { output=>'demo', replace => 1});
    shift @INC;

ok(  $s->scrub_date_version($fu->fin('tg1.pm')), # actual results
     $s->scrub_date_version($fu->fin('tg2.pm')), # expected results
     '',
     'Generate and replace a demonstration');

#  ok:  10

   # Perl code from C:
    no warnings;
    open SAVEOUT, ">&STDOUT";
    use warnings;
    open STDOUT, ">tgA1.txt";
    Test::STDmaker->fgenerate('t::Test::STDmaker::tgA1', { output=>'verify', run=>1, verbose=>1});
    close STDOUT;
    open STDOUT, ">&SAVEOUT";
    
    ######
    # For some reason, test harness puts in a extra line when running u
    # under the Active debugger on Win32. So just take it out.
    # Also the script name is absolute which is site dependent.
    # Take it out of the comparision.
    #
    $test_results = $fu->fin('tgA1.txt');
    $test_results =~ s/.*?1..9/1..9/; 
    $test_results =~ s/------.*?\n(\s*\()/\n $1/s;
    $fu->fout('tgA1.txt',$test_results);


####
# verifies requirement(s):
#     L<Test::STDmaker/verify file [1]>
#     L<Test::STDmaker/verify file [2]>
#     L<Test::STDmaker/verify file [3]>
#     L<Test::STDmaker/verify file [4]>
#     L<Test::STDmaker/execute [3]>
#     L<Test::STDmaker/execute [4]>
# 

#####
ok(  $s->scrub_probe($s->scrub_test_file($s->scrub_file_line($test_results))), # actual results
     $s->scrub_probe($s->scrub_test_file($s->scrub_file_line($fu->fin('tgA2C.txt')))), # expected results
     '',
     'Generate and verbose test harness run test script');

#  ok:  11

   # Perl code from C:
    no warnings;
    open SAVEOUT, ">&STDOUT";
    use warnings;
    open STDOUT, ">tgA1.txt";
    $main::SIG{__WARN__}=\&__warn__; # kill pesty Format STDOUT and Format STDOUT_TOP redefined
    Test::STDmaker->fgenerate('t::Test::STDmaker::tgA1', { output=>'verify', run=>1});
    $main::SIG{__WARN__}=\&CORE::warn;
    close STDOUT;
    open STDOUT, ">&SAVEOUT";

    ######
    # For some reason, test harness puts in a extra line when running u
    # under the Active debugger on Win32. So just take it out.
    # Also with absolute file, the file is chopped off, and see
    # stuff that is site dependent. Need to take it out also.
    #
    $test_results = $fu->fin('tgA1.txt');
    $test_results =~ s/.*?FAILED/FAILED/; 
    $test_results =~ s/(\)\s*\n).*?\n(\s*\()/$1$2/s;
    $fu->fout('TgA1.txt',$test_results);


####
# verifies requirement(s):
#     L<Test::STDmaker/verify file [1]>
#     L<Test::STDmaker/verify file [2]>
#     L<Test::STDmaker/verify file [3]>
#     L<Test::STDmaker/execute [3]>
# 

#####
ok(  $test_results, # actual results
     $fu->fin('tgA2D.txt'), # expected results
     '',
     'Generate and test harness run test script');

#  ok:  12

   # Perl code from C:
    copy 'tgC0.pm', 'tgC1.pm';
    Test::STDmaker->fgenerate('t::Test::STDmaker::tgC1', {fspec_out=>'os2',  output=>'STD'});


####
# verifies requirement(s):
# L<Test::STDmaker/fspec_out option [6]>
# 

#####
ok(  $s->scrub_date_version($fu->fin('tgC1.pm')), # actual results
     $s->scrub_date_version($fu->fin('tgC2.pm')), # expected results
     '',
     'Change File Spec');

#  ok:  13

   # Perl code from C:
    #####
    # Make sure there is no residue outputs hanging
    # around from the last test series.
    #
    @outputs = bsd_glob( 'tg*1.*' );
    unlink @outputs;
    tech_config( 'Test.TESTERR', $restore_testerr);   


    sub __warn__ 
    { 
       my ($text) = @_;
       return $text =~ /STDOUT/;
       CORE::warn( $text );
    };


=head1 NAME

STDmaker.t - test script for Test::STDmaker

=head1 SYNOPSIS

 STDmaker.t -log=I<string>

=head1 OPTIONS

All options may be abbreviated with enough leading characters
to distinguish it from the other options.

=over 4

=item C<-log>

STDmaker.t uses this option to redirect the test results 
from the standard output to a log file.

=back

=head1 COPYRIGHT

copyright � 2003 Software Diamonds.

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

\=over 4

\=item 1

Redistributions of source code, modified or unmodified
must retain the above copyright notice, this list of
conditions and the following disclaimer. 

\=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

\=back

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

=cut

## end of test script file ##

