#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
package  t::Test::STDmaker::tgA1;

use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE );
$VERSION = '0.02';
$DATE = '2003/06/21';
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


=head1 TITLE PAGE

 Detailed Software Test Description (STD)

 for

 Perl Test::STDmaker::tg1 Program Module

 Revision: -

 Version: 0.01

 Date: 2003/06/21

 Prepared for: General Public 

 Prepared by:  http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com

 Classification: None

=head1 SCOPE

This detail STD and the 
L<General Perl Program Module (PM) STD|Test::STD::PerlSTD>
establishes the tests to verify the
requirements of Perl Program Module (PM) L<Test::STDmaker::tg1|Test::STDmaker::tg1>

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

=head2 Test Plan

 T: 16 - 2,5^

=head2 ok: 1


  C:
     #########
     # For "TEST" 1.24 or greater that have separate std err output,
     # redirect the TESTERR to STDOUT
     #
     tech_config( 'Test.TESTERR', \*STDOUT );
 ^
  N: Pass test^
  R: L<Test::STDmaker::tg1/capability-A [1]>^
  C: my $x = 2^
  C: my $y = 3^
  A: $x + $y^
 SE: 5^
 ok: 1^

=head2 ok: 2

  N: Todo test that passes^
  U: xy feature^
  A: $y-$x^
  E: 1^
 ok: 2^

=head2 ok: 3


  R:
     L<Test::STDmaker::tg1/capability-A [2]>
     L<Test::STDmaker::tg1/capability-B [1]>
 ^
  N: Test that fails^
  A: $x+4^
  E: 7^
 ok: 3^

=head2 ok: 4

  N: Skipped tests^
  S: 1^
  A: $x*$y*2^
  E: 6^
 ok: 4^

=head2 ok: 5

  N: Todo Test that Fails^
  U: zyw feature^
  S: 0^
  A: $x*$y*2^
  E: 6^
 ok: 5^

=head2 ok: 6

  N: demo only^
 DO: ^
  A: $x^
  E: $y^
  N: verify only^
 VO: ^
  A: $x^
  E: $x^
 ok: 6^

=head2 ok: 7,9,11

  N: Test loop^

  C:
     my @expected = ('200','201','202');
     my $i;
     for( $i=0; $i < 3; $i++) {
 ^
  A: $i+200^
  R: L<Test::STDmaker::tg1/capability-C [1]>^
  E: $expected[$i]^
 ok: 7,9,11^

=head2 ok: 8,10,12

  A: $i + ($x * 100)^
  R: L<Test::STDmaker::tg1/capability-B [4]>^
  E: $expected[$i]^
 ok: 8,10,12^

=head2 ok: 13

  C:     };^
  N: Failed test that skips the rest^
  R: L<Test::STDmaker::tg1/capability-B [2]>^
  A: $x + $y^
 SE: 6^
 ok: 13^

=head2 ok: 14

  N: A test to skip^
  A: $x + $y + $x^
  E: 9^
 ok: 14^

=head2 ok: 15

  N: A not skip to skip^
  S: 0^
  R: L<Test::STDmaker::tg1/capability-B [3]>^
  A: $x + $y + $x + $y^
  E: 10^
 ok: 15^

=head2 ok: 16

  N: A skip to skip^
  S: 1^
  R: L<Test::STDmaker::tg1/capability-B [3]>^
  A: $x + $y + $x + $y + $x^
  E: 10^
 ok: 16^



#######
#  
#  5. REQUIREMENTS TRACEABILITY
#
#

=head1 REQUIREMENTS TRACEABILITY

  Requirement                                                      Test
 ---------------------------------------------------------------- ----------------------------------------------------------------
 L<Test::STDmaker::tg1/capability-A [1]>                          L<t::Test::STDmaker::tgA1/ok: 1>
 L<Test::STDmaker::tg1/capability-A [2]>                          L<t::Test::STDmaker::tgA1/ok: 3>
 L<Test::STDmaker::tg1/capability-B [1]>                          L<t::Test::STDmaker::tgA1/ok: 3>
 L<Test::STDmaker::tg1/capability-B [2]>                          L<t::Test::STDmaker::tgA1/ok: 13>
 L<Test::STDmaker::tg1/capability-B [3]>                          L<t::Test::STDmaker::tgA1/ok: 15>
 L<Test::STDmaker::tg1/capability-B [3]>                          L<t::Test::STDmaker::tgA1/ok: 16>
 L<Test::STDmaker::tg1/capability-B [4]>                          L<t::Test::STDmaker::tgA1/ok: 8,10,12>
 L<Test::STDmaker::tg1/capability-C [1]>                          L<t::Test::STDmaker::tgA1/ok: 7,9,11>


  Test                                                             Requirement
 ---------------------------------------------------------------- ----------------------------------------------------------------
 L<t::Test::STDmaker::tgA1/ok: 13>                                L<Test::STDmaker::tg1/capability-B [2]>
 L<t::Test::STDmaker::tgA1/ok: 15>                                L<Test::STDmaker::tg1/capability-B [3]>
 L<t::Test::STDmaker::tgA1/ok: 16>                                L<Test::STDmaker::tg1/capability-B [3]>
 L<t::Test::STDmaker::tgA1/ok: 1>                                 L<Test::STDmaker::tg1/capability-A [1]>
 L<t::Test::STDmaker::tgA1/ok: 3>                                 L<Test::STDmaker::tg1/capability-A [2]>
 L<t::Test::STDmaker::tgA1/ok: 3>                                 L<Test::STDmaker::tg1/capability-B [1]>
 L<t::Test::STDmaker::tgA1/ok: 7,9,11>                            L<Test::STDmaker::tg1/capability-C [1]>
 L<t::Test::STDmaker::tgA1/ok: 8,10,12>                           L<Test::STDmaker::tg1/capability-B [4]>


=cut

#######
#  
#  6. NOTES
#
#

=head1 NOTES

This STD is public domain.

#######
#
#  2. REFERENCED DOCUMENTS
#
#
#

=head1 SEE ALSO

 L<Test::STDmaker::tg1>

=back

=for html
<hr>
<!-- /BLK -->
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut

__DATA__

File_Spec: Unix^
UUT: Test::STDmaker::tg1^
Revision: -^
End_User: General Public^
Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
Detail_Template: ^
STD2167_Template: ^
Version: 0.01^
Classification: None^
Temp: temp.pl^
Demo: tgA1.d^
Verify: tgA1.t^


 T: 16 - 2,5^


 C:
    #########
    # For "TEST" 1.24 or greater that have separate std err output,
    # redirect the TESTERR to STDOUT
    #
    tech_config( 'Test.TESTERR', \*STDOUT );
^

 N: Pass test^
 R: L<Test::STDmaker::tg1/capability-A [1]>^
 C: my $x = 2^
 C: my $y = 3^
 A: $x + $y^
SE: 5^
ok: 1^

 N: Todo test that passes^
 U: xy feature^
 A: $y-$x^
 E: 1^
ok: 2^


 R:
    L<Test::STDmaker::tg1/capability-A [2]>
    L<Test::STDmaker::tg1/capability-B [1]>
^

 N: Test that fails^
 A: $x+4^
 E: 7^
ok: 3^

 N: Skipped tests^
 S: 1^
 A: $x*$y*2^
 E: 6^
ok: 4^

 N: Todo Test that Fails^
 U: zyw feature^
 S: 0^
 A: $x*$y*2^
 E: 6^
ok: 5^

 N: demo only^
DO: ^
 A: $x^
 E: $y^
 N: verify only^
VO: ^
 A: $x^
 E: $x^
ok: 6^

 N: Test loop^

 C:
    my @expected = ('200','201','202');
    my $i;
    for( $i=0; $i < 3; $i++) {
^

 A: $i+200^
 R: L<Test::STDmaker::tg1/capability-C [1]>^
 E: $expected[$i]^
ok: 7,9,11^

 A: $i + ($x * 100)^
 R: L<Test::STDmaker::tg1/capability-B [4]>^
 E: $expected[$i]^
ok: 8,10,12^

 C:     };^
 N: Failed test that skips the rest^
 R: L<Test::STDmaker::tg1/capability-B [2]>^
 A: $x + $y^
SE: 6^
ok: 13^

 N: A test to skip^
 A: $x + $y + $x^
 E: 9^
ok: 14^

 N: A not skip to skip^
 S: 0^
 R: L<Test::STDmaker::tg1/capability-B [3]>^
 A: $x + $y + $x + $y^
 E: 10^
ok: 15^

 N: A skip to skip^
 S: 1^
 R: L<Test::STDmaker::tg1/capability-B [3]>^
 A: $x + $y + $x + $y + $x^
 E: 10^
ok: 16^


See_Also:  L<Test::STDmaker::tg1>^
Copyright: This STD is public domain.^

HTML:
<hr>
<!-- /BLK -->
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>
^



~-~
