
####
# 
# The module ExtUtils::STDmaker generated this file from the contents of
#
# Docs::Site_SVD::Test_STDmaker 
#
# Don't edit this file, edit instead
#
# Docs::Site_SVD::Test_STDmaker
#
#	ANY CHANGES MADE HERE WILL BE LOST
#
#       the next time ExtUtils::STDmaker generates it.
#
#

use ExtUtils::MakeMaker;

my $tests = join ' ',unix2os('t/Test/STDmaker/STDmaker.t');
my @exe = unix2os('bin/tmake.pl');

WriteMakefile(
    NAME => 'Test::STDmaker',
    DISTNAME => 'Test-STDmaker',
    VERSION  => '0.08',
    dist     => {COMPRESS => 'gzip',
                'gz' => 'gz'},
    test     => {TESTS => $tests},
    PREREQ_PM => {'File::AnySpec' => '1.1',
                  'File::Data' => '1.1',
                  'File::Package' => '1.1',
                  'File::Where' => '0.02',
                  'File::SmartNL' => '1.1',
                  'File::SubPM' => '1.1',
                  'Text::Replace' => '1.08',
                  'Text::Column' => '1.08',
                  'DataPort::FileType::FormDB' => '0.03',
                  'DataPort::Maker' => '1.04',
                  'DataPort::DataFile' => '0.04',},
    EXE_FILES => \@exe,

    ($] >= 5.005 ?     
        (AUTHOR    => 'SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>',
        ABSTRACT  => 'Generates Software Test Description (STD) documents, test scripts and 
demo scripts from a text FormDB database file.', ) : ()),
);



use File::Spec;
use File::Spec::Unix;
sub unix2os
{
   my @file = ();
   foreach my $file (@_) {
       my (undef, $dir, $file_unix) = File::Spec::Unix->splitpath( $file );
       my @dir = File::Spec::Unix->splitdir( $dir );
       push @file, File::Spec->catfile( @dir, $file_unix);
   }
   @file;
}

