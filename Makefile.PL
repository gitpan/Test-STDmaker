
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
my $exe;
if( $exe ) {
  $exe = [join ' ',unix2os($exe)];
}
else {
   $exe = [];
}

WriteMakefile(
    NAME => 'Test::STDmaker',
    DISTNAME => 'Test-STDmaker',
    VERSION  => '0.03',
    dist     => {COMPRESS => 'gzip',
                'gz' => 'gz'},
    test     => {TESTS => $tests},
    PREREQ_PM => {'DataPort::DataFile' => '0.02',
'DataPort::FileType::FormDB' => '0.02',
'DataPort::Maker' => '0',
'Test::STD::STDutil' => '1.07',
'Test::Tech' => '1.08',
'Test::STD::Scrub' => '1.07',
'Test::STD::STDutil' => '0',
'File::AnySpec' => '0',
'File::TestPath' => '0',
'File::SubPM' => '0',
'File::PM2File' => '0',
'File::SmartNL' => '0',
'File::Package' => '0',
'File::Data' => '0',},
    EXE_FILES => $exe,

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

