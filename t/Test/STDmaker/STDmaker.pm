#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
package  t::Test::STDmaker::STDmaker;

use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE );
$VERSION = '0.14';
$DATE = '2004/05/23';
$FILE = __FILE__;

########
# The Test::STDmaker module uses the data after the __DATA__ 
# token to automatically generate the this file.
#
# Do not edit anything before __DATA_. Edit instead
# the data after the __DATA__ token.
#
# ANY CHANGES MADE BEFORE the  __DATA__ token WILL BE LOST
#
# the next time Test::STDmaker generates this file.
#
#


=head1 NAME

t::Test::STDmaker::STDmaker - Software Test Description for Test::STDmaker

=head1 TITLE PAGE

 Detailed Software Test Description (STD)

 for

 Perl Test::STDmaker Program Module

 Revision: -

 Version: 

 Date: 2004/05/23

 Prepared for: General Public 

 Prepared by:  http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com

 Classification: None

#######
#  
#  1. SCOPE
#
#
=head1 SCOPE

This detail STD and the 
L<General Perl Program Module (PM) STD|Test::STD::PerlSTD>
establishes the tests to verify the
requirements of Perl Program Module (PM) L<Test::STDmaker|Test::STDmaker>
The format of this STD is a tailored L<2167A STD DID|Docs::US_DOD::STD>.

#######
#  
#  3. TEST PREPARATIONS
#
#
=head1 TEST PREPARATIONS

Test preparations are establishes by the L<General STD|Test::STD::PerlSTD>.


#######
#  
#  4. TEST DESCRIPTIONS
#
#
=head1 TEST DESCRIPTIONS

The test descriptions uses a legend to
identify different aspects of a test description
in accordance with
L<STD PM Form Database Test Description Fields|Test::STDmaker/STD PM Form Database Test Description Fields>.

=head2 Test Plan

 T: 21^

=head2 ok: 1


  C:
     use vars qw($loaded);
     use File::Glob ':glob';
     use File::Copy;
     use File::Package;
     use File::SmartNL;
     use Text::Scrub;
  
     #########
     # For "TEST" 1.24 or greater that have separate std err output,
     # redirect the TESTERR to STDOUT
     #
     my $restore_testerr = tech_config( 'Test.TESTERR', \*STDOUT );   
     my $fp = 'File::Package';
     my $snl = 'File::SmartNL';
     my $s = 'Text::Scrub';
     my $test_results;
     my $loaded = 0;
     my @outputs;
     my ($success, $diag);
 ^
 VO: ^

  C:
     @outputs = bsd_glob( 'tg*1.*' );
     unlink @outputs;
     unlink 'tgA1.pm';
     unlink 'tgB1.pm';
     unlink 'tgC1.pm';
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
     #
 ^
  N: UUT not loaded^
 DM: For a valid test, the UUT should not be loaded^
  A: $loaded = $fp->is_package_loaded('Test::STDmaker')^
  E:  ''^
 ok: 1^

=head2 ok: 2

  N: Load UUT^
  R: L<Test::STDmaker/load [1]>^
  S: $loaded^
  C: my $errors = $fp->load_package( 'Test::STDmaker' )^
  A: $errors^
 SE: ''^
 ok: 2^

=head2 ok: 3

  N: Test::STDmaker Version $Test::STDmaker::VERSION^
  A: $Test::STDmaker::VERSION^
  E: $Test::STDmaker::VERSION^
 ok: 3^

=head2 ok: 4

 DO: ^
  A: $snl->fin('tgA0.pm')^
  N: tmake('STD', {pm => 't::Test::STDmaker::tgA1'})^

  C:
     copy 'tgA0.pm', 'tgA1.pm';
     my $tmaker = new Test::STDmaker(pm =>'t::Test::STDmaker::tgA1', nounlink => 1);
     $success = $tmaker->tmake( 'STD' );
     $diag = (-e 'temp.pl') ? "\n~~~~~~~\ntemp.pl\n\n" . $snl->fin('temp.pl') : 'No temp.pl';
     $diag .= (-e 'tgA1.pm') ? "\n~~~~~~~\ntgA1.pm\n\n" . $snl->fin('tgA1.pm') : 'No tgA1.pm';
 ^
 DM: $diag^
  A: $success^
 SE: 1^
 ok: 4^

=head2 ok: 5

  N: Clean STD pm with a todo list^

  R:
     L<Test::STDmaker/clean FormDB [1]>
     L<Test::STDmaker/clean FormDB [2]>
     L<Test::STDmaker/clean FormDB [3]>
     L<Test::STDmaker/clean FormDB [4]>
     L<Test::STDmaker/file_out option [1]>
 ^
  A: $s->scrub_date_version($snl->fin('tgA1.pm'))^
  E: $s->scrub_date_version($snl->fin('tgA2.pm'))^
 ok: 5^

=head2 ok: 6

 DO: ^
  A: $snl->fin('tgB0.pm')^

  C:
     skip_tests(0);
     copy 'tgB0.pm', 'tgB1.pm';
     $success = $tmaker->tmake('STD', 'verify', {pm => 't::Test::STDmaker::tgB1', nounlink => 1} );
     $diag = (-e 'temp.pl') ? "\n~~~~~~~\ntemp.pl\n\n" . $snl->fin('temp.pl') : 'No temp.pl';
     $diag .= (-e 'tgB1.pm') ? "\n~~~~~~~\ntgB1.pm\n\n" . $snl->fin('tgB1.pm') : 'No tgB1.pm';
     $diag .= (-e 'tgB1.t') ? "\n~~~~~~~\ntgB1.t\n\n" . $snl->fin('tgB1.t') : 'No tgB1.t';
 ^
  N: tmake('STD', 'verify', {pm => 't::Test::STDmaker::tgB1'})^
 DM: $diag^
  A: $success^
 SE: 1^
 ok: 6^

=head2 ok: 7

  N: Clean STD pm without a todo list^

  R:
     L<Test::STDmaker/clean FormDB [1]>
     L<Test::STDmaker/clean FormDB [2]>
     L<Test::STDmaker/clean FormDB [3]>
     L<Test::STDmaker/clean FormDB [4]>
     L<Test::STDmaker/file_out option [1]>
 ^
  A: $s->scrub_date_version($snl->fin('tgB1.pm'))^
  E: $s->scrub_date_version($snl->fin('tgB2.pm'))^
 ok: 7^

=head2 ok: 8

  N: Generated and execute the test script^

  C:
     my $perl_execuable = $tmaker->perl_command();
     $test_results = `$perl_execuable tgB1.t`;
     $snl->fout('tgB1.txt', $test_results);
 ^
  A: $s->scrub_probe($s->scrub_file_line($test_results))^
  E: $s->scrub_probe($s->scrub_file_line($snl->fin('tgB2.txt')))^
 ok: 8^

=head2 ok: 9

 VO: ^

  C:
     skip_tests(0);
     #####
     # Make sure there is no residue outputs hanging
     # around from the last test series.
     #
     @outputs = bsd_glob( 'tg*1.*' );
     unlink @outputs;
     copy 'tgA0.pm', 'tgA1.pm';
     $tmaker = new Test::STDmaker( {pm => 't::Test::STDmaker::tgA1'} );
     $success = $tmaker->tmake();
     $diag = (-e 'tgA1.pm') ? "\n~~~~~~~\ntgA1.pm\n\n" . $snl->fin('tgA1.pm') : 'No tgA1.pm';
     $diag .= (-e 'tgA1.t') ? "\n~~~~~~~\ntgA1.t\n\n" . $snl->fin('tgA1.t') : 'No tgA1.t';
     $diag .= (-e 'tgA1.d') ? "\n~~~~~~~\ntgA1.d\n\n" . $snl->fin('tgA1.d') : 'No tgA1.d';
     warn("######\nok: 9\n" . $diag);
 ^
  N: tmake( {pm => 't::Test::STDmaker::tgA1'})^
 DM: $diag^
  A: $success^
 SE: 1^
 ok: 9^

=head2 ok: 10

  N: Cleaned tgA1.pm^

  R:
     L<Test::STDmaker/clean FormDB [1]>
     L<Test::STDmaker/clean FormDB [2]>
     L<Test::STDmaker/clean FormDB [3]>
     L<Test::STDmaker/clean FormDB [4]>
     L<Test::STDmaker/STD PM POD [1]>
 ^
  A: $s->scrub_date_version($snl->fin('tgA1.pm'))^
  E: $s->scrub_date_version($snl->fin('tgA2.pm'))^
 ok: 10^

=head2 ok: 11

 DO: ^
  N: Internal Storage^

  C:
     use Data::Dumper;
     my $probe = 3;
     my $actual_results = Dumper([0+$probe]);
     my $internal_storage = 'undetermine';
     if( $actual_results eq Dumper([3]) ) {
         $internal_storage = 'number';
     }
     elsif ( $actual_results eq Dumper(['3']) ) {
         $internal_storage = 'string';
     }
     my $expected_results;
 ^
  A: $internal_storage^
  E: $internal_storage^
 VO: ^
  N: Demonstration script^

  R:
     L<Test::STDmaker/demo file [1]>
     L<Test::STDmaker/demo file [2]>
 ^

  C:
     $test_results = `$perl_execuable tgA1.d`;
     $snl->fout('tgA1.txt', $test_results);
     use Data::Dumper;
     my $probe = 3;
     my $actual_results = Dumper([0+$probe]);
     my $internal_storage = 'undetermine';
     if( $actual_results eq Dumper([3]) ) {
         $internal_storage = 'number';
     }
     elsif ( $actual_results eq Dumper(['3']) ) {
         $internal_storage = 'string';
     }
     #######
     # expected results depend upon the internal storage from numbers 
     # Cannot use tga2A1.txt. All the actuals use 1 and the glob
     # that deletes the actuals will delete it.
     #
     my $expected_results;
     if( $internal_storage eq 'string') {
         $expected_results = 'tgA2A3.txt';
     }
     else {
         $expected_results = 'tgA2A2.txt';
     }
 ^
  A: $test_results^
  E: $snl->fin($expected_results)^
 ok: 11^

=head2 ok: 12

 VO: ^
  N: Generated and execute the test script^

  R:
     L<Test::STDmaker/verify file [1]>
     L<Test::STDmaker/verify file [2]>
     L<Test::STDmaker/verify file [3]>
 ^

  C:
     $test_results = `$perl_execuable tgA1.t`;
     $snl->fout('tgA1.txt', $test_results);
 ^
  A: $s->scrub_probe($s->scrub_file_line($test_results))^
  E: $s->scrub_probe($s->scrub_file_line($snl->fin('tgA2B.txt')))^
 ok: 12^

=head2 ok: 13

 DO: ^
  A: $snl->fin( 'tg0.pm'  )^
  N: tmake('demo', {pm => 't::Test::STDmaker::tgA1', demo => 1})^

  C:
     #########
     #
     # Individual generate outputs using options
     #
     ########
     skip_tests(0);
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
     $success = $tmaker->tmake('demo', { pm => 't::Test::STDmaker::tgA1', demo => 1});
     shift @INC;
     #######
     # expected results depend upon the internal storage from numbers 
     #
     if( $internal_storage eq 'string') {
         $expected_results = 'tg2B.pm';
     }
     else {
         $expected_results = 'tg2A.pm';
     }
     $diag = (-e 'tgA1.pm') ? "\n~~~~~~~\ntgA1.pm\n\n" . $snl->fin('tgA1.pm') : 'No tgA1.pm';
     $diag .= (-e 'tgA1.d') ? "\n~~~~~~~\ntgA1.d\n\n" . $snl->fin('tgA1.d') : 'No tgA1.d';
     warn("######\nok: 13\n" . $diag);
 ^
 DM: $diag^
  A: $success^
 SE: 1^
 ok: 13^

=head2 ok: 14

  N: Generate and replace a demonstration^
  A: $s->scrub_date_version($snl->fin('tg1.pm'))^
  E: $s->scrub_date_version($snl->fin($expected_results))^
 ok: 14^

=head2 ok: 15

  N: tmake('verify', {pm => 't::Test::STDmaker::tgA1', run => 1, test_verbose => 1})^

  R:
     L<Test::STDmaker/verify file [1]>
     L<Test::STDmaker/verify file [2]>
     L<Test::STDmaker/verify file [3]>
     L<Test::STDmaker/verify file [4]>
     L<Test::STDmaker/execute [3]>
     L<Test::STDmaker/execute [4]>
 ^

  C:
     skip_tests(0);
     no warnings;
     open SAVEOUT, ">&STDOUT";
     use warnings;
     open STDOUT, ">tgA1.txt";
     $success = $tmaker->tmake('verify', { pm => 't::Test::STDmaker::tgA1', run => 1, test_verbose => 1});
     close STDOUT;
     open STDOUT, ">&SAVEOUT";
     
     ######
     # For some reason, test harness puts in a extra line when running u
     # under the Active debugger on Win32. So just take it out.
     # Also the script name is absolute which is site dependent.
     # Take it out of the comparision.
     #
     $test_results = $snl->fin('tgA1.txt');
     $test_results =~ s/.*?1..9/1..9/; 
     $test_results =~ s/------.*?\n(\s*\()/\n $1/s;
     $snl->fout('tgA1.txt',$test_results);
 ^
  A: $success^
 SE: 1^
 ok: 15^

=head2 ok: 16

  N: Generate and verbose test harness run test script^
  A: $s->scrub_probe($s->scrub_test_file($s->scrub_file_line($test_results)))^
  E: $s->scrub_probe($s->scrub_test_file($s->scrub_file_line($snl->fin('tgA2C.txt'))))^
 ok: 16^

=head2 ok: 17

 VO: ^

  R:
     L<Test::STDmaker/verify file [1]>
     L<Test::STDmaker/verify file [2]>
     L<Test::STDmaker/verify file [3]>
     L<Test::STDmaker/execute [3]>
 ^
  N: tmake('verify', {pm => 't::Test::STDmaker::tgA1', run => 1})^

  C:
     skip_tests(0);
     no warnings;
     open SAVEOUT, ">&STDOUT";
     use warnings;
     open STDOUT, ">tgA1.txt";
     $main::SIG{__WARN__}=\&__warn__; # kill pesty Format STDOUT and Format STDOUT_TOP redefined
     $success = $tmaker->tmake('verify', { pm => 't::Test::STDmaker::tgA1', run => 1});
     $main::SIG{__WARN__}=\&CORE::warn;
     close STDOUT;
     open STDOUT, ">&SAVEOUT";
     ######
     # For some reason, test harness puts in a extra line when running u
     # under the Active debugger on Win32. So just take it out.
     # Also with absolute file, the file is chopped off, and see
     # stuff that is site dependent. Need to take it out also.
     #
     $test_results = $snl->fin('tgA1.txt');
     $test_results = 'FAILED tests 4, 8' if( $test_results =~ /FAILED tests 4, 8/ );
 ^
  A: $success^
 SE: 1^
 ok: 17^

=head2 ok: 18

  N: Generate and test harness run test script^
  A: $test_results^
  E: 'FAILED tests 4, 8'^
 ok: 18^

=head2 ok: 19

 DO: ^
  A: $snl->fin('tgC0.pm')^
  N: tmake('STD', {pm => 't::Test::STDmaker::tgC1', fspec_out=>'os2'})^

  C:
     skip_tests(0);
     copy 'tgC0.pm', 'tgC1.pm';
     $success = $tmaker->tmake('STD', { pm => 't::Test::STDmaker::tgC1', fspec_out=>'os2'});
 ^
  A: $success^
 SE: 1^
 ok: 19^

=head2 ok: 20

  N: Change File Spec^
  R: L<Test::STDmaker/fspec_out option [6]>^
  A: $s->scrub_date_version($snl->fin('tgC1.pm'))^
  E: $s->scrub_date_version($snl->fin('tgC2.pm'))^
 ok: 20^

=head2 ok: 21

  N: find_t_roots^

  C:
    my $OS = $^^O;  # Need to escape the form delimiting char ^^
    unless ($OS) {   # on some perls $^^O is not defined
      require Config;
      $OS = $Config::Config{'osname'};
    } 
    my($vol, $dir) = File::Spec->splitpath(cwd(),'nofile');
    my @dirs = File::Spec->splitdir($dir);
    pop @dirs; # pop STDmaker
    pop @dirs; # pop Test
    pop @dirs; # pop t
    $dir = File::Spec->catdir($vol,@dirs);
    my @t_path = $tmaker->find_t_roots();
 ^
  A: $t_path[0]^
  E: $dir^
 ok: 21^



#######
#  
#  5. REQUIREMENTS TRACEABILITY
#
#

=head1 REQUIREMENTS TRACEABILITY

  Requirement                                                      Test
 ---------------------------------------------------------------- ----------------------------------------------------------------
 L<Test::STDmaker/STD PM POD [1]>                                 L<t::Test::STDmaker::STDmaker/ok: 10>
 L<Test::STDmaker/clean FormDB [1]>                               L<t::Test::STDmaker::STDmaker/ok: 10>
 L<Test::STDmaker/clean FormDB [1]>                               L<t::Test::STDmaker::STDmaker/ok: 5>
 L<Test::STDmaker/clean FormDB [1]>                               L<t::Test::STDmaker::STDmaker/ok: 7>
 L<Test::STDmaker/clean FormDB [2]>                               L<t::Test::STDmaker::STDmaker/ok: 10>
 L<Test::STDmaker/clean FormDB [2]>                               L<t::Test::STDmaker::STDmaker/ok: 5>
 L<Test::STDmaker/clean FormDB [2]>                               L<t::Test::STDmaker::STDmaker/ok: 7>
 L<Test::STDmaker/clean FormDB [3]>                               L<t::Test::STDmaker::STDmaker/ok: 10>
 L<Test::STDmaker/clean FormDB [3]>                               L<t::Test::STDmaker::STDmaker/ok: 5>
 L<Test::STDmaker/clean FormDB [3]>                               L<t::Test::STDmaker::STDmaker/ok: 7>
 L<Test::STDmaker/clean FormDB [4]>                               L<t::Test::STDmaker::STDmaker/ok: 10>
 L<Test::STDmaker/clean FormDB [4]>                               L<t::Test::STDmaker::STDmaker/ok: 5>
 L<Test::STDmaker/clean FormDB [4]>                               L<t::Test::STDmaker::STDmaker/ok: 7>
 L<Test::STDmaker/demo file [1]>                                  L<t::Test::STDmaker::STDmaker/ok: 11>
 L<Test::STDmaker/demo file [2]>                                  L<t::Test::STDmaker::STDmaker/ok: 11>
 L<Test::STDmaker/execute [3]>                                    L<t::Test::STDmaker::STDmaker/ok: 15>
 L<Test::STDmaker/execute [3]>                                    L<t::Test::STDmaker::STDmaker/ok: 17>
 L<Test::STDmaker/execute [4]>                                    L<t::Test::STDmaker::STDmaker/ok: 15>
 L<Test::STDmaker/file_out option [1]>                            L<t::Test::STDmaker::STDmaker/ok: 5>
 L<Test::STDmaker/file_out option [1]>                            L<t::Test::STDmaker::STDmaker/ok: 7>
 L<Test::STDmaker/fspec_out option [6]>                           L<t::Test::STDmaker::STDmaker/ok: 20>
 L<Test::STDmaker/load [1]>                                       L<t::Test::STDmaker::STDmaker/ok: 2>
 L<Test::STDmaker/verify file [1]>                                L<t::Test::STDmaker::STDmaker/ok: 12>
 L<Test::STDmaker/verify file [1]>                                L<t::Test::STDmaker::STDmaker/ok: 15>
 L<Test::STDmaker/verify file [1]>                                L<t::Test::STDmaker::STDmaker/ok: 17>
 L<Test::STDmaker/verify file [2]>                                L<t::Test::STDmaker::STDmaker/ok: 12>
 L<Test::STDmaker/verify file [2]>                                L<t::Test::STDmaker::STDmaker/ok: 15>
 L<Test::STDmaker/verify file [2]>                                L<t::Test::STDmaker::STDmaker/ok: 17>
 L<Test::STDmaker/verify file [3]>                                L<t::Test::STDmaker::STDmaker/ok: 12>
 L<Test::STDmaker/verify file [3]>                                L<t::Test::STDmaker::STDmaker/ok: 15>
 L<Test::STDmaker/verify file [3]>                                L<t::Test::STDmaker::STDmaker/ok: 17>
 L<Test::STDmaker/verify file [4]>                                L<t::Test::STDmaker::STDmaker/ok: 15>


  Test                                                             Requirement
 ---------------------------------------------------------------- ----------------------------------------------------------------
 L<t::Test::STDmaker::STDmaker/ok: 10>                            L<Test::STDmaker/STD PM POD [1]>
 L<t::Test::STDmaker::STDmaker/ok: 10>                            L<Test::STDmaker/clean FormDB [1]>
 L<t::Test::STDmaker::STDmaker/ok: 10>                            L<Test::STDmaker/clean FormDB [2]>
 L<t::Test::STDmaker::STDmaker/ok: 10>                            L<Test::STDmaker/clean FormDB [3]>
 L<t::Test::STDmaker::STDmaker/ok: 10>                            L<Test::STDmaker/clean FormDB [4]>
 L<t::Test::STDmaker::STDmaker/ok: 11>                            L<Test::STDmaker/demo file [1]>
 L<t::Test::STDmaker::STDmaker/ok: 11>                            L<Test::STDmaker/demo file [2]>
 L<t::Test::STDmaker::STDmaker/ok: 12>                            L<Test::STDmaker/verify file [1]>
 L<t::Test::STDmaker::STDmaker/ok: 12>                            L<Test::STDmaker/verify file [2]>
 L<t::Test::STDmaker::STDmaker/ok: 12>                            L<Test::STDmaker/verify file [3]>
 L<t::Test::STDmaker::STDmaker/ok: 15>                            L<Test::STDmaker/execute [3]>
 L<t::Test::STDmaker::STDmaker/ok: 15>                            L<Test::STDmaker/execute [4]>
 L<t::Test::STDmaker::STDmaker/ok: 15>                            L<Test::STDmaker/verify file [1]>
 L<t::Test::STDmaker::STDmaker/ok: 15>                            L<Test::STDmaker/verify file [2]>
 L<t::Test::STDmaker::STDmaker/ok: 15>                            L<Test::STDmaker/verify file [3]>
 L<t::Test::STDmaker::STDmaker/ok: 15>                            L<Test::STDmaker/verify file [4]>
 L<t::Test::STDmaker::STDmaker/ok: 17>                            L<Test::STDmaker/execute [3]>
 L<t::Test::STDmaker::STDmaker/ok: 17>                            L<Test::STDmaker/verify file [1]>
 L<t::Test::STDmaker::STDmaker/ok: 17>                            L<Test::STDmaker/verify file [2]>
 L<t::Test::STDmaker::STDmaker/ok: 17>                            L<Test::STDmaker/verify file [3]>
 L<t::Test::STDmaker::STDmaker/ok: 20>                            L<Test::STDmaker/fspec_out option [6]>
 L<t::Test::STDmaker::STDmaker/ok: 2>                             L<Test::STDmaker/load [1]>
 L<t::Test::STDmaker::STDmaker/ok: 5>                             L<Test::STDmaker/clean FormDB [1]>
 L<t::Test::STDmaker::STDmaker/ok: 5>                             L<Test::STDmaker/clean FormDB [2]>
 L<t::Test::STDmaker::STDmaker/ok: 5>                             L<Test::STDmaker/clean FormDB [3]>
 L<t::Test::STDmaker::STDmaker/ok: 5>                             L<Test::STDmaker/clean FormDB [4]>
 L<t::Test::STDmaker::STDmaker/ok: 5>                             L<Test::STDmaker/file_out option [1]>
 L<t::Test::STDmaker::STDmaker/ok: 7>                             L<Test::STDmaker/clean FormDB [1]>
 L<t::Test::STDmaker::STDmaker/ok: 7>                             L<Test::STDmaker/clean FormDB [2]>
 L<t::Test::STDmaker::STDmaker/ok: 7>                             L<Test::STDmaker/clean FormDB [3]>
 L<t::Test::STDmaker::STDmaker/ok: 7>                             L<Test::STDmaker/clean FormDB [4]>
 L<t::Test::STDmaker::STDmaker/ok: 7>                             L<Test::STDmaker/file_out option [1]>


=cut

#######
#  
#  6. NOTES
#
#

=head1 NOTES

copyright © 2003 Software Diamonds.

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

#######
#
#  2. REFERENCED DOCUMENTS
#
#
#

=head1 SEE ALSO

=over 4

=item L<File::Package|File::Package>

=item L<File::SmartNL|File::SmartNL>

=item L<File::AnySpec|File::AnySpec>

=item L<File::Data|File::Data>

=item L<File::Where|File::Where>

=item L<Text::Replace|Text::Replace>

=item L<Text::Column|Text::Column>

=item L<Text::Scrub|Text::Scrub>

=item L<Tie::Form|Tie::Form>

=item L<Software Development Standard|Docs::US_DOD::STD2167A>

=item L<Specification Practices|Docs::US_DOD::STD490A>

=item L<STD DID|Docs::US_DOD::STD>

=item L<Test::Harness|Test::Harness>

=item L<Test::Tech|Test::Tech>

=item L<Test|Test>

=back

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

__DATA__

Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
Classification: None^
Detail_Template: ^
End_User: General Public^
File_Spec: Unix^
Name: t::Test::STDmaker::STDmaker^
Revision: -^
STD2167_Template: ^
Temp: temp.pl^
UUT: Test::STDmaker^
Version: ^
Demo: STDmaker.d^
Verify: STDmaker.t^


 T: 21^


 C:
    use vars qw($loaded);
    use File::Glob ':glob';
    use File::Copy;
    use File::Package;
    use File::SmartNL;
    use Text::Scrub;
 
    #########
    # For "TEST" 1.24 or greater that have separate std err output,
    # redirect the TESTERR to STDOUT
    #
    my $restore_testerr = tech_config( 'Test.TESTERR', \*STDOUT );   

    my $fp = 'File::Package';
    my $snl = 'File::SmartNL';
    my $s = 'Text::Scrub';

    my $test_results;
    my $loaded = 0;
    my @outputs;

    my ($success, $diag);
^

VO: ^

 C:
    @outputs = bsd_glob( 'tg*1.*' );
    unlink @outputs;
    unlink 'tgA1.pm';
    unlink 'tgB1.pm';
    unlink 'tgC1.pm';

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
    #
^

 N: UUT not loaded^
DM: For a valid test, the UUT should not be loaded^
 A: $loaded = $fp->is_package_loaded('Test::STDmaker')^
 E:  ''^
ok: 1^

 N: Load UUT^
 R: L<Test::STDmaker/load [1]>^
 S: $loaded^
 C: my $errors = $fp->load_package( 'Test::STDmaker' )^
 A: $errors^
SE: ''^
ok: 2^

 N: Test::STDmaker Version $Test::STDmaker::VERSION^
 A: $Test::STDmaker::VERSION^
 E: $Test::STDmaker::VERSION^
ok: 3^

DO: ^
 A: $snl->fin('tgA0.pm')^
 N: tmake('STD', {pm => 't::Test::STDmaker::tgA1'})^

 C:
    copy 'tgA0.pm', 'tgA1.pm';
    my $tmaker = new Test::STDmaker(pm =>'t::Test::STDmaker::tgA1', nounlink => 1);
    $success = $tmaker->tmake( 'STD' );
    $diag = (-e 'temp.pl') ? "\n~~~~~~~\ntemp.pl\n\n" . $snl->fin('temp.pl') : 'No temp.pl';
    $diag .= (-e 'tgA1.pm') ? "\n~~~~~~~\ntgA1.pm\n\n" . $snl->fin('tgA1.pm') : 'No tgA1.pm';
^

DM: $diag^
 A: $success^
SE: 1^
ok: 4^

 N: Clean STD pm with a todo list^

 R:
    L<Test::STDmaker/clean FormDB [1]>
    L<Test::STDmaker/clean FormDB [2]>
    L<Test::STDmaker/clean FormDB [3]>
    L<Test::STDmaker/clean FormDB [4]>
    L<Test::STDmaker/file_out option [1]>
^

 A: $s->scrub_date_version($snl->fin('tgA1.pm'))^
 E: $s->scrub_date_version($snl->fin('tgA2.pm'))^
ok: 5^

DO: ^
 A: $snl->fin('tgB0.pm')^

 C:
    skip_tests(0);
    copy 'tgB0.pm', 'tgB1.pm';
    $success = $tmaker->tmake('STD', 'verify', {pm => 't::Test::STDmaker::tgB1', nounlink => 1} );
    $diag = (-e 'temp.pl') ? "\n~~~~~~~\ntemp.pl\n\n" . $snl->fin('temp.pl') : 'No temp.pl';
    $diag .= (-e 'tgB1.pm') ? "\n~~~~~~~\ntgB1.pm\n\n" . $snl->fin('tgB1.pm') : 'No tgB1.pm';
    $diag .= (-e 'tgB1.t') ? "\n~~~~~~~\ntgB1.t\n\n" . $snl->fin('tgB1.t') : 'No tgB1.t';
^

 N: tmake('STD', 'verify', {pm => 't::Test::STDmaker::tgB1'})^
DM: $diag^
 A: $success^
SE: 1^
ok: 6^

 N: Clean STD pm without a todo list^

 R:
    L<Test::STDmaker/clean FormDB [1]>
    L<Test::STDmaker/clean FormDB [2]>
    L<Test::STDmaker/clean FormDB [3]>
    L<Test::STDmaker/clean FormDB [4]>
    L<Test::STDmaker/file_out option [1]>
^

 A: $s->scrub_date_version($snl->fin('tgB1.pm'))^
 E: $s->scrub_date_version($snl->fin('tgB2.pm'))^
ok: 7^

 N: Generated and execute the test script^

 C:
    my $perl_execuable = $tmaker->perl_command();
    $test_results = `$perl_execuable tgB1.t`;
    $snl->fout('tgB1.txt', $test_results);
^

 A: $s->scrub_probe($s->scrub_file_line($test_results))^
 E: $s->scrub_probe($s->scrub_file_line($snl->fin('tgB2.txt')))^
ok: 8^

VO: ^

 C:
    skip_tests(0);

    #####
    # Make sure there is no residue outputs hanging
    # around from the last test series.
    #
    @outputs = bsd_glob( 'tg*1.*' );
    unlink @outputs;
    copy 'tgA0.pm', 'tgA1.pm';
    $tmaker = new Test::STDmaker( {pm => 't::Test::STDmaker::tgA1'} );
    $success = $tmaker->tmake();
    $diag = (-e 'tgA1.pm') ? "\n~~~~~~~\ntgA1.pm\n\n" . $snl->fin('tgA1.pm') : 'No tgA1.pm';
    $diag .= (-e 'tgA1.t') ? "\n~~~~~~~\ntgA1.t\n\n" . $snl->fin('tgA1.t') : 'No tgA1.t';
    $diag .= (-e 'tgA1.d') ? "\n~~~~~~~\ntgA1.d\n\n" . $snl->fin('tgA1.d') : 'No tgA1.d';
    warn("######\nok: 9\n" . $diag);
^

 N: tmake( {pm => 't::Test::STDmaker::tgA1'})^
DM: $diag^
 A: $success^
SE: 1^
ok: 9^

 N: Cleaned tgA1.pm^

 R:
    L<Test::STDmaker/clean FormDB [1]>
    L<Test::STDmaker/clean FormDB [2]>
    L<Test::STDmaker/clean FormDB [3]>
    L<Test::STDmaker/clean FormDB [4]>
    L<Test::STDmaker/STD PM POD [1]>
^

 A: $s->scrub_date_version($snl->fin('tgA1.pm'))^
 E: $s->scrub_date_version($snl->fin('tgA2.pm'))^
ok: 10^

DO: ^
 N: Internal Storage^

 C:
    use Data::Dumper;
    my $probe = 3;
    my $actual_results = Dumper([0+$probe]);
    my $internal_storage = 'undetermine';
    if( $actual_results eq Dumper([3]) ) {
        $internal_storage = 'number';
    }
    elsif ( $actual_results eq Dumper(['3']) ) {
        $internal_storage = 'string';
    }

    my $expected_results;
^

 A: $internal_storage^
 E: $internal_storage^
VO: ^
 N: Demonstration script^

 R:
    L<Test::STDmaker/demo file [1]>
    L<Test::STDmaker/demo file [2]>
^


 C:
    $test_results = `$perl_execuable tgA1.d`;
    $snl->fout('tgA1.txt', $test_results);

    use Data::Dumper;
    my $probe = 3;
    my $actual_results = Dumper([0+$probe]);
    my $internal_storage = 'undetermine';
    if( $actual_results eq Dumper([3]) ) {
        $internal_storage = 'number';
    }
    elsif ( $actual_results eq Dumper(['3']) ) {
        $internal_storage = 'string';
    }

    #######
    # expected results depend upon the internal storage from numbers 
    # Cannot use tga2A1.txt. All the actuals use 1 and the glob
    # that deletes the actuals will delete it.
    #
    my $expected_results;
    if( $internal_storage eq 'string') {
        $expected_results = 'tgA2A3.txt';
    }
    else {
        $expected_results = 'tgA2A2.txt';
    }
^

 A: $test_results^
 E: $snl->fin($expected_results)^
ok: 11^

VO: ^
 N: Generated and execute the test script^

 R:
    L<Test::STDmaker/verify file [1]>
    L<Test::STDmaker/verify file [2]>
    L<Test::STDmaker/verify file [3]>
^


 C:
    $test_results = `$perl_execuable tgA1.t`;
    $snl->fout('tgA1.txt', $test_results);
^

 A: $s->scrub_probe($s->scrub_file_line($test_results))^
 E: $s->scrub_probe($s->scrub_file_line($snl->fin('tgA2B.txt')))^
ok: 12^

DO: ^
 A: $snl->fin( 'tg0.pm'  )^
 N: tmake('demo', {pm => 't::Test::STDmaker::tgA1', demo => 1})^

 C:
    #########
    #
    # Individual generate outputs using options
    #
    ########

    skip_tests(0);

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
    $success = $tmaker->tmake('demo', { pm => 't::Test::STDmaker::tgA1', demo => 1});
    shift @INC;

    #######
    # expected results depend upon the internal storage from numbers 
    #
    if( $internal_storage eq 'string') {
        $expected_results = 'tg2B.pm';
    }
    else {
        $expected_results = 'tg2A.pm';
    }
    $diag = (-e 'tgA1.pm') ? "\n~~~~~~~\ntgA1.pm\n\n" . $snl->fin('tgA1.pm') : 'No tgA1.pm';
    $diag .= (-e 'tgA1.d') ? "\n~~~~~~~\ntgA1.d\n\n" . $snl->fin('tgA1.d') : 'No tgA1.d';
    warn("######\nok: 13\n" . $diag);
^

DM: $diag^
 A: $success^
SE: 1^
ok: 13^

 N: Generate and replace a demonstration^
 A: $s->scrub_date_version($snl->fin('tg1.pm'))^
 E: $s->scrub_date_version($snl->fin($expected_results))^
ok: 14^

 N: tmake('verify', {pm => 't::Test::STDmaker::tgA1', run => 1, test_verbose => 1})^

 R:
    L<Test::STDmaker/verify file [1]>
    L<Test::STDmaker/verify file [2]>
    L<Test::STDmaker/verify file [3]>
    L<Test::STDmaker/verify file [4]>
    L<Test::STDmaker/execute [3]>
    L<Test::STDmaker/execute [4]>
^


 C:
    skip_tests(0);

    no warnings;
    open SAVEOUT, ">&STDOUT";
    use warnings;
    open STDOUT, ">tgA1.txt";
    $success = $tmaker->tmake('verify', { pm => 't::Test::STDmaker::tgA1', run => 1, test_verbose => 1});
    close STDOUT;
    open STDOUT, ">&SAVEOUT";
    
    ######
    # For some reason, test harness puts in a extra line when running u
    # under the Active debugger on Win32. So just take it out.
    # Also the script name is absolute which is site dependent.
    # Take it out of the comparision.
    #
    $test_results = $snl->fin('tgA1.txt');
    $test_results =~ s/.*?1..9/1..9/; 
    $test_results =~ s/------.*?\n(\s*\()/\n $1/s;
    $snl->fout('tgA1.txt',$test_results);
^

 A: $success^
SE: 1^
ok: 15^

 N: Generate and verbose test harness run test script^
 A: $s->scrub_probe($s->scrub_test_file($s->scrub_file_line($test_results)))^
 E: $s->scrub_probe($s->scrub_test_file($s->scrub_file_line($snl->fin('tgA2C.txt'))))^
ok: 16^

VO: ^

 R:
    L<Test::STDmaker/verify file [1]>
    L<Test::STDmaker/verify file [2]>
    L<Test::STDmaker/verify file [3]>
    L<Test::STDmaker/execute [3]>
^

 N: tmake('verify', {pm => 't::Test::STDmaker::tgA1', run => 1})^

 C:
    skip_tests(0);

    no warnings;
    open SAVEOUT, ">&STDOUT";
    use warnings;
    open STDOUT, ">tgA1.txt";
    $main::SIG{__WARN__}=\&__warn__; # kill pesty Format STDOUT and Format STDOUT_TOP redefined
    $success = $tmaker->tmake('verify', { pm => 't::Test::STDmaker::tgA1', run => 1});
    $main::SIG{__WARN__}=\&CORE::warn;
    close STDOUT;
    open STDOUT, ">&SAVEOUT";

    ######
    # For some reason, test harness puts in a extra line when running u
    # under the Active debugger on Win32. So just take it out.
    # Also with absolute file, the file is chopped off, and see
    # stuff that is site dependent. Need to take it out also.
    #
    $test_results = $snl->fin('tgA1.txt');
    $test_results = 'FAILED tests 4, 8' if( $test_results =~ /FAILED tests 4, 8/ );
^

 A: $success^
SE: 1^
ok: 17^

 N: Generate and test harness run test script^
 A: $test_results^
 E: 'FAILED tests 4, 8'^
ok: 18^

DO: ^
 A: $snl->fin('tgC0.pm')^
 N: tmake('STD', {pm => 't::Test::STDmaker::tgC1', fspec_out=>'os2'})^

 C:
    skip_tests(0);
    copy 'tgC0.pm', 'tgC1.pm';
    $success = $tmaker->tmake('STD', { pm => 't::Test::STDmaker::tgC1', fspec_out=>'os2'});
^

 A: $success^
SE: 1^
ok: 19^

 N: Change File Spec^
 R: L<Test::STDmaker/fspec_out option [6]>^
 A: $s->scrub_date_version($snl->fin('tgC1.pm'))^
 E: $s->scrub_date_version($snl->fin('tgC2.pm'))^
ok: 20^

 N: find_t_roots^

 C:
   my $OS = $^^O;  # Need to escape the form delimiting char ^^
   unless ($OS) {   # on some perls $^^O is not defined
     require Config;
     $OS = $Config::Config{'osname'};
   } 
   my($vol, $dir) = File::Spec->splitpath(cwd(),'nofile');
   my @dirs = File::Spec->splitdir($dir);
   pop @dirs; # pop STDmaker
   pop @dirs; # pop Test
   pop @dirs; # pop t
   $dir = File::Spec->catdir($vol,@dirs);
   my @t_path = $tmaker->find_t_roots();
^

 A: $t_path[0]^
 E: $dir^
ok: 21^


 C:
    #####
    # Make sure there is no residue outputs hanging
    # around from the last test series.
    #
    @outputs = bsd_glob( 'tg*1.*' );
    unlink @outputs;
    unlink 'tgA1.pm';
    unlink 'tgB1.pm';
    unlink 'tgC1.pm';
    tech_config( 'Test.TESTERR', $restore_testerr);   

    #####
    # Suppress some annoying warnings
    #
    sub __warn__ 
    { 
       my ($text) = @_;
       return $text =~ /STDOUT/;
       CORE::warn( $text );
    };
^



See_Also:
\=over 4

\=item L<File::Package|File::Package>

\=item L<File::SmartNL|File::SmartNL>

\=item L<File::AnySpec|File::AnySpec>

\=item L<File::Data|File::Data>

\=item L<File::Where|File::Where>

\=item L<Text::Replace|Text::Replace>

\=item L<Text::Column|Text::Column>

\=item L<Text::Scrub|Text::Scrub>

\=item L<Tie::Form|Tie::Form>

\=item L<Software Development Standard|Docs::US_DOD::STD2167A>

\=item L<Specification Practices|Docs::US_DOD::STD490A>

\=item L<STD DID|Docs::US_DOD::STD>

\=item L<Test::Harness|Test::Harness>

\=item L<Test::Tech|Test::Tech>

\=item L<Test|Test>

=back
^


Copyright:
copyright © 2003 Software Diamonds.

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
^


HTML:
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
^



~-~
