#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
package  Test::STDmaker::tgC1;

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


=head1 TITLE PAGE

 Detailed Software Test Description (STD)

 for

 Perl Test::STDmaker::tg1 Program Module

 Revision: -

 Version: 0.01

 Date: 2003/06/14

 Prepared for: General Public 

 Prepared by:  http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com

 Classification: None

=head1 SCOPE

This detail STD and the 
L<General Perl Program Module (PM) STD|Test::STD>
establishes the tests to verify the
requirements of Perl Program Module (PM) L<Test::STDmaker::tg1|Test::STDmaker::tg1>

The format of this STD is a tailored L<2167A STD DID|US_DOD::STD>.
in accordance with L<Tailor02|Test::Template::Tailor02>.

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

=head2 Test Plan

 T: 2^

=head2 ok: 1

  R: L<Test::STDmaker::tg1/capability-A [1]>^
  C: my $x = 2^
  C: my $y = 3^
  A: $x + $y^
 SE: '5'^
 ok: 1^

=head2 ok: 2

  A: ($x+$y,$y-$x)^
  E: '5','1'^
 ok: 2^



#######
#  
#  5. REQUIREMENTS TRACEABILITY
#
#

=head1 REQUIREMENTS TRACEABILITY

  Requirement                                                      Test
 ---------------------------------------------------------------- ----------------------------------------------------------------
 L<Test::STDmaker::tg1/capability-A [1]>                          L<Test::STDmaker::tgC1/ok: 1>


  Test                                                             Requirement
 ---------------------------------------------------------------- ----------------------------------------------------------------
 L<Test::STDmaker::tgC1/ok: 1>                                    L<Test::STDmaker::tg1/capability-A [1]>


=cut

#######
#  
#  6. NOTES
#
#

=head1 NOTES

This STD is public domain

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

File_Spec: os2^
UUT: Test::STDmaker::tg1^
Revision: -^
End_User: General Public^
Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
Detail_Template: ^
STD2167_Template: ^
Version: 0.01^
Classification: None^
Temp: xx\temp.pl^
Demo: yy\zz\tg1B.d^
Verify: ccc\tg1B.t^


 T: 2^

 R: L<Test::STDmaker::tg1/capability-A [1]>^
 C: my $x = 2^
 C: my $y = 3^
 A: $x + $y^
SE: '5'^
ok: 1^

 A: ($x+$y,$y-$x)^
 E: '5','1'^
ok: 2^


See_Also: L<Test::STDmaker::tg1>^
Copyright: This STD is public domain^

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
