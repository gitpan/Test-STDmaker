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
$VERSION = '0.05';
$DATE = '2003/07/05';
$FILE = __FILE__;

use vars qw(%INVENTORY);
%INVENTORY = (
    'lib/Docs/Site_SVD/Test_STDmaker.pm' => [qw(0.05 2003/07/05), 'revised 0.04'],
    'MANIFEST' => [qw(0.05 2003/07/05), 'generated, replaces 0.04'],
    'Makefile.PL' => [qw(0.05 2003/07/05), 'generated, replaces 0.04'],
    'README' => [qw(0.05 2003/07/05), 'generated, replaces 0.04'],
    'lib/Test/STDmaker.pm' => [qw(1.08 2003/07/05), 'revised 1.07'],
    'lib/Test/STDType/Demo.pm' => [qw(1.06 2003/07/05), 'unchanged'],
    'lib/Test/STDType/STD.pm' => [qw(1.07 2003/07/05), 'revised 1.06'],
    'lib/Test/STDType/Verify.pm' => [qw(1.06 2003/07/04), 'unchanged'],
    'lib/Test/STD/Check.pm' => [qw(1.06 2003/07/04), 'unchanged'],
    'lib/Test/STD/FileGen.pm' => [qw(1.06 2003/07/05), 'unchanged'],
    'lib/Test/STD/STD2167.pm' => [qw(1.04 2003/07/05), 'unchanged'],
    'lib/Test/STD/STDgen.pm' => [qw(1.04 2003/07/05), 'revised 1.03'],
    't/Test/STDmaker/FileGenI.pm' => [qw(1.02 2003/06/14), 'unchanged'],
    't/Test/STDmaker/STDmaker.d' => [qw(0.01 2003/07/05), 'unchanged'],
    't/Test/STDmaker/STDmaker.pm' => [qw(0.05 2003/07/05), 'revised 0.04'],
    't/Test/STDmaker/STDmaker.t' => [qw(0.01 2003/07/05), 'unchanged'],
    't/Test/STDmaker/tg0.pm' => [qw(0.02 2003/06/14), 'unchanged'],
    't/Test/STDmaker/tg2.pm' => [qw(0.02 2003/06/21), 'unchanged'],
    't/Test/STDmaker/tgA0.pm' => [qw(0.02 2003/06/21), 'unchanged'],
    't/Test/STDmaker/tgA1.pm' => [qw(0.02 2003/06/21), 'unchanged'],
    't/Test/STDmaker/tgA2.pm' => [qw(0.02 2003/06/21), 'unchanged'],
    't/Test/STDmaker/tgA2A.txt' => [qw(0.03 2003/06/21), 'unchanged'],
    't/Test/STDmaker/tgA2B.txt' => [qw(0.04 2003/07/04), 'unchanged'],
    't/Test/STDmaker/tgA2C.txt' => [qw(0.05 2003/07/04), 'unchanged'],
    't/Test/STDmaker/tgA2D.txt' => [qw(0.02 2003/06/05), 'unchanged'],
    't/Test/STDmaker/tgB0n.pm' => [qw(0.01 2003/06/21), 'unchanged'],
    't/Test/STDmaker/tgB0s.pm' => [qw(0.01 2003/06/21), 'unchanged'],
    't/Test/STDmaker/tgB1.pm' => [qw(0.01 2003/06/07), 'unchanged'],
    't/Test/STDmaker/tgB2n.pm' => [qw(0.01 2003/06/21), 'unchanged'],
    't/Test/STDmaker/tgB2n.txt' => [qw(0.02 2003/06/21), 'unchanged'],
    't/Test/STDmaker/tgB2s.pm' => [qw(0.01 2003/06/21), 'unchanged'],
    't/Test/STDmaker/tgB2s.txt' => [qw(0.02 2003/06/21), 'unchanged'],
    't/Test/STDmaker/tgC0.pm' => [qw(0.02 2003/06/21), 'unchanged'],
    't/Test/STDmaker/tgC1.pm' => [qw(0.01 2003/06/07), 'unchanged'],
    't/Test/STDmaker/tgC2.pm' => [qw(0.02 2003/06/21), 'unchanged'],
    'bin/tmake.pl' => [qw(1.04 2003/07/05), 'unchanged'],

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



=head1 Title Page

 Software Version Description

 for

 Test::STDmaker - Test Scripts, Demo Scripts and Software Test Description (STD) Automation

 Revision: D

 Version: 0.05

 Date: 2003/07/05

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

The STD program modules should reside in a 't' subtree whose root
is the same as the 'lib' subtree.

For example,
 
 root_dir   
   lib
     MyTopLevel
       MyUnitUnderTest.pm  # code module
   t
     MyTopLevel
       MyUnitUnderTest.pm  # std module

When "Test::STDmaker" searches for a STD program module,
it looks for it first under all the subtrees in @INC
with the last directory removed.
This means the package name must start with "t::".
Thus the program module name for the Unit Under
Test (UUT) and the UUT STD program module
are always different.

Use the "tg.pl" (test generate) cover script for 
L<Test::STDmaker|Test::STDmaker> to process a STD database
module as follows:

  tg t::MyTopLevel::MyUnitUnderTest
  perl -d root_dir/t/MyTopLevel/MyUnitUnderTest.t
  perl -d root_dir/t/MyTopLevel/MyUnitUnderTest.d

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

=item 5

Automate generation of test information required by
(L<STD2167A|Docs::US_DOD::STD2167A>) from the STD file
making it economical to provide this information 
for even commercial projects.
The ISO standards and certification are pushing
commercial projects more and more toward
using 2167 nomenclature and providing L<STD2167A|Docs::US_DOD::STD2167A> information.

=back

See the L<Test::STDmaker|Test::STDmaker> POD for
further detail on the text database fields and the processing.

The "L<Test::STDmaker|Test::STDmaker>" program module is a high level
use infterface (functional interface) program module in the US DOD STD2167A bundle.
The dependency of the program modules in the US DOD STD2167A bundle is as follows:
 
 File::Package File:SmartNL File::TestPath Text::Scrub

     Test::Tech

        DataPort::FileType::FormDB DataPort::DataFile DataPort::Maker 
        File::AnySpec File::Data File::PM2File File::SubPM Text::Replace 
        Text::Column

            Test::STDmaker ExtUtils::SVDmaker

=head2 1.3 Document overview.

This document releases Test::STDmaker version 0.05
providing description of the inventory, installation
instructions and other information necessary to
utilize and track this release.

=head1 3.0 VERSION DESCRIPTION

All file specifications in this SVD
use the Unix operating
system file specification.

=head2 3.1 Inventory of materials released.

This document releases the file found
at the following repository(s):

   http://www.softwarediamonds/packages/Test-STDmaker-0.05
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-STDmaker-0.05


Restrictions regarding duplication and license provisions
are as follows:

=over 4

=item Copyright.

copyright © 2003 Software Diamonds

=item Copyright holder contact.

 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>

=item License.

These files are a POD derived works from the hard copy public domain version
freely distributed by the United States Federal Government.

The original hardcopy version is always the authoritative document
and any conflict between the original hardcopy version governs whenever
there is any conflict. In more explicit terms, any conflict is a 
transcription error in converting the origninal hard-copy version to
this POD format. Software Diamonds assumes no responsible for such errors.

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

=back

=head2 3.2 Inventory of software contents

The content of the released, compressed, archieve file,
consists of the following files:

 file                                                         version date       comment
 ------------------------------------------------------------ ------- ---------- ------------------------
 lib/Docs/Site_SVD/Test_STDmaker.pm                           0.05    2003/07/05 revised 0.04
 MANIFEST                                                     0.05    2003/07/05 generated, replaces 0.04
 Makefile.PL                                                  0.05    2003/07/05 generated, replaces 0.04
 README                                                       0.05    2003/07/05 generated, replaces 0.04
 lib/Test/STDmaker.pm                                         1.08    2003/07/05 revised 1.07
 lib/Test/STDType/Demo.pm                                     1.06    2003/07/05 unchanged
 lib/Test/STDType/STD.pm                                      1.07    2003/07/05 revised 1.06
 lib/Test/STDType/Verify.pm                                   1.06    2003/07/04 unchanged
 lib/Test/STD/Check.pm                                        1.06    2003/07/04 unchanged
 lib/Test/STD/FileGen.pm                                      1.06    2003/07/05 unchanged
 lib/Test/STD/STD2167.pm                                      1.04    2003/07/05 unchanged
 lib/Test/STD/STDgen.pm                                       1.04    2003/07/05 revised 1.03
 t/Test/STDmaker/FileGenI.pm                                  1.02    2003/06/14 unchanged
 t/Test/STDmaker/STDmaker.d                                   0.01    2003/07/05 unchanged
 t/Test/STDmaker/STDmaker.pm                                  0.05    2003/07/05 revised 0.04
 t/Test/STDmaker/STDmaker.t                                   0.01    2003/07/05 unchanged
 t/Test/STDmaker/tg0.pm                                       0.02    2003/06/14 unchanged
 t/Test/STDmaker/tg2.pm                                       0.02    2003/06/21 unchanged
 t/Test/STDmaker/tgA0.pm                                      0.02    2003/06/21 unchanged
 t/Test/STDmaker/tgA1.pm                                      0.02    2003/06/21 unchanged
 t/Test/STDmaker/tgA2.pm                                      0.02    2003/06/21 unchanged
 t/Test/STDmaker/tgA2A.txt                                    0.03    2003/06/21 unchanged
 t/Test/STDmaker/tgA2B.txt                                    0.04    2003/07/04 unchanged
 t/Test/STDmaker/tgA2C.txt                                    0.05    2003/07/04 unchanged
 t/Test/STDmaker/tgA2D.txt                                    0.02    2003/06/05 unchanged
 t/Test/STDmaker/tgB0n.pm                                     0.01    2003/06/21 unchanged
 t/Test/STDmaker/tgB0s.pm                                     0.01    2003/06/21 unchanged
 t/Test/STDmaker/tgB1.pm                                      0.01    2003/06/07 unchanged
 t/Test/STDmaker/tgB2n.pm                                     0.01    2003/06/21 unchanged
 t/Test/STDmaker/tgB2n.txt                                    0.02    2003/06/21 unchanged
 t/Test/STDmaker/tgB2s.pm                                     0.01    2003/06/21 unchanged
 t/Test/STDmaker/tgB2s.txt                                    0.02    2003/06/21 unchanged
 t/Test/STDmaker/tgC0.pm                                      0.02    2003/06/21 unchanged
 t/Test/STDmaker/tgC1.pm                                      0.01    2003/06/07 unchanged
 t/Test/STDmaker/tgC2.pm                                      0.02    2003/06/21 unchanged
 bin/tmake.pl                                                 1.04    2003/07/05 unchanged


=head2 3.3 Changes

Changes are as follows:

=over 4

=item STD::STDgen 0.01

This is the original release. 
There are no previous releases to change.

=item STD::STDgen 0.02

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


=item Test::STDmaker 0.01

=over 4

=item *

Low level subroutines are broken out as separate distribution
modules: Test::TestUtil Test::Tech DataPort::FileType::FormDB DataPort::DataFile

=item *

The STD::STDgen was renamed Test::STDmaker to comply with CPAN
directives to use existing top levels whenever possible.

=back

=item Test::STDmaker 0.02

Replaced using Test::TestUtil with File::FileUtil, Test::STD::Scrub, Test::STD::STDutil

Added tests to deal with the fact that Data::Dumper produces different results
on different Perls

Added "Test" and "Data::Dumper" modules to the t directory so there are no
surprises because of Test versions.

Changed the generated test script to use subroutine interface of "Test::Tech"
The object interface was removed.

=item Test::STDmaker 0.03

Make the same additions to @INC for "Test::STDtype::Demo" and "Test::STD::Check" as for
"Test::STDtype::Verify".

Changed from using "File::FileUtil" (disappeared) to the File::* modules broken out from
"File::FileUtil"

=item Test::STDmaker 0.04

Changed from using "Test::STD::STDutil" (disappeared) to the File::* modules broken out from
"Test::STD::STDutil"

Added the -options_pm option and the ability to make multiple tests from a file list.

=item Test::STDmaker 0.05

Chnage name of Test::Table to Test::Column. Test::Table taken.

=back

=head2 3.4 Adaptation data.

This installation requires that the installation site
has the Perl programming language installed.
Installation sites running Microsoft Operating systems require
the installation of Unix utilities. 
An excellent, highly recommended Unix utilities for Microsoft
operating systems is unxutils by Karl M. Syring.
A copy is available at the following web sites:

 http://unxutils.sourceforge.net
 http://packages.SoftwareDiamnds.com

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

To installed the release file, use the CPAN module in the Perl release
or the INSTALL.PL script at the following web site:

 http://packages.SoftwareDiamonds.com

Follow the instructions for the the chosen installation software.

The distribution file is at the following respositories:

   http://www.softwarediamonds/packages/Test-STDmaker-0.05
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-STDmaker-0.05


=item Prerequistes.

 'DataPort::DataFile' => '0.02',
 'DataPort::FileType::FormDB' => '0.02',
 'DataPort::Maker' => '0',
 'Test::Tech' => '1.08',
 'Text::Scrub' => '0',
 'Text::Replace' => '0',
 'Text::Column' => '0',
 'File::AnySpec' => '0',
 'File::TestPath' => '0',
 'File::SubPM' => '0',
 'File::PM2File' => '0',
 'File::SmartNL' => '0',
 'File::Package' => '0',
 'File::Data' => '0',


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

The open issues are as follows:

=over 4

=item *

The STD2167 option, for a full singe STD, instead
of a detailed STD with a general STD, is commented out.

=item *

There is no requirement tracebility to a particular line
in a file containing the expected results

=item *

There is no provisions for Software Development Document (SDD)
design requirements and tracing functional requirements to
design requirements and to design requirements tests

=item *

Functional requirements are basically requirements important
to the end-user and stated for the point of view of the
end-user.  
Test coverage is not an issue. 
However, when design requirements are added to the mix,
test coverage of the design requirements becomes important.
Test coverage means as a minimum, the tests causes
the execution of all paths in the software under test.

=back

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

Modules with end-user functional interfaces 
relating to US DOD 2167A automation are
as follows:

=over 4

=item L<Test::STDmaker|Test::STDmaker>

=item L<ExtUtils::SVDmaker|ExtUtils::SVDmaker>

=item L<DataPort::FileType::FormDB|DataPort::FileType::FormDB>

=item L<DataPort::DataFile|DataPort::DataFile>

=item L<Test::Tech|Test::Tech>

=item L<Test|Test>

=item L<Data::Dumper|Data::Dumper>

=item L<Test::STD::Scrub|Test::STD::Scrub>

=item L<Test::STD::STDutil|Test::STD::STDutil>

=item L<File::FileUtil|File::FileUtil>

=back

The design modules for L<Test::STDmaker|Test::STDmaker>
have no other conceivable use then to support the
L<Test::STDmaker|Test::STDmaker> functional interface. 
The  L<Test::STDmaker|Test::STDmaker>
design module are as follows:

=over 4

=item L<Test::STD::Check|Test::STD::Check>

=item L<Test::STD::FileGen|Test::STD::FileGen>

=item L<Test::STD::STD2167|Test::STD::STD2167>

=item L<Test::STD::STDgen|Test::STD::STDgen>

=item L<Test::STDtype::Demo|Test::STDtype::Demo>

=item L<Test::STDtype::STD|Test::STDtype::STD>

=item L<Test::STDtype::Verify|Test::STDtype::Verify>

=back


Some US DOD 2167A Software Development Standard, DIDs and
other related documents that complement the 
US DOD 2167A automation are as follows:

=over 4

=item L<US DOD Software Development Standard|Docs::US_DOD::STD2167A>

=item L<US DOD Specification Practices|Docs::US_DOD::STD490A>

=item L<Computer Operation Manual (COM) DID|Docs::US_DOD::COM>

=item L<Computer Programming Manual (CPM) DID)|Docs::US_DOD::CPM>

=item L<Computer Resources Integrated Support Document (CRISD) DID|Docs::US_DOD::CRISD>

=item L<Computer System Operator's Manual (CSOM) DID|Docs::US_DOD::CSOM>

=item L<Database Design Description (DBDD) DID|Docs::US_DOD::DBDD>

=item L<Engineering Change Proposal (ECP) DID|Docs::US_DOD::ECP>

=item L<Firmware support Manual (FSM) DID|Docs::US_DOD::FSM>

=item L<Interface Design Document (IDD) DID|Docs::US_DOD::IDD>

=item L<Interface Requirements Specification (IRS) DID|Docs::US_DOD::IRS>

=item L<Operation Concept Description (OCD) DID|Docs::US_DOD::OCD>

=item L<Specification Change Notice (SCN) DID|Docs::US_DOD::SCN>

=item L<Software Design Specification (SDD) DID|Docs::US_DOD::SDD>

=item L<Software Development Plan (SDP) DID|Docs::US_DOD::SDP> 

=item L<Software Input and Output Manual (SIOM) DID|Docs::US_DOD::SIOM>

=item L<Software Installation Plan (SIP) DID|Docs::US_DOD::SIP>

=item L<Software Programmer's Manual (SPM) DID|Docs::US_DOD::SPM>

=item L<Software Product Specification (SPS) DID|Docs::US_DOD::SPS>

=item L<Software Requirements Specification (SRS) DID|Docs::US_DOD::SRS>

=item L<System or Segment Design Document (SSDD) DID|Docs::US_DOD::SSDD>

=item L<System or Subsystem Specification (SSS) DID|Docs::US_DOD::SSS>

=item L<Software Test Description (STD) DID|Docs::US_DOD::STD>

=item L<Software Test Plan (STP) DID|Docs::US_DOD::STP>

=item L<Software Test Report (STR) DID|Docs::US_DOD::STR>

=item L<Software Transition Plan (STrP) DID|Docs::US_DOD::STrP>

=item L<Software User Manual (SUM) DID|Docs::US_DOD::SUM>

=item L<Software Version Description (SVD) DID|Docs::US_DOD::SVD>

=item L<Version Description Document (VDD) DID|Docs::US_DOD::VDD>

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

VERSION : 0.05^
FREEZE: 1^
PREVIOUS_RELEASE: 0.04^
REVISION: D^

PREVIOUS_DISTNAME:  ^
AUTHOR  : SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>^

ABSTRACT: 
Generates Software Test Description (STD) documents, test scripts and 
demo scripts from a text FormDB database file.
^

TITLE   : Test::STDmaker - Test Scripts, Demo Scripts and Software Test Description (STD) Automation^
END_USER: General Public^
COPYRIGHT: copyright © 2003 Software Diamonds^
CLASSIFICATION: NONE^
TEMPLATE:  ^
CSS: help.css^
SVD_FSPEC: Unix^ 

REPOSITORY: 
  http://www.softwarediamonds/packages/
  http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/
^


COMPRESS: gzip^
COMPRESS_SUFFIX: gz^

RESTRUCTURE:  ^
CHANGE2CURRENT :  ^

AUTO_REVISE:
lib/Test/STDmaker.pm
lib/Test/STDType/*
lib/Test/STD/Check.pm
lib/Test/STD/FileGen.pm
lib/Test/STD/STD2167.pm
lib/Test/STD/STDgen.pm
t/Test/STDmaker/*
t/Test/STDmaker/lib/*
t/Test/STDmaker/lib/Data/*
bin/tmake.pl
^

PREREQ_PM:
'DataPort::DataFile' => '0.02',
'DataPort::FileType::FormDB' => '0.02',
'DataPort::Maker' => '0',
'Test::Tech' => '1.08',
'Text::Scrub' => '0',
'Text::Replace' => '0',
'Text::Column' => '0',
'File::AnySpec' => '0',
'File::TestPath' => '0',
'File::SubPM' => '0',
'File::PM2File' => '0',
'File::SmartNL' => '0',
'File::Package' => '0',
'File::Data' => '0',
^

TESTS: t/Test/STDmaker/STDmaker.t^

EXE_FILES: bin/tmake.pl^

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

The STD program modules should reside in a 't' subtree whose root
is the same as the 'lib' subtree.

For example,
 
 root_dir   
   lib
     MyTopLevel
       MyUnitUnderTest.pm  # code module
   t
     MyTopLevel
       MyUnitUnderTest.pm  # std module

When "Test::STDmaker" searches for a STD program module,
it looks for it first under all the subtrees in @INC
with the last directory removed.
This means the package name must start with "t::".
Thus the program module name for the Unit Under
Test (UUT) and the UUT STD program module
are always different.

Use the "tg.pl" (test generate) cover script for 
L<Test::STDmaker|Test::STDmaker> to process a STD database
module as follows:

  tg t::MyTopLevel::MyUnitUnderTest
  perl -d root_dir/t/MyTopLevel/MyUnitUnderTest.t
  perl -d root_dir/t/MyTopLevel/MyUnitUnderTest.d

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

\=item 5

Automate generation of test information required by
(L<STD2167A|Docs::US_DOD::STD2167A>) from the STD file
making it economical to provide this information 
for even commercial projects.
The ISO standards and certification are pushing
commercial projects more and more toward
using 2167 nomenclature and providing L<STD2167A|Docs::US_DOD::STD2167A> information.

\=back

See the L<Test::STDmaker|Test::STDmaker> POD for
further detail on the text database fields and the processing.

The "L<Test::STDmaker|Test::STDmaker>" program module is a high level
use infterface (functional interface) program module in the US DOD STD2167A bundle.
The dependency of the program modules in the US DOD STD2167A bundle is as follows:
 
 File::Package File:SmartNL File::TestPath Text::Scrub

     Test::Tech

        DataPort::FileType::FormDB DataPort::DataFile DataPort::Maker 
        File::AnySpec File::Data File::PM2File File::SubPM Text::Replace 
        Text::Column

            Test::STDmaker ExtUtils::SVDmaker

^

CHANGES:
Changes are as follows:

\=over 4

\=item STD::STDgen 0.01

This is the original release. 
There are no previous releases to change.

\=item STD::STDgen 0.02

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


\=item Test::STDmaker 0.01

\=over 4

\=item *

Low level subroutines are broken out as separate distribution
modules: Test::TestUtil Test::Tech DataPort::FileType::FormDB DataPort::DataFile

\=item *

The STD::STDgen was renamed Test::STDmaker to comply with CPAN
directives to use existing top levels whenever possible.

\=back

\=item Test::STDmaker 0.02

Replaced using Test::TestUtil with File::FileUtil, Test::STD::Scrub, Test::STD::STDutil

Added tests to deal with the fact that Data::Dumper produces different results
on different Perls

Added "Test" and "Data::Dumper" modules to the t directory so there are no
surprises because of Test versions.

Changed the generated test script to use subroutine interface of "Test::Tech"
The object interface was removed.

\=item Test::STDmaker 0.03

Make the same additions to @INC for "Test::STDtype::Demo" and "Test::STD::Check" as for
"Test::STDtype::Verify".

Changed from using "File::FileUtil" (disappeared) to the File::* modules broken out from
"File::FileUtil"

\=item Test::STDmaker 0.04

Changed from using "Test::STD::STDutil" (disappeared) to the File::* modules broken out from
"Test::STD::STDutil"

Added the -options_pm option and the ability to make multiple tests from a file list.

\=item Test::STDmaker 0.05

Chnage name of Test::Table to Test::Column. Test::Table taken.

\=back

^

PROBLEMS:
The open issues are as follows:

\=over 4

\=item *

The STD2167 option, for a full singe STD, instead
of a detailed STD with a general STD, is commented out.

\=item *

There is no requirement tracebility to a particular line
in a file containing the expected results

\=item *

There is no provisions for Software Development Document (SDD)
design requirements and tracing functional requirements to
design requirements and to design requirements tests

\=item *

Functional requirements are basically requirements important
to the end-user and stated for the point of view of the
end-user.  
Test coverage is not an issue. 
However, when design requirements are added to the mix,
test coverage of the design requirements becomes important.
Test coverage means as a minimum, the tests causes
the execution of all paths in the software under test.

\=back

^

DOCUMENT_OVERVIEW:
This document releases ${NAME} version ${VERSION}
providing description of the inventory, installation
instructions and other information necessary to
utilize and track this release.
^

LICENSE:
These files are a POD derived works from the hard copy public domain version
freely distributed by the United States Federal Government.

The original hardcopy version is always the authoritative document
and any conflict between the original hardcopy version governs whenever
there is any conflict. In more explicit terms, any conflict is a 
transcription error in converting the origninal hard-copy version to
this POD format. Software Diamonds assumes no responsible for such errors.

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


INSTALLATION:
To installed the release file, use the CPAN module in the Perl release
or the INSTALL.PL script at the following web site:

 http://packages.SoftwareDiamonds.com

Follow the instructions for the the chosen installation software.

The distribution file is at the following respositories:

${REPOSITORY}
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

Modules with end-user functional interfaces 
relating to US DOD 2167A automation are
as follows:

\=over 4

\=item L<Test::STDmaker|Test::STDmaker>

\=item L<ExtUtils::SVDmaker|ExtUtils::SVDmaker>

\=item L<DataPort::FileType::FormDB|DataPort::FileType::FormDB>

\=item L<DataPort::DataFile|DataPort::DataFile>

\=item L<Test::Tech|Test::Tech>

\=item L<Test|Test>

\=item L<Data::Dumper|Data::Dumper>

\=item L<Test::STD::Scrub|Test::STD::Scrub>

\=item L<Test::STD::STDutil|Test::STD::STDutil>

\=item L<File::FileUtil|File::FileUtil>

\=back

The design modules for L<Test::STDmaker|Test::STDmaker>
have no other conceivable use then to support the
L<Test::STDmaker|Test::STDmaker> functional interface. 
The  L<Test::STDmaker|Test::STDmaker>
design module are as follows:

\=over 4

\=item L<Test::STD::Check|Test::STD::Check>

\=item L<Test::STD::FileGen|Test::STD::FileGen>

\=item L<Test::STD::STD2167|Test::STD::STD2167>

\=item L<Test::STD::STDgen|Test::STD::STDgen>

\=item L<Test::STDtype::Demo|Test::STDtype::Demo>

\=item L<Test::STDtype::STD|Test::STDtype::STD>

\=item L<Test::STDtype::Verify|Test::STDtype::Verify>

\=back


Some US DOD 2167A Software Development Standard, DIDs and
other related documents that complement the 
US DOD 2167A automation are as follows:

\=over 4

\=item L<US DOD Software Development Standard|Docs::US_DOD::STD2167A>

\=item L<US DOD Specification Practices|Docs::US_DOD::STD490A>

\=item L<Computer Operation Manual (COM) DID|Docs::US_DOD::COM>

\=item L<Computer Programming Manual (CPM) DID)|Docs::US_DOD::CPM>

\=item L<Computer Resources Integrated Support Document (CRISD) DID|Docs::US_DOD::CRISD>

\=item L<Computer System Operator's Manual (CSOM) DID|Docs::US_DOD::CSOM>

\=item L<Database Design Description (DBDD) DID|Docs::US_DOD::DBDD>

\=item L<Engineering Change Proposal (ECP) DID|Docs::US_DOD::ECP>

\=item L<Firmware support Manual (FSM) DID|Docs::US_DOD::FSM>

\=item L<Interface Design Document (IDD) DID|Docs::US_DOD::IDD>

\=item L<Interface Requirements Specification (IRS) DID|Docs::US_DOD::IRS>

\=item L<Operation Concept Description (OCD) DID|Docs::US_DOD::OCD>

\=item L<Specification Change Notice (SCN) DID|Docs::US_DOD::SCN>

\=item L<Software Design Specification (SDD) DID|Docs::US_DOD::SDD>

\=item L<Software Development Plan (SDP) DID|Docs::US_DOD::SDP> 

\=item L<Software Input and Output Manual (SIOM) DID|Docs::US_DOD::SIOM>

\=item L<Software Installation Plan (SIP) DID|Docs::US_DOD::SIP>

\=item L<Software Programmer's Manual (SPM) DID|Docs::US_DOD::SPM>

\=item L<Software Product Specification (SPS) DID|Docs::US_DOD::SPS>

\=item L<Software Requirements Specification (SRS) DID|Docs::US_DOD::SRS>

\=item L<System or Segment Design Document (SSDD) DID|Docs::US_DOD::SSDD>

\=item L<System or Subsystem Specification (SSS) DID|Docs::US_DOD::SSS>

\=item L<Software Test Description (STD) DID|Docs::US_DOD::STD>

\=item L<Software Test Plan (STP) DID|Docs::US_DOD::STP>

\=item L<Software Test Report (STR) DID|Docs::US_DOD::STR>

\=item L<Software Transition Plan (STrP) DID|Docs::US_DOD::STrP>

\=item L<Software User Manual (SUM) DID|Docs::US_DOD::SUM>

\=item L<Software Version Description (SVD) DID|Docs::US_DOD::SVD>

\=item L<Version Description Document (VDD) DID|Docs::US_DOD::VDD>

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


