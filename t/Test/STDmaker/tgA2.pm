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
$VERSION = '0.06';
$DATE = '2004/05/21';
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

t::Test::STDmaker::tgA1 - Software Test Description for Test::STDmaker::tg1

=head1 TITLE PAGE

 Detailed Software Test Description (STD)

 for

 Perl Test::STDmaker::tg1 Program Module

 Revision: -

 Version: 0.01

 Date: 2004/05/16

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
requirements of Perl Program Module (PM) L<Test::STDmaker::tg1|Test::STDmaker::tg1>
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

 T: 19 - 5,8^

=head2 ok: 1


  C:
     #########
     # For "TEST" 1.24 or greater that have separate std err output,
     # redirect the TESTERR to STDOUT
     #
     tech_config( 'Test.TESTERR', \*STDOUT );
 ^
 QC: my $expected1 = 'hello world';^
  N: Quiet Code^
  A: 'hello world'^
  E: $expected1^
 ok: 1^

=head2 ok: 2

  N: ok subroutine^
 TS: \&tolerance^
  A: 99^
  E: [100, 10]^
 ok: 2^

=head2 ok: 3

  N: skip subroutine^
  S: 0^
 TS: \&tolerance^
  A: 80^
  E: [100, 10]^
 ok: 3^

=head2 ok: 4

  N: Pass test^
  R: L<Test::STDmaker::tg1/capability-A [1]>^
  C: my $x = 2^
  C: my $y = 3^
  A: $x + $y^
 SE: 5^
 ok: 4^

=head2 ok: 5

  N: Todo test that passes^
  U: xy feature^
  A: $y-$x^
  E: 1^
 ok: 5^

=head2 ok: 6


  R:
     L<Test::STDmaker::tg1/capability-A [2]>
     L<Test::STDmaker::tg1/capability-B [1]>
 ^
  N: Test that fails^
  A: $x+4^
  E: 7^
 ok: 6^

=head2 ok: 7

  N: Skipped tests^
  S: 1^
  A: $x*$y*2^
  E: 6^
 ok: 7^

=head2 ok: 8

  N: Todo Test that Fails^
  U: zyw feature^
  S: 0^
  A: $x*$y*2^
  E: 6^
 ok: 8^

=head2 ok: 9

  N: demo only^
 DO: ^
  A: $x^
  E: $y^
  N: verify only^
 VO: ^
  A: $x^
  E: $x^
 ok: 9^

=head2 ok: 10,12,14

  N: Test loop^

  C:
     my @expected = ('200','201','202');
     my $i;
     for( $i=0; $i < 3; $i++) {
 ^
  A: $i+200^
  R: L<Test::STDmaker::tg1/capability-C [1]>^
  E: $expected[$i]^
 ok: 10,12,14^

=head2 ok: 11,13,15

  A: $i + ($x * 100)^
  R: L<Test::STDmaker::tg1/capability-B [4]>^
  E: $expected[$i]^
 ok: 11,13,15^

=head2 ok: 16

  C:     };^
  N: Failed test that skips the rest^
  R: L<Test::STDmaker::tg1/capability-B [2]>^
  A: $x + $y^
 SE: 6^
 ok: 16^

=head2 ok: 17

  N: A test to skip^
  A: $x + $y + $x^
  E: 9^
 ok: 17^

=head2 ok: 18

  N: A not skip to skip^
  S: 0^
  R: L<Test::STDmaker::tg1/capability-B [3]>^
  A: $x + $y + $x + $y^
  E: 10^
 ok: 18^

=head2 ok: 19

  N: A skip to skip^
  S: 1^
  R: L<Test::STDmaker::tg1/capability-B [3]>^
  A: $x + $y + $x + $y + $x^
  E: 10^
 ok: 19^



#######
#  
#  5. REQUIREMENTS TRACEABILITY
#
#

=head1 REQUIREMENTS TRACEABILITY

  Requirement                                                      Test
 ---------------------------------------------------------------- ----------------------------------------------------------------
 L<Test::STDmaker::tg1/capability-A [1]>                          L<t::Test::STDmaker::tgA1/ok: 4>
 L<Test::STDmaker::tg1/capability-A [2]>                          L<t::Test::STDmaker::tgA1/ok: 6>
 L<Test::STDmaker::tg1/capability-B [1]>                          L<t::Test::STDmaker::tgA1/ok: 6>
 L<Test::STDmaker::tg1/capability-B [2]>                          L<t::Test::STDmaker::tgA1/ok: 16>
 L<Test::STDmaker::tg1/capability-B [3]>                          L<t::Test::STDmaker::tgA1/ok: 18>
 L<Test::STDmaker::tg1/capability-B [3]>                          L<t::Test::STDmaker::tgA1/ok: 19>
 L<Test::STDmaker::tg1/capability-B [4]>                          L<t::Test::STDmaker::tgA1/ok: 11,13,15>
 L<Test::STDmaker::tg1/capability-C [1]>                          L<t::Test::STDmaker::tgA1/ok: 10,12,14>


  Test                                                             Requirement
 ---------------------------------------------------------------- ----------------------------------------------------------------
 L<t::Test::STDmaker::tgA1/ok: 10,12,14>                          L<Test::STDmaker::tg1/capability-C [1]>
 L<t::Test::STDmaker::tgA1/ok: 11,13,15>                          L<Test::STDmaker::tg1/capability-B [4]>
 L<t::Test::STDmaker::tgA1/ok: 16>                                L<Test::STDmaker::tg1/capability-B [2]>
 L<t::Test::STDmaker::tgA1/ok: 18>                                L<Test::STDmaker::tg1/capability-B [3]>
 L<t::Test::STDmaker::tgA1/ok: 19>                                L<Test::STDmaker::tg1/capability-B [3]>
 L<t::Test::STDmaker::tgA1/ok: 4>                                 L<Test::STDmaker::tg1/capability-A [1]>
 L<t::Test::STDmaker::tgA1/ok: 6>                                 L<Test::STDmaker::tg1/capability-A [2]>
 L<t::Test::STDmaker::tgA1/ok: 6>                                 L<Test::STDmaker::tg1/capability-B [1]>


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


=cut

__DATA__

Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
Classification: None^
Detail_Template: ^
End_User: General Public^
File_Spec: Unix^
Name: t::Test::STDmaker::tgA1^
Revision: -^
STD2167_Template: ^
Temp: temp.pl^
UUT: Test::STDmaker::tg1^
Version: 0.01^
Demo: tgA1.d^
Verify: tgA1.t^


 T: 19 - 5,8^


 C:
    #########
    # For "TEST" 1.24 or greater that have separate std err output,
    # redirect the TESTERR to STDOUT
    #
    tech_config( 'Test.TESTERR', \*STDOUT );
^

QC: my $expected1 = 'hello world';^
 N: Quiet Code^
 A: 'hello world'^
 E: $expected1^
ok: 1^

 N: ok subroutine^
TS: \&tolerance^

 A: 99^
 E: [100, 10]^
ok: 2^

 N: skip subroutine^
 S: 0^
TS: \&tolerance^

 A: 80^
 E: [100, 10]^
ok: 3^

 N: Pass test^
 R: L<Test::STDmaker::tg1/capability-A [1]>^
 C: my $x = 2^
 C: my $y = 3^
 A: $x + $y^
SE: 5^
ok: 4^

 N: Todo test that passes^
 U: xy feature^
 A: $y-$x^
 E: 1^
ok: 5^


 R:
    L<Test::STDmaker::tg1/capability-A [2]>
    L<Test::STDmaker::tg1/capability-B [1]>
^

 N: Test that fails^
 A: $x+4^
 E: 7^
ok: 6^

 N: Skipped tests^
 S: 1^
 A: $x*$y*2^
 E: 6^
ok: 7^

 N: Todo Test that Fails^
 U: zyw feature^
 S: 0^
 A: $x*$y*2^
 E: 6^
ok: 8^

 N: demo only^
DO: ^
 A: $x^
 E: $y^
 N: verify only^
VO: ^
 A: $x^
 E: $x^
ok: 9^

 N: Test loop^

 C:
    my @expected = ('200','201','202');
    my $i;
    for( $i=0; $i < 3; $i++) {
^

 A: $i+200^
 R: L<Test::STDmaker::tg1/capability-C [1]>^
 E: $expected[$i]^
ok: 10,12,14^

 A: $i + ($x * 100)^
 R: L<Test::STDmaker::tg1/capability-B [4]>^
 E: $expected[$i]^
ok: 11,13,15^

 C:     };^
 N: Failed test that skips the rest^
 R: L<Test::STDmaker::tg1/capability-B [2]>^
 A: $x + $y^
SE: 6^
ok: 16^

 N: A test to skip^
 A: $x + $y + $x^
 E: 9^
ok: 17^

 N: A not skip to skip^
 S: 0^
 R: L<Test::STDmaker::tg1/capability-B [3]>^
 A: $x + $y + $x + $y^
 E: 10^
ok: 18^

 N: A skip to skip^
 S: 1^
 R: L<Test::STDmaker::tg1/capability-B [3]>^
 A: $x + $y + $x + $y + $x^
 E: 10^
ok: 19^


QC:
    sub tolerance
    {   
        my ($actual,$expected) = @_;
        my ($average, $tolerance) = @$expected;
        use integer;
        $actual = (($average - $actual) * 100) / $average;
        no integer;
        (-$tolerance < $actual) && ($actual < $tolerance) ? 1 : 0;
    }
^


See_Also: L<Test::STDmaker::tg1>^
Copyright: This STD is public domain.^
HTML: ^


~-~
