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
$VERSION = '0.01';
$DATE = '2003/06/14';
$FILE = __FILE__;

use vars qw(%INVENTORY);
%INVENTORY = (
    'lib/Docs/Site_SVD/Test_STDmaker.pm' => [qw(0.01 2003/06/14), 'revised 0.02'],
    'MANIFEST' => [qw(0.01 2003/06/14), 'generated, replaces 0.02'],
    'Makefile.PL' => [qw(0.01 2003/06/14), 'generated, replaces 0.02'],
    'README' => [qw(0.01 2003/06/14), 'generated, replaces 0.02'],
    'lib/Test/STDmaker.pm' => [qw(1.04 2003/06/14), 'revised 1.03'],
    'lib/Test/STDType/Demo.pm' => [qw(1.03 2003/06/14), 'revised 1.02'],
    'lib/Test/STDType/STD.pm' => [qw(1.03 2003/06/14), 'revised 1.02'],
    'lib/Test/STDType/Verify.pm' => [qw(1.04 2003/06/14), 'revised 1.03'],
    'lib/Test/STD/Check.pm' => [qw(1.04 2003/06/14), 'revised 1.03'],
    'lib/Test/STD/FileGen.pm' => [qw(1.03 2003/06/14), 'revised 1.02'],
    'lib/Test/STD/STD2167.pm' => [qw(1.03 2003/06/14), 'revised 1.02'],
    'lib/Test/STD/STDgen.pm' => [qw(1.02 2003/06/14), 'new'],
    't/Test/STDmaker/FileGenI.pm' => [qw(1.02 2003/06/14), 'new'],
    't/Test/STDmaker/STDmaker.d' => [qw(0.03 2003/06/14), 'revised 0.02'],
    't/Test/STDmaker/STDmaker.pm' => [qw(0.01 2003/06/14), 'new'],
    't/Test/STDmaker/STDmaker.t' => [qw(0.03 2003/06/14), 'revised 0.02'],
    't/Test/STDmaker/tg0.pm' => [qw(0.02 2003/06/14), 'revised 0.01'],
    't/Test/STDmaker/tg2.pm' => [qw(0.01 2003/06/14), 'new'],
    't/Test/STDmaker/tgA0.pm' => [qw(0.01 2003/06/14), 'new'],
    't/Test/STDmaker/tgA1.pm' => [qw(0.01 2003/06/14), 'new'],
    't/Test/STDmaker/tgA2.d' => [qw(0.01 2003/06/03), 'unchanged'],
    't/Test/STDmaker/tgA2.pm' => [qw(0.01 2003/06/14), 'new'],
    't/Test/STDmaker/tgA2A.txt' => [qw(0.02 2003/06/05), 'unchanged'],
    't/Test/STDmaker/tgA2B.txt' => [qw(0.02 2003/06/05), 'unchanged'],
    't/Test/STDmaker/tgA2C.txt' => [qw(0.03 2003/06/14), 'revised 0.02'],
    't/Test/STDmaker/tgA2D.txt' => [qw(0.02 2003/06/05), 'unchanged'],
    't/Test/STDmaker/tgB0.pm' => [qw(0.01 2003/06/14), 'new'],
    't/Test/STDmaker/tgB1.pm' => [qw(0.01 2003/06/14), 'new'],
    't/Test/STDmaker/tgB2.pm' => [qw(0.01 2003/06/14), 'new'],
    't/Test/STDmaker/tgC0.pm' => [qw(0.01 2003/06/14), 'new'],
    't/Test/STDmaker/tgC1.pm' => [qw(0.01 2003/06/14), 'new'],
    't/Test/STDmaker/tgC2.pm' => [qw(0.01 2003/06/14), 'new'],
    'bin/tg.pl' => [qw(1.03 2003/06/14), 'revised 1.02'],

);

########
# The SVD::SVDmaker module uses the data after the __DATA__ 
# token to automatically generate the this file.
#
# Don't edit anything before __DATA_. Edit instead
# the data after the __DATA__ token.
#
# ANY CHANGES MADE BEFORE the  __DATA__ token WILL BE LOST
#
# the next time SVD::SVDmaker generates this file.
#
#



=head1 Title Page

 Software Version Description

 for

 Software Test Scripts, Demo Scripts and Software Test Description (STD) Automation

 Revision: C

 Version: 0.01

 Date: 2003/06/14

 Prepared for: General Public 

 Prepared by:  SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>

 Copyright: copyright © 2003 Software Diamonds

 Classification: NONE

=head1 1.0 SCOPE

This paragraph identifies and provides an overview
of the released files.

=head2 1.1 Indentification

This release is a collection of Perl modules that
extend the capabilities of the Perl language.

=head2 1.2 System overview

The system is the Perl programming language software.
The system does not have any hardware.
The Perl programming language contains two features that
are utilized by this release:

=over 4

=item 1

Program Modules to extend the languages

=item 2

Plain Old Documentation (POD) that may be embedded in the language

=back

These features are established by the referenced documents.

The C<fgenerate> method provides the following capabilities:

=over 4

=item 1

Automate Perl related programming needed to create a
test script resulting in reduction of time and cost.

=item 2

Translate a short hand Software Test Description (STD)
file into a Perl test script that eventually makes use of 
the L<Test|Test> module.

=item 3

Translate the sort hand STD data file into a Perl test 
script that demonstrates the features of the 
the module under test.

=item 4

Provide in a the POD of a STD file information required by
a Military/Federal Government 
Software Test Description (L<STD|Docs::US_DOD::STD>) document
that may easily be index and accessed by
automated Test software. 

=item 5

Automate generation of test information required by
(L<STD2167A|Docs::US_DOD::STD2167A>) from the STD file
making it economical to provide this information 
for even commercial projects.
The ISO standards and certification are pushing
commercial projects more and more toward
using 2167 nomenclature and providing L<STD2167A|Docs::US_DOD::STD2167A> information.

=back

=head2 1.3 Document overview.

This document releases Test::STDmaker version 0.01
providing description of the inventory, installation
instructions and other information necessary to
utilize and track this release.

=head1 3.0 VERSION DESCRIPTION

All file specifications in this SVD
use the Unix operating
system file specification.

=head2 3.1 Inventory of materials released.

=head2 3.1.1 Files.

This document releases the file found
at the following repository:

   http://www.softwarediamonds/packages/Test-STDmaker-0.01
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-STDmaker-0.01


=head2 3.1.2 Copyright.

copyright © 2003 Software Diamonds

=head2 3.1.3 Copyright holder contact.

 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>

=head2 3.1.4 License.

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

=head2 3.2 Inventory of software contents

The content of the released, compressed, archieve file,
consists of the following files:

 file                                                         version date       comment
 ------------------------------------------------------------ ------- ---------- ------------------------
 lib/Docs/Site_SVD/Test_STDmaker.pm                           0.01    2003/06/14 revised 0.02
 MANIFEST                                                     0.01    2003/06/14 generated, replaces 0.02
 Makefile.PL                                                  0.01    2003/06/14 generated, replaces 0.02
 README                                                       0.01    2003/06/14 generated, replaces 0.02
 lib/Test/STDmaker.pm                                         1.04    2003/06/14 revised 1.03
 lib/Test/STDType/Demo.pm                                     1.03    2003/06/14 revised 1.02
 lib/Test/STDType/STD.pm                                      1.03    2003/06/14 revised 1.02
 lib/Test/STDType/Verify.pm                                   1.04    2003/06/14 revised 1.03
 lib/Test/STD/Check.pm                                        1.04    2003/06/14 revised 1.03
 lib/Test/STD/FileGen.pm                                      1.03    2003/06/14 revised 1.02
 lib/Test/STD/STD2167.pm                                      1.03    2003/06/14 revised 1.02
 lib/Test/STD/STDgen.pm                                       1.02    2003/06/14 new
 t/Test/STDmaker/FileGenI.pm                                  1.02    2003/06/14 new
 t/Test/STDmaker/STDmaker.d                                   0.03    2003/06/14 revised 0.02
 t/Test/STDmaker/STDmaker.pm                                  0.01    2003/06/14 new
 t/Test/STDmaker/STDmaker.t                                   0.03    2003/06/14 revised 0.02
 t/Test/STDmaker/tg0.pm                                       0.02    2003/06/14 revised 0.01
 t/Test/STDmaker/tg2.pm                                       0.01    2003/06/14 new
 t/Test/STDmaker/tgA0.pm                                      0.01    2003/06/14 new
 t/Test/STDmaker/tgA1.pm                                      0.01    2003/06/14 new
 t/Test/STDmaker/tgA2.d                                       0.01    2003/06/03 unchanged
 t/Test/STDmaker/tgA2.pm                                      0.01    2003/06/14 new
 t/Test/STDmaker/tgA2A.txt                                    0.02    2003/06/05 unchanged
 t/Test/STDmaker/tgA2B.txt                                    0.02    2003/06/05 unchanged
 t/Test/STDmaker/tgA2C.txt                                    0.03    2003/06/14 revised 0.02
 t/Test/STDmaker/tgA2D.txt                                    0.02    2003/06/05 unchanged
 t/Test/STDmaker/tgB0.pm                                      0.01    2003/06/14 new
 t/Test/STDmaker/tgB1.pm                                      0.01    2003/06/14 new
 t/Test/STDmaker/tgB2.pm                                      0.01    2003/06/14 new
 t/Test/STDmaker/tgC0.pm                                      0.01    2003/06/14 new
 t/Test/STDmaker/tgC1.pm                                      0.01    2003/06/14 new
 t/Test/STDmaker/tgC2.pm                                      0.01    2003/06/14 new
 bin/tg.pl                                                    1.03    2003/06/14 revised 1.02


=head2 3.3 Changes

Changes are as follows:

=over 4

=item *

Low level subroutines are broken out as separate distribution
modules: Test::TestUtil Test::Tech DataPort::FileType::FormDB DataPort::DataFile

=item *

The STD::STDgen was renamed Test::STDmaker to comply with CPAN
directives to use existing top levels

=back
This release resturctures the directory tree as follows:

The file structure from release 0.02 was
restructured as follows:

 rmtree 'lib\\Datacop';
  rmtree 'lib\\SVD';
 rmtree 'lib\\STD';
 rmtree 't\\DataCop';
 unlink 'lib\\Test\\STDtype\\Clean.pm';





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

To installed the release file, use the CPAN module in the Perl release
or the INSTALL.PL script at the following web site:

 http://packages.SoftwareDiamonds.com

Follow the instructions for the the chosen installation software.

The distribution file is at the following respositories:

   http://www.softwarediamonds/packages/Test-STDmaker-0.01
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-STDmaker-0.01


=head2 3.6.1 Installation support.

If there are installation problems or questions with the installation
contact

 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>

=head2 3.6.2 Installation Tests.

Most Perl installation software will run the following test script(s)
as part of the installation:

 t/Test/STDmaker/STDmaker.t

=head2 3.7 Possible problems and known errors

The open issues are as follows:

=over 4

=item *

The STD2167 option is commented out.

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

=item .svd

extension for a Software Vesion Description database file

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

L<Test|Test> 
L<Test::Harness|Test::Harness>
L<Test::STDmaker|Test::STDmaker> 
L<DataPort::FileType::FormDB|DataPort::FileType::FormDB>
L<Docs::US_DOD::STD2167A|Docs::US_DOD::STD2167A>
L<Docs::US_DOD::STD490A|Docs::US_DOD::STD490A>
L<Docs::US_DOD::STD|Docs::US_DOD::STD>

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
VERSION : 0.01^
REPOSITORY_DIR: packages^
FREEZE: 1^

PREVIOUS_DISTNAME: STD-STDgen^
PREVIOUS_RELEASE: 0.02^
AUTHOR  : SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>^
ABSTRACT: Generates Software Test Description (STD) documents, test scripts and demo sripts from a test database file.^
REVISION: C^
TITLE   : Software Test Scripts, Demo Scripts and Software Test Description (STD) Automation^
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

RESTRUCTURE:
 rmtree 'lib\\Datacop';
 rmtree 'lib\\SVD';
 rmtree 'lib\\STD';
 rmtree 't\\DataCop';
 unlink 'lib\\Test\\STDtype\\Clean.pm';
^

CHANGE2CURRENT :
return if $file =~ s|^^lib/STD/GenType|lib/Test/STDtype|;
return if $file =~ s|^^lib/STD/TestGen\.pm|lib/Test/STDmaker.pm|;
return if $file =~ s|^^lib/STD/Check\.pm|lib/Test/STD/Check.pm|;
return if $file =~ s|^^lib/STD/FileGen\.pm|lib/Test/STD/FileGen.pm|;
return if $file =~ s|^^lib/STD/FileGenI\.pm|lib/Test/STD/FileGenI.pm|;
return if $file =~ s|^^lib/STD/STDgen\.pm|lib/Test/STD/STD2167.pm|;

return if $file =~ s|^^t/STD/TestGen\.t|t/Test/STDmaker/STDmaker.t|;
return if $file =~ s|^^t/STD/TestGen\.d|t/Test/STDmaker/STDmaker.d|;
return if $file =~ s|^^t/STD/TestGen\.pm|t/Test/STDmaker/STDmaker.pm|;
return if $file =~ s|^^t/STD|t/Test/STDmaker|;
^

AUTO_REVISE:
lib/Test/STDmaker.pm
lib/Test/STDType/*
lib/Test/STD/*
t/Test/STDmaker/*
bin/tg.pl
^

PREREQ_PM:
'DataPort::DataFile' => 0,
'DataPort::FileType::FormDB' => 0,
'Test::TestUtil' => 0,
'Test::Tech' => 0,
^

TESTS:
t/Test/STDmaker/*.t
^

EXE_FILES: bin/tg.pl^

CAPABILITIES:
The C<fgenerate> method provides the following capabilities:

\=over 4

\=item 1

Automate Perl related programming needed to create a
test script resulting in reduction of time and cost.

\=item 2

Translate a short hand Software Test Description (STD)
file into a Perl test script that eventually makes use of 
the L<Test|Test> module.

\=item 3

Translate the sort hand STD data file into a Perl test 
script that demonstrates the features of the 
the module under test.

\=item 4

Provide in a the POD of a STD file information required by
a Military/Federal Government 
Software Test Description (L<STD|Docs::US_DOD::STD>) document
that may easily be index and accessed by
automated Test software. 

\=item 5

Automate generation of test information required by
(L<STD2167A|Docs::US_DOD::STD2167A>) from the STD file
making it economical to provide this information 
for even commercial projects.
The ISO standards and certification are pushing
commercial projects more and more toward
using 2167 nomenclature and providing L<STD2167A|Docs::US_DOD::STD2167A> information.

\=back

^

CHANGES:
Changes are as follows:

\=over 4

\=item *

Low level subroutines are broken out as separate distribution
modules: Test::TestUtil Test::Tech DataPort::FileType::FormDB DataPort::DataFile

\=item *

The STD::STDgen was renamed Test::STDmaker to comply with CPAN
directives to use existing top levels

\=back

^


PROBLEMS:
The open issues are as follows:

\=over 4

\=item *

The STD2167 option is commented out.

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

\=item .svd

extension for a Software Vesion Description database file

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

L<Test|Test> 
L<Test::Harness|Test::Harness>
L<Test::STDmaker|Test::STDmaker> 
L<DataPort::FileType::FormDB|DataPort::FileType::FormDB>
L<Docs::US_DOD::STD2167A|Docs::US_DOD::STD2167A>
L<Docs::US_DOD::STD490A|Docs::US_DOD::STD490A>
L<Docs::US_DOD::STD|Docs::US_DOD::STD>

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


