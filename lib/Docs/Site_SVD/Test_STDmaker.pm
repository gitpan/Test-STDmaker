#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
package  Docs::Site_SVD::Test_STDmaker;

use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE );
$VERSION = '0.18';
$DATE = '2004/05/22';
$FILE = __FILE__;

use vars qw(%INVENTORY);
%INVENTORY = (
    'lib/Docs/Site_SVD/Test_STDmaker.pm' => [qw(0.18 2004/05/22), 'revised 0.17'],
    'MANIFEST' => [qw(0.18 2004/05/22), 'generated, replaces 0.17'],
    'Makefile.PL' => [qw(0.18 2004/05/22), 'generated, replaces 0.17'],
    'README' => [qw(0.18 2004/05/22), 'generated, replaces 0.17'],
    'lib/Test/STDmaker.pm' => [qw(1.19 2004/05/22), 'unchanged'],
    'lib/Test/STDmaker/Check.pm' => [qw(1.14 2004/05/22), 'unchanged'],
    'lib/Test/STDmaker/Demo.pm' => [qw(1.14 2004/05/21), 'unchanged'],
    'lib/Test/STDmaker/STD.pm' => [qw(1.11 2004/05/21), 'unchanged'],
    'lib/Test/STDmaker/Verify.pm' => [qw(1.15 2004/05/22), 'unchanged'],
    'lib/Test/STD/PerlSTD.pm' => [qw(1.08 2004/05/19), 'unchanged'],
    't/Test/STDmaker/STDmaker.d' => [qw(0.15 2004/05/22), 'revised 0.14'],
    't/Test/STDmaker/STDmaker.pm' => [qw(0.13 2004/05/22), 'revised 0.12'],
    't/Test/STDmaker/STDmaker.t' => [qw(0.15 2004/05/22), 'revised 0.14'],
    't/Test/STDmaker/tg0.pm' => [qw(0.03 2004/04/09), 'unchanged'],
    't/Test/STDmaker/tg2A.pm' => [qw(0.05 2004/05/22), 'revised 0.04'],
    't/Test/STDmaker/tg2B.pm' => [qw(0.06 2004/05/22), 'revised 0.05'],
    't/Test/STDmaker/tgA0.pm' => [qw(0.07 2004/05/22), 'revised 0.06'],
    't/Test/STDmaker/tgA1.pm' => [qw(0.06 2004/05/22), 'new'],
    't/Test/STDmaker/tgA2.pm' => [qw(0.08 2004/05/22), 'revised 0.07'],
    't/Test/STDmaker/tgA2A2.txt' => [qw(0.12 2004/05/22), 'revised 0.11'],
    't/Test/STDmaker/tgA2A3.txt' => [qw(0.12 2004/05/22), 'revised 0.11'],
    't/Test/STDmaker/tgA2B.txt' => [qw(0.09 2004/05/22), 'revised 0.08'],
    't/Test/STDmaker/tgA2C.txt' => [qw(0.1 2004/05/22), 'revised 0.09'],
    't/Test/STDmaker/tgB0.pm' => [qw(0.02 2004/05/18), 'unchanged'],
    't/Test/STDmaker/tgB1.pm' => [qw(0.01 2004/05/22), 'new'],
    't/Test/STDmaker/tgB2.pm' => [qw(0.03 2004/05/21), 'unchanged'],
    't/Test/STDmaker/tgB2.txt' => [qw(0.09 2004/05/14), 'unchanged'],
    't/Test/STDmaker/tgC0.pm' => [qw(0.04 2004/05/18), 'unchanged'],
    't/Test/STDmaker/tgC1.pm' => [qw(0.01 2004/05/22), 'new'],
    't/Test/STDmaker/tgC2.pm' => [qw(0.05 2004/05/21), 'unchanged'],
    't/Test/STDmaker/tgD0.pm' => [qw(0.06 2004/05/22), 'new'],
    't/Test/STDmaker/tmake.pl' => [qw(1.06 2004/05/22), 'unchanged'],
    't/Test/STDmaker/Text/Scrub.pm' => [qw(1.14 2004/05/22), 'unchanged'],
    't/Test/STDmaker/Test/Tech.pm' => [qw(1.26 2004/05/22), 'unchanged'],
    't/Test/STDmaker/Data/Secs2.pm' => [qw(1.26 2004/05/22), 'unchanged'],
    't/Test/STDmaker/Data/Str2Num.pm' => [qw(0.08 2004/05/22), 'unchanged'],
    't/Test/STDmaker/Data/Startup.pm' => [qw(0.07 2004/05/22), 'unchanged'],

);

########
# The ExtUtils::SVDmaker module uses the data after the __DATA__ 
# token to automatically generate this file.
#
# Don't edit anything before __DATA_. Edit instead
# the data after the __DATA__ token.
#
# ANY CHANGES MADE BEFORE the  __DATA__ token WILL BE LOST
#
# the next time ExtUtils::SVDmaker generates this file.
#
#



=head1 NAME

Docs::Site_SVD::Test_STDmaker - generate test scripts, demo scripts from a test description short hand

=head1 Title Page

 Software Version Description

 for

 Docs::Site_SVD::Test_STDmaker - generate test scripts, demo scripts from a test description short hand

 Revision: Q

 Version: 0.18

 Date: 2004/05/22

 Prepared for: General Public 

 Prepared by:  SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>

 Copyright: copyright © 2003 Software Diamonds

 Classification: NONE

=head1 1.0 SCOPE

This paragraph identifies and provides an overview
of the released files.

=head2 1.1 Identification

This release,
identified in L<3.2|/3.2 Inventory of software contents>,
is a collection of Perl modules that
extend the capabilities of the Perl language.

=head2 1.2 System overview

The system is the Perl programming language software.
As established by the L<Perl referenced documents|/2.0 SEE ALSO>,
the  "L<Test::STDmaker|Test::STDmaker>" 
program module extends the Perl language.

The input to "L<Test::STDmaker|Test::STDmaker>" is the __DATA__
section of Software Test Description (STD)
program module.
The __DATA__ section must contain STD
forms text database in the
L<DataPort::FileType::DataDB|DataPort::FileType::DataDB> format.

Using the data in the database, the
"L<Test::STDmaker|Test::STDmaker>" module
provides the following:

=over 4

=item 1

Automate Perl related programming needed to create a
test script resulting in reduction of time and cost.

=item 2

Translate a short hand Software Test Description (STD)
file into a Perl test script that eventually makes use of 
the "L<Test|Test>" module via added capabilities 
of the "L<Test::Tech|Test::Tech> module.

=item 3

Translate the sort hand STD data file into a Perl demo
script that demonstrates the features of the 
the module under test.

=item 4

Replace the POD of a the STD file
with the __DATA__ formDB text database,
information required by
a US Department of Defense (DOD) 
Software Test Description (L<STD|Docs::US_DOD::STD>) 
Data Item Description (DID).

=back

The C<Test::STDmaker> package relieves the designer
and developer from the burden of filling
out templates, counting oks, providing
documentation examples, tracing tests to
test requirments, and other such time
consuming, boring, development tasks.
Instead the designers and developrs need
only to fill in an a form. 
The C<Test::STDmaker> will take it from there
and automatically and quickly generate
the desired test scripts, demo scripts,
and test description documents.

See the L<Test::STDmaker|Test::STDmaker> POD for
further detail on the text database fields and the processing.

=head2 1.3 Document overview.

This document releases Test::STDmaker version 0.18
providing description of the inventory, installation
instructions and other information necessary to
utilize and track this release.

=head1 3.0 VERSION DESCRIPTION

All file specifications in this SVD
use the Unix operating
system file specification.

=head2 3.1 Inventory of materials released.

This document releases the file 

 Test-STDmaker-0.18.tar.gz

found at the following repository(s):

  http://www.softwarediamonds/packages/
  http://www.perl.com/CPAN/authors/id/S/SO/SOFTDIA/

Restrictions regarding duplication and license provisions
are as follows:

=over 4

=item Copyright.

copyright © 2003 Software Diamonds

=item Copyright holder contact.

 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>

=item License.

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

=item 3

Commercial installation of the binary or source
must visually present to the installer 
the above copyright notice,
this list of conditions intact,
that the original source is available
at http://softwarediamonds.com
and provide means
for the installer to actively accept
the list of conditions; 
otherwise, a license fee must be paid to
Softwareware Diamonds.


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

=back

=head2 3.2 Inventory of software contents

The content of the released, compressed, archieve file,
consists of the following files:

 file                                                         version date       comment
 ------------------------------------------------------------ ------- ---------- ------------------------
 lib/Docs/Site_SVD/Test_STDmaker.pm                           0.18    2004/05/22 revised 0.17
 MANIFEST                                                     0.18    2004/05/22 generated, replaces 0.17
 Makefile.PL                                                  0.18    2004/05/22 generated, replaces 0.17
 README                                                       0.18    2004/05/22 generated, replaces 0.17
 lib/Test/STDmaker.pm                                         1.19    2004/05/22 unchanged
 lib/Test/STDmaker/Check.pm                                   1.14    2004/05/22 unchanged
 lib/Test/STDmaker/Demo.pm                                    1.14    2004/05/21 unchanged
 lib/Test/STDmaker/STD.pm                                     1.11    2004/05/21 unchanged
 lib/Test/STDmaker/Verify.pm                                  1.15    2004/05/22 unchanged
 lib/Test/STD/PerlSTD.pm                                      1.08    2004/05/19 unchanged
 t/Test/STDmaker/STDmaker.d                                   0.15    2004/05/22 revised 0.14
 t/Test/STDmaker/STDmaker.pm                                  0.13    2004/05/22 revised 0.12
 t/Test/STDmaker/STDmaker.t                                   0.15    2004/05/22 revised 0.14
 t/Test/STDmaker/tg0.pm                                       0.03    2004/04/09 unchanged
 t/Test/STDmaker/tg2A.pm                                      0.05    2004/05/22 revised 0.04
 t/Test/STDmaker/tg2B.pm                                      0.06    2004/05/22 revised 0.05
 t/Test/STDmaker/tgA0.pm                                      0.07    2004/05/22 revised 0.06
 t/Test/STDmaker/tgA1.pm                                      0.06    2004/05/22 new
 t/Test/STDmaker/tgA2.pm                                      0.08    2004/05/22 revised 0.07
 t/Test/STDmaker/tgA2A2.txt                                   0.12    2004/05/22 revised 0.11
 t/Test/STDmaker/tgA2A3.txt                                   0.12    2004/05/22 revised 0.11
 t/Test/STDmaker/tgA2B.txt                                    0.09    2004/05/22 revised 0.08
 t/Test/STDmaker/tgA2C.txt                                    0.1     2004/05/22 revised 0.09
 t/Test/STDmaker/tgB0.pm                                      0.02    2004/05/18 unchanged
 t/Test/STDmaker/tgB1.pm                                      0.01    2004/05/22 new
 t/Test/STDmaker/tgB2.pm                                      0.03    2004/05/21 unchanged
 t/Test/STDmaker/tgB2.txt                                     0.09    2004/05/14 unchanged
 t/Test/STDmaker/tgC0.pm                                      0.04    2004/05/18 unchanged
 t/Test/STDmaker/tgC1.pm                                      0.01    2004/05/22 new
 t/Test/STDmaker/tgC2.pm                                      0.05    2004/05/21 unchanged
 t/Test/STDmaker/tgD0.pm                                      0.06    2004/05/22 new
 t/Test/STDmaker/tmake.pl                                     1.06    2004/05/22 unchanged
 t/Test/STDmaker/Text/Scrub.pm                                1.14    2004/05/22 unchanged
 t/Test/STDmaker/Test/Tech.pm                                 1.26    2004/05/22 unchanged
 t/Test/STDmaker/Data/Secs2.pm                                1.26    2004/05/22 unchanged
 t/Test/STDmaker/Data/Str2Num.pm                              0.08    2004/05/22 unchanged
 t/Test/STDmaker/Data/Startup.pm                              0.07    2004/05/22 unchanged


=head2 3.3 Changes

Changes are as follows:

=over 4

=item STD-STDgen-0.01

This is the original release. 
There are no previous releases to change.

=item STD-STDgen-0.02

=over 4

=item t/STD/tgA0.std changes

Added test for DO: field

Added test for VO: field

Added a loop around two A: and E: fields.

=item STD/TestGen.pm changes

Added requirements for DO: VO: and looping
a test

=item STD/Check.pm changes

Added and revise code to make DO: VO: and
looping work

=item STD/Verify.pm changes

Added and revise code to make DO: VO: and
looping work

=back

=item Test-STDmaker-0.01

=over 4

=item *

Low level subroutines are broken out as separate distribution
modules: Test::TestUtil Test::Tech DataPort::FileType::FormDB DataPort::DataFile

=item *

The STD::STDgen was renamed Test::STDmaker to comply with CPAN
directives to use existing top levels whenever possible.

=back

=item Test-STDmaker-0.02

Replaced using Test::TestUtil with File::FileUtil, Test::STD::Scrub, Test::STD::STDutil

Added tests to deal with the fact that Data::Dumper produces different results
on different Perls

Added "Test" and "Data::Dumper" modules to the t directory so there are no
surprises because of Test versions.

Changed the generated test script to use subroutine interface of "Test::Tech"
The object interface was removed.

=item Test-STDmaker-0.03

Make the same additions to @INC for "Test::STDtype::Demo" and "Test::STD::Check" as for
"Test::STDtype::Verify".

Changed from using "File::FileUtil" (disappeared) to the File::* modules broken out from
"File::FileUtil"

=item Test-STDmaker-0.04

Changed from using "Test::STD::STDutil" (disappeared) to the File::* modules broken out from
"Test::STD::STDutil"

Added the -options_pm option and the ability to make multiple tests from a file list.

=item Test-STDmaker-0.05

Chnage name of Test::Table to Test::Column. Test::Table taken.

=item Test-STDmaker-0.06

Added DM Diagnostic Message tag

Change the test so that test support program modules resides in distribution
directory tlib directory instead of the lib directory. 
Because they are no longer in the lib directory, 
test support files will not be installed as a pre-condition for the 
test of this module.
The test of this module will precede immediately.
The test support files in the tlib directory will vanish after
the installtion.

=item Test-STDmaker-0.07

Change the location where of Test::STDmaker expects the test library from tlib
to the the same directory as the test script. Eliminated the need for File::TestPath.
which adds the tlib directory to the @INC directory of lists with the below
Perl build-ins:

 use FindBIN 
 use lib $FindBin::Bin;

Replace the obsoleted File::PM2File program module with File::Where.

Eliminated detecting broken Perl where Data::Dumper treats arrays of number as
strings on some Perl and numbers on others. 
If something is broken, replace it with a fixed version in order to
pass the tests for the Test::STDmaker program module.

=item Test-STDmaker-0.08

 Subject: FAIL Test-Tech-0.18 i586-linux 2.4.22-4tr 
 From: cpansmoke@alternation.net 
 Date: Thu,  8 Apr 2004 15:09:35 -0300 (ADT) 

 PERL_DL_NONLAZY=1 /usr/bin/perl5.8.0 "-MExtUtils::Command::MM" "-e" "test_harness(0, 'blib/lib', 'blib/arch')" t/Test/Tech/Tech.t
 t/Test/Tech/Tech....Can't locate FindBIN.pm

 Summary of my perl5 (revision 5.0 version 8 subversion 0) configuration:
   Platform:
     osname=linux, osvers=2.4.22-4tr, archname=i586-linux

This is a capitalization problem. The program module name is 'FindBin' not 'FindBIN' which
is part of Perl. Microsoft does not care about capitalization differences while linux
does. This error is in the test script automatically generated by C<Test::STDmaker>
and was just introduced when moved test script libraries from C<tlib> to the directory
of the test script. Repaired C<Test::STDmaker> and regenerated the distribution.

=item Test-STDmaker-0.09

Added the generated xxxx.d demo script prints out the test name as a comment.

Added the C<report> option that automatically runs all tests scripts and
replaces the UUT program module C<=headx Test Report> section with the
output.

The test software uses the lastest version of C<Test::Tech>. This impacted
the expected values of the old tests slightly. Made the adjustments.

=item Test-STDmaker-0.10

Added the C<&Test::Tech::is_skip> subroutine.

Added a left edge space column to the =\headx test report automatically
generated section  so that POD formats it as code.

Changed the look of the C<demo> subroutine output to better resemble Perl code. 
Print the code straight forward without leading '=>'. Put a Perl comment '# ' in front of
each result line instead of printing it straing forward.

Added the C<QC:> that is same for the C<C:> field except for the demo script.
The demo script silently executes a C<QC:>, quiet code, data.

Recoded so that none of the modules uses C<File::Data> program module.

=item Test-STDmaker-0.11

CPAN is picking up the templates as PODs. Escape out the template POD commands
with a '\'.

Under certain test conditions, the Software Test Description (STD)
program module (PM) cannot be found.

From: "Thurn, Martin" <martin.thurn@ngc.com> 
Subject: FAIL Test-STDmaker-0.10 sun4-solaris 2.8 

Can't locate t/Test/STDmaker/tgA1.pm in @INC 
(@INC contains: . /disk1/src/PERL/.cpanplus/5.9.1/5.9.1/build/Test-STDmaker-0.10/t/Test

Added code that will add the appropriate directory to @INC for these test conditions.

For regression tests, the POD describes the relationship between the 'lib' and the 't'
directories so that the C<Test::STDmaker> package can find the STD PM.

=item Test-STDmaker-0.12

Problems with CPAN picking up wrong NAME for C<Test::STDmaker::Verify> and 
C<Test::STD::PerlSTD>. Fixed

Use lastest C<Data::Secs2> that does not use C<Data::SecsPack> unless needed.
Some of the sites having trouble loading C<Data::SecsPack> GMP libraray.

Changed C<Test::STDmaker::Demo> and C<Test::STDmaker::Check> so they load
C<Test::Tech> after setting up C<@INC>. Else missing finding some
test library modules because they are not in the C<INC> path.

=item Test-STDmaker-0.13

Test Failure:

 Subject: FAIL Test-STDmaker-0.12 ppc-linux 2.4.19-4a 
 From: alian@cpan.org (CPAN Tester + CPAN++ automate) 

Perl lib version (v5.8.4) doesn't match executable version (v5.6.0) at 
/usr/local/perl-5.8.4/lib/5.8.4/ppc-linux/Config.pm line 32.
Compilation failed in require at /usr/local/perl-5.8.4/lib/5.8.4/FindBin.pm line 97.
BEGIN failed--compilation aborted at /usr/local/perl-5.8.4/lib/5.8.4/FindBin.pm line 97.
Compilation failed in require at temp.pl line 8.

Analysis:

Line 8 is a backtick `perl $command`. To get to line 8 everything must
going well. Thus, suspect that the test harness perl executable is 
different than the command line perl executable. 

Corrective Action

Introduced the C<perl_command> subroutine that uses C<$^X> to return the current executable Perl.
Use the results of this subroutine instead of 'perl' in backticks.
See how it goes.

=item Test-STDmaker-0.14

Test Failure:

Subject: FAIL Test-STDmaker-0.13 ppc-linux 2.4.19-4a 
From: alian@cpan.org (CPAN Tester + CPAN++ automate) 

PERL_DL_NONLAZY=1 /usr/local/perl-5.8.4/bin/perl "-MExtUtils::Command::MM" "-e" "test_harness(0, 'blib/lib', 'blib/arch')" t/Test/STDmaker/STDmaker.t
t/Test/STDmaker/STDmaker....Perl lib version (v5.8.4) doesn't match executable version (v5.6.0) at /usr/local/perl-5.8.4/lib/5.8.4/ppc-linux/Config.pm line 32.
Compilation failed in require at /usr/local/perl-5.8.4/lib/5.8.4/FindBin.pm line 97.
BEGIN failed--compilation aborted at /usr/local/perl-5.8.4/lib/5.8.4/FindBin.pm line 97.
Compilation failed in require at tgB1.t line 43.

Corrective Action:

Opps. Have C<`perl $commands`> not only in the Unit Under Test (UUT) but also the test
scripts. Looks like using `C<$^X> $command` fixed the UUT so change the ones in the
test script also.

=item Test-STDmaker-0.15

Test Failure:

 Subject: FAIL Test-STDmaker-0.14 sparc-linux 2.4.21-pre7 
 From: alian@cpan.org (alian) 

 t/Test/STDmaker/STDmaker....Can't locate object method "t edit anything before __DATA_. Edit 
 ...

Analysis:

The text begin picked up in method comes from C<Test::STDmaker::STD.pm> 

 # Don't edit anything before __DATA_. Edit instead
 
within a <<'EOF' here statement.

Corrective Action:

Change the "Don't" to "Do not"

=item Test-STDmaker-0.16

Test Failure:

 Subject: FAIL Test-STDmaker-0.15 ppc-linux 2.4.19-4a 
 From: alian@cpan.org (CPAN Tester + CPAN++ automate) 

t/Test/STDmaker/STDmaker....Missing right curly or square bracket at temp.pl line 331, at end of line
syntax error at temp.pl line 331, at EOF

Analysis:

The generated Perl has semicolon after a right curly bracket, "};". Some Perl get upset and do not
count the right curly bracket. 

Corrective Action:

Changed the C<Test::STDmaker::Clean>, C<Test::STDmaker::Demo> and
C<Test::STDMaker::Verify> that automatically adds a semicolon to a C<C> test description if one
does not exist, also not to add the semicolon if a right or left curly bracket exists at the
end of the C<C> test description field. Add the option, C<nosemi>, to disable the automatic
addition of a semicolon to the end of C <C> test description field.

=item Test-STDmaker-0.17

Test Failure:

Same of Test-STDmaker-0.16

Analysis:

Opps. Did not change manual "};" to "}"

Corrections:

Change all "};" in all test case test scripts. Still do not know if this
will cure the deficiency so added diagnostic steps that will provided
added feedback.

=item Test-STDmaker-0.18

Test Failure:

Same as Test-STDmaker-0.17. No output from added diagnostic messages.

Debug Mode:

Backed out test descriptions that producde curly brackets except for C<BEGIN> and C<END>
blocks of generated scripts. Added a warn($diag) to see if get diagnostic messages.
The backed test descriptions can be added as another test once get some green PASSES.

=back

=head2 3.4 Adaptation data.

This installation requires that the installation site
has the Perl programming language installed.
There are no other additional requirements or tailoring needed of 
configurations files, adaptation data or other software needed for this
installation particular to any installation site.

=head2 3.5 Related documents.

There are no related documents needed for the installation and
test of this release.

=head2 3.6 Installation instructions.

Instructions for installation, installation tests
and installation support are as follows:

=over 4

=item Installation Instructions.

To installed the release package, use the CPAN module
pr PPM module in the Perl release
or the INSTALL.PL script at the following web site:

 http://packages.SoftwareDiamonds.com

Follow the instructions for the the chosen installation software.

If all else fails, the file may be manually installed.
Enter one of the following repositories in a web browser:

  http://www.softwarediamonds/packages/
  http://www.perl.com/CPAN/authors/id/S/SO/SOFTDIA/

Right click on 'Test-STDmaker-0.18.tar.gz' and download to a temporary
installation directory.
Enter the following where $make is 'nmake' for microsoft
windows; otherwise 'make'.

 gunzip Test-STDmaker-0.18.tar.gz
 tar -xf Test-STDmaker-0.18.tar
 perl Makefile.PL
 $make test
 $make install

On Microsoft operating system, nmake, tar, and gunzip 
must be in the exeuction path. If tar and gunzip are
not install, download and install unxutils from

 http://packages.softwarediamonds.com

VERY IMPORTANT:

The distribution package contains the cover
C<bin/tmake.pl> perl command script.
Manually copy this into the execution path
in order to use C<STDmaker> from the
command line. Rename it if there is a
name conflict or just do not like the name.

=item Prerequistes.

 'File::AnySpec' => '1.1',
 'File::Package' => '1.1',
 'File::Where' => '1.16',
 'File::SmartNL' => '1.1',
 'Text::Replace' => '1.08',
 'Text::Column' => '1.08',
 'File::Maker' => '0.03',
 'Tie::Form' => '0.02',
 'Tie::Layers' => '0.04',
 'Test::Harness' => '2.42',
 'Data::Startup' => '0.02',


=item Security, privacy, or safety precautions.

None.

=item Installation Tests.

Most Perl installation software will run the following test script(s)
as part of the installation:

 t/Test/STDmaker/STDmaker.t

=item Installation support.

If there are installation problems or questions with the installation
contact

 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>

=back

=head2 3.7 Possible problems and known errors

Establish all the requirements.

=head1 4.0 NOTES

The following are useful acronyms:


=over 4

=item .d

extension for a Perl demo script file

=item .pm

extension for a Perl Library Module

=item .t

extension for a Perl test script file

=item DID

Data Item Description

=item POD

Plain Old Documentation

=item STD

Software Test Description

=item SVD

Software Version Description

=back

=head1 2.0 SEE ALSO

=over 4

=item L<Test::STDmaker|Test::STDmaker>

=item L<Tie::Form|Tie::Form>

=item L<Test::Tech|Test::Tech>

=item L<Test|Test>

=item L<Data::Secs2|Data::Secs2>

=item L<Data::Str2Num|Data::Str2Num>

=item L<Test::STDmaker::Check|Test::STDmaker::Check>

=item L<Test::STDmaker::Demo|Test::STDmaker::Demo>

=item L<Test::STDmaker::STD|Test::STDmaker::STD>

=item L<Test::STDmaker::Verify|Test::STDmaker::Verify>

=item L<Test::STD::PerlSTD|Test::STD::PerlSTD>

=item L<US DOD Software Development Standard|Docs::US_DOD::STD2167A>

=item L<US DOD Specification Practices|Docs::US_DOD::STD490A>

=item L<Software Test Description (STD) DID|Docs::US_DOD::STD>

=back

=for html
<hr>
<p><br>
<!-- BLK ID="PROJECT_MANAGEMENT" -->
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

1;

__DATA__

DISTNAME: Test-STDmaker^
REPOSITORY_DIR: packages^

VERSION : 0.18^
FREEZE: 0^
PREVIOUS_RELEASE: 0.17^
REVISION: Q^

PREVIOUS_DISTNAME:  ^
AUTHOR  : SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>^

ABSTRACT: generate test scripts, demo scripts from a test description short hand.^
TITLE   : Docs::Site_SVD::Test_STDmaker - generate test scripts, demo scripts from a test description short hand^
END_USER: General Public^
COPYRIGHT: copyright © 2003 Software Diamonds^
CLASSIFICATION: NONE^
TEMPLATE:  ^
CSS: help.css^
SVD_FSPEC: Unix^ 

REPOSITORY: 
  http://www.softwarediamonds/packages/
  http://www.perl.com/CPAN/authors/id/S/SO/SOFTDIA/
^


COMPRESS: gzip^
COMPRESS_SUFFIX: gz^

RESTRUCTURE:  ^
CHANGE2CURRENT:  ^

AUTO_REVISE:
lib/Test/STDmaker.pm
lib/Test/STDmaker/*
lib/Test/STD/*
t/Test/STDmaker/*
t/Test/STDmaker/lib/*
t/Test/STDmaker/lib/Data/*
bin/tmake.pl => t/Test/STDmaker/tmake.pl
lib/Text/Scrub.pm => t/Test/STDmaker/Text/Scrub.pm
lib/Test/Tech.pm => t/Test/STDmaker/Test/Tech.pm
lib/Data/Secs2.pm => t/Test/STDmaker/Data/Secs2.pm
lib/Data/Str2Num.pm => t/Test/STDmaker/Data/Str2Num.pm
lib/Data/Startup.pm => t/Test/STDmaker/Data/Startup.pm
^

PREREQ_PM:
'File::AnySpec' => '1.1',
'File::Package' => '1.1',
'File::Where' => '1.16',
'File::SmartNL' => '1.1',
'Text::Replace' => '1.08',
'Text::Column' => '1.08',
'File::Maker' => '0.03',
'Tie::Form' => '0.02',
'Tie::Layers' => '0.04',
'Test::Harness' => '2.42',
'Data::Startup' => '0.02',
^

README_PODS: lib/Test/STDmaker.pm^
TESTS: t/Test/STDmaker/STDmaker.t^
EXE_FILES:  ^

CAPABILITIES:
The system is the Perl programming language software.
As established by the L<Perl referenced documents|/2.0 SEE ALSO>,
the  "L<Test::STDmaker|Test::STDmaker>" 
program module extends the Perl language.

The input to "L<Test::STDmaker|Test::STDmaker>" is the __DATA__
section of Software Test Description (STD)
program module.
The __DATA__ section must contain STD
forms text database in the
L<DataPort::FileType::DataDB|DataPort::FileType::DataDB> format.

Using the data in the database, the
"L<Test::STDmaker|Test::STDmaker>" module
provides the following:

\=over 4

\=item 1

Automate Perl related programming needed to create a
test script resulting in reduction of time and cost.

\=item 2

Translate a short hand Software Test Description (STD)
file into a Perl test script that eventually makes use of 
the "L<Test|Test>" module via added capabilities 
of the "L<Test::Tech|Test::Tech> module.

\=item 3

Translate the sort hand STD data file into a Perl demo
script that demonstrates the features of the 
the module under test.

\=item 4

Replace the POD of a the STD file
with the __DATA__ formDB text database,
information required by
a US Department of Defense (DOD) 
Software Test Description (L<STD|Docs::US_DOD::STD>) 
Data Item Description (DID).

\=back

The C<Test::STDmaker> package relieves the designer
and developer from the burden of filling
out templates, counting oks, providing
documentation examples, tracing tests to
test requirments, and other such time
consuming, boring, development tasks.
Instead the designers and developrs need
only to fill in an a form. 
The C<Test::STDmaker> will take it from there
and automatically and quickly generate
the desired test scripts, demo scripts,
and test description documents.

See the L<Test::STDmaker|Test::STDmaker> POD for
further detail on the text database fields and the processing.

^

CHANGES:
Changes are as follows:

\=over 4

\=item STD-STDgen-0.01

This is the original release. 
There are no previous releases to change.

\=item STD-STDgen-0.02

\=over 4

\=item t/STD/tgA0.std changes

Added test for DO: field

Added test for VO: field

Added a loop around two A: and E: fields.

\=item STD/TestGen.pm changes

Added requirements for DO: VO: and looping
a test

\=item STD/Check.pm changes

Added and revise code to make DO: VO: and
looping work

\=item STD/Verify.pm changes

Added and revise code to make DO: VO: and
looping work

\=back

\=item Test-STDmaker-0.01

\=over 4

\=item *

Low level subroutines are broken out as separate distribution
modules: Test::TestUtil Test::Tech DataPort::FileType::FormDB DataPort::DataFile

\=item *

The STD::STDgen was renamed Test::STDmaker to comply with CPAN
directives to use existing top levels whenever possible.

\=back

\=item Test-STDmaker-0.02

Replaced using Test::TestUtil with File::FileUtil, Test::STD::Scrub, Test::STD::STDutil

Added tests to deal with the fact that Data::Dumper produces different results
on different Perls

Added "Test" and "Data::Dumper" modules to the t directory so there are no
surprises because of Test versions.

Changed the generated test script to use subroutine interface of "Test::Tech"
The object interface was removed.

\=item Test-STDmaker-0.03

Make the same additions to @INC for "Test::STDtype::Demo" and "Test::STD::Check" as for
"Test::STDtype::Verify".

Changed from using "File::FileUtil" (disappeared) to the File::* modules broken out from
"File::FileUtil"

\=item Test-STDmaker-0.04

Changed from using "Test::STD::STDutil" (disappeared) to the File::* modules broken out from
"Test::STD::STDutil"

Added the -options_pm option and the ability to make multiple tests from a file list.

\=item Test-STDmaker-0.05

Chnage name of Test::Table to Test::Column. Test::Table taken.

\=item Test-STDmaker-0.06

Added DM Diagnostic Message tag

Change the test so that test support program modules resides in distribution
directory tlib directory instead of the lib directory. 
Because they are no longer in the lib directory, 
test support files will not be installed as a pre-condition for the 
test of this module.
The test of this module will precede immediately.
The test support files in the tlib directory will vanish after
the installtion.

\=item Test-STDmaker-0.07

Change the location where of Test::STDmaker expects the test library from tlib
to the the same directory as the test script. Eliminated the need for File::TestPath.
which adds the tlib directory to the @INC directory of lists with the below
Perl build-ins:

 use FindBIN 
 use lib $FindBin::Bin;

Replace the obsoleted File::PM2File program module with File::Where.

Eliminated detecting broken Perl where Data::Dumper treats arrays of number as
strings on some Perl and numbers on others. 
If something is broken, replace it with a fixed version in order to
pass the tests for the Test::STDmaker program module.

\=item Test-STDmaker-0.08

 Subject: FAIL Test-Tech-0.18 i586-linux 2.4.22-4tr 
 From: cpansmoke@alternation.net 
 Date: Thu,  8 Apr 2004 15:09:35 -0300 (ADT) 

 PERL_DL_NONLAZY=1 /usr/bin/perl5.8.0 "-MExtUtils::Command::MM" "-e" "test_harness(0, 'blib/lib', 'blib/arch')" t/Test/Tech/Tech.t
 t/Test/Tech/Tech....Can't locate FindBIN.pm

 Summary of my perl5 (revision 5.0 version 8 subversion 0) configuration:
   Platform:
     osname=linux, osvers=2.4.22-4tr, archname=i586-linux

This is a capitalization problem. The program module name is 'FindBin' not 'FindBIN' which
is part of Perl. Microsoft does not care about capitalization differences while linux
does. This error is in the test script automatically generated by C<Test::STDmaker>
and was just introduced when moved test script libraries from C<tlib> to the directory
of the test script. Repaired C<Test::STDmaker> and regenerated the distribution.

\=item Test-STDmaker-0.09

Added the generated xxxx.d demo script prints out the test name as a comment.

Added the C<report> option that automatically runs all tests scripts and
replaces the UUT program module C<=headx Test Report> section with the
output.

The test software uses the lastest version of C<Test::Tech>. This impacted
the expected values of the old tests slightly. Made the adjustments.

\=item Test-STDmaker-0.10

Added the C<&Test::Tech::is_skip> subroutine.

Added a left edge space column to the =\headx test report automatically
generated section  so that POD formats it as code.

Changed the look of the C<demo> subroutine output to better resemble Perl code. 
Print the code straight forward without leading '=>'. Put a Perl comment '# ' in front of
each result line instead of printing it straing forward.

Added the C<QC:> that is same for the C<C:> field except for the demo script.
The demo script silently executes a C<QC:>, quiet code, data.

Recoded so that none of the modules uses C<File::Data> program module.

\=item Test-STDmaker-0.11

CPAN is picking up the templates as PODs. Escape out the template POD commands
with a '\'.

Under certain test conditions, the Software Test Description (STD)
program module (PM) cannot be found.

From: "Thurn, Martin" <martin.thurn@ngc.com> 
Subject: FAIL Test-STDmaker-0.10 sun4-solaris 2.8 

Can't locate t/Test/STDmaker/tgA1.pm in @INC 
(@INC contains: . /disk1/src/PERL/.cpanplus/5.9.1/5.9.1/build/Test-STDmaker-0.10/t/Test

Added code that will add the appropriate directory to @INC for these test conditions.

For regression tests, the POD describes the relationship between the 'lib' and the 't'
directories so that the C<Test::STDmaker> package can find the STD PM.

\=item Test-STDmaker-0.12

Problems with CPAN picking up wrong NAME for C<Test::STDmaker::Verify> and 
C<Test::STD::PerlSTD>. Fixed

Use lastest C<Data::Secs2> that does not use C<Data::SecsPack> unless needed.
Some of the sites having trouble loading C<Data::SecsPack> GMP libraray.

Changed C<Test::STDmaker::Demo> and C<Test::STDmaker::Check> so they load
C<Test::Tech> after setting up C<@INC>. Else missing finding some
test library modules because they are not in the C<INC> path.

\=item Test-STDmaker-0.13

Test Failure:

 Subject: FAIL Test-STDmaker-0.12 ppc-linux 2.4.19-4a 
 From: alian@cpan.org (CPAN Tester + CPAN++ automate) 

Perl lib version (v5.8.4) doesn't match executable version (v5.6.0) at 
/usr/local/perl-5.8.4/lib/5.8.4/ppc-linux/Config.pm line 32.
Compilation failed in require at /usr/local/perl-5.8.4/lib/5.8.4/FindBin.pm line 97.
BEGIN failed--compilation aborted at /usr/local/perl-5.8.4/lib/5.8.4/FindBin.pm line 97.
Compilation failed in require at temp.pl line 8.

Analysis:

Line 8 is a backtick `perl $command`. To get to line 8 everything must
going well. Thus, suspect that the test harness perl executable is 
different than the command line perl executable. 

Corrective Action

Introduced the C<perl_command> subroutine that uses C<$^^X> to return the current executable Perl.
Use the results of this subroutine instead of 'perl' in backticks.
See how it goes.

\=item Test-STDmaker-0.14

Test Failure:

Subject: FAIL Test-STDmaker-0.13 ppc-linux 2.4.19-4a 
From: alian@cpan.org (CPAN Tester + CPAN++ automate) 

PERL_DL_NONLAZY=1 /usr/local/perl-5.8.4/bin/perl "-MExtUtils::Command::MM" "-e" "test_harness(0, 'blib/lib', 'blib/arch')" t/Test/STDmaker/STDmaker.t
t/Test/STDmaker/STDmaker....Perl lib version (v5.8.4) doesn't match executable version (v5.6.0) at /usr/local/perl-5.8.4/lib/5.8.4/ppc-linux/Config.pm line 32.
Compilation failed in require at /usr/local/perl-5.8.4/lib/5.8.4/FindBin.pm line 97.
BEGIN failed--compilation aborted at /usr/local/perl-5.8.4/lib/5.8.4/FindBin.pm line 97.
Compilation failed in require at tgB1.t line 43.

Corrective Action:

Opps. Have C<`perl $commands`> not only in the Unit Under Test (UUT) but also the test
scripts. Looks like using `C<$^^X> $command` fixed the UUT so change the ones in the
test script also.

\=item Test-STDmaker-0.15

Test Failure:

 Subject: FAIL Test-STDmaker-0.14 sparc-linux 2.4.21-pre7 
 From: alian@cpan.org (alian) 

 t/Test/STDmaker/STDmaker....Can't locate object method "t edit anything before __DATA_. Edit 
 ...

Analysis:

The text begin picked up in method comes from C<Test::STDmaker::STD.pm> 

 # Don't edit anything before __DATA_. Edit instead
 
within a <<'EOF' here statement.

Corrective Action:

Change the "Don't" to "Do not"

\=item Test-STDmaker-0.16

Test Failure:

 Subject: FAIL Test-STDmaker-0.15 ppc-linux 2.4.19-4a 
 From: alian@cpan.org (CPAN Tester + CPAN++ automate) 

t/Test/STDmaker/STDmaker....Missing right curly or square bracket at temp.pl line 331, at end of line
syntax error at temp.pl line 331, at EOF

Analysis:

The generated Perl has semicolon after a right curly bracket, "};". Some Perl get upset and do not
count the right curly bracket. 

Corrective Action:

Changed the C<Test::STDmaker::Clean>, C<Test::STDmaker::Demo> and
C<Test::STDMaker::Verify> that automatically adds a semicolon to a C<C> test description if one
does not exist, also not to add the semicolon if a right or left curly bracket exists at the
end of the C<C> test description field. Add the option, C<nosemi>, to disable the automatic
addition of a semicolon to the end of C <C> test description field.

\=item Test-STDmaker-0.17

Test Failure:

Same of Test-STDmaker-0.16

Analysis:

Opps. Did not change manual "};" to "}"

Corrections:

Change all "};" in all test case test scripts. Still do not know if this
will cure the deficiency so added diagnostic steps that will provided
added feedback.

\=item Test-STDmaker-0.18

Test Failure:

Same as Test-STDmaker-0.17. No output from added diagnostic messages.

Debug Mode:

Backed out test descriptions that producde curly brackets except for C<BEGIN> and C<END>
blocks of generated scripts. Added a warn($diag) to see if get diagnostic messages.
The backed test descriptions can be added as another test once get some green PASSES.

\=back

^

PROBLEMS: 
Establish all the requirements.
^

DOCUMENT_OVERVIEW:
This document releases ${NAME} version ${VERSION}
providing description of the inventory, installation
instructions and other information necessary to
utilize and track this release.
^

LICENSE:

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

\=item 3

Commercial installation of the binary or source
must visually present to the installer 
the above copyright notice,
this list of conditions intact,
that the original source is available
at http://softwarediamonds.com
and provide means
for the installer to actively accept
the list of conditions; 
otherwise, a license fee must be paid to
Softwareware Diamonds.


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


INSTALLATION:
To installed the release package, use the CPAN module
pr PPM module in the Perl release
or the INSTALL.PL script at the following web site:

 http://packages.SoftwareDiamonds.com

Follow the instructions for the the chosen installation software.

If all else fails, the file may be manually installed.
Enter one of the following repositories in a web browser:

${REPOSITORY}

Right click on '${DIST_FILE}' and download to a temporary
installation directory.
Enter the following where $make is 'nmake' for microsoft
windows; otherwise 'make'.

 gunzip ${BASE_DIST_FILE}.tar.${COMPRESS_SUFFIX}
 tar -xf ${BASE_DIST_FILE}.tar
 perl Makefile.PL
 $make test
 $make install

On Microsoft operating system, nmake, tar, and gunzip 
must be in the exeuction path. If tar and gunzip are
not install, download and install unxutils from

 http://packages.softwarediamonds.com

VERY IMPORTANT:

The distribution package contains the cover
C<bin/tmake.pl> perl command script.
Manually copy this into the execution path
in order to use C<STDmaker> from the
command line. Rename it if there is a
name conflict or just do not like the name.

^

SUPPORT:
603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>
^

NOTES:
The following are useful acronyms:


\=over 4

\=item .d

extension for a Perl demo script file

\=item .pm

extension for a Perl Library Module

\=item .t

extension for a Perl test script file

\=item DID

Data Item Description

\=item POD

Plain Old Documentation

\=item STD

Software Test Description

\=item SVD

Software Version Description

\=back
^


SEE_ALSO:

\=over 4

\=item L<Test::STDmaker|Test::STDmaker>

\=item L<Tie::Form|Tie::Form>

\=item L<Test::Tech|Test::Tech>

\=item L<Test|Test>

\=item L<Data::Secs2|Data::Secs2>

\=item L<Data::Str2Num|Data::Str2Num>

\=item L<Test::STDmaker::Check|Test::STDmaker::Check>

\=item L<Test::STDmaker::Demo|Test::STDmaker::Demo>

\=item L<Test::STDmaker::STD|Test::STDmaker::STD>

\=item L<Test::STDmaker::Verify|Test::STDmaker::Verify>

\=item L<Test::STD::PerlSTD|Test::STD::PerlSTD>

\=item L<US DOD Software Development Standard|Docs::US_DOD::STD2167A>

\=item L<US DOD Specification Practices|Docs::US_DOD::STD490A>

\=item L<Software Test Description (STD) DID|Docs::US_DOD::STD>

\=back

^

HTML:
<hr>
<p><br>
<!-- BLK ID="PROJECT_MANAGEMENT" -->
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
























































