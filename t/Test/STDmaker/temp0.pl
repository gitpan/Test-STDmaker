#!perl
#
#
use Cwd;
use File::Spec;
use Test::Tech qw(plan ok skip skip_tests tech_config);

BEGIN { 

    use vars qw(%__tests__ $__test__ $__restore_dir__);
    use File::FileUtil

    $__test__ = 0;
    %__tests__ = ();

    ########
    # Working directory is that of the script file
    #
    $__restore_dir__ = cwd();
    my ($vol, $dirs, undef) = File::Spec->splitpath( $0 );
    chdir $vol if $vol;
    chdir $dirs if $dirs;

    #######
    # Add the library of the unit under test (UUT) to @INC
    #
    @__restore_inc__ = File::FileUtil->test_lib2inc();

    unshift @INC, File::Spec->catdir( cwd(), 'lib' ); 
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


    ######
    # ok 1
    #
    $__test__++; 
    $__tests__{ 1 } .= "$__test__,";    

   # Perl code from C:
my $errors = $fu->load_package( 'Test::STDmaker' );


    ######
    # ok 2
    #
    $__test__++; 
    $__tests__{ 2 } .= "$__test__,";    


    ######
    # ok 3
    #
    $__test__++; 
    $__tests__{ 3 } .= "$__test__,";    

   # Perl code from C:
copy 'tgA0.pm', 'tgA1.pm';
    my $tmaker = new Test::STDmaker(pm =>'t::Test::STDmaker::tgA1');
    $tmaker->tmake( 'STD' );


    ######
    # ok 4
    #
    $__test__++; 
    $__tests__{ 4 } .= "$__test__,";    

   # Perl code from C:
copy $tgB0_pm, 'tgB1.pm';
    $tmaker->tmake('STD', 'verify', {pm => 't::Test::STDmaker::tgB1'} );


    ######
    # ok 5
    #
    $__test__++; 
    $__tests__{ 5 } .= "$__test__,";    

   # Perl code from C:
$test_results = `perl tgB1.t`;
    $fu->fout('tgB1.txt', $test_results);


    ######
    # ok 6
    #
    $__test__++; 
    $__tests__{ 6 } .= "$__test__,";    

   # Perl code from C:
#####
    # Make sure there is no residue outputs hanging
    # around from the last test series.
    #
    @outputs = bsd_glob( 'tg*1.*' );
    unlink @outputs;
    copy 'tgA0.pm', 'tgA1.pm';
    $tmaker = new Test::STDmaker( {pm => 't::Test::STDmaker::tgA1'} );


    ######
    # ok 7
    #
    $__test__++; 
    $__tests__{ 7 } .= "$__test__,";    

   # Perl code from C:
$test_results = `perl tgA1.d`;
    $fu->fout('tgA1.txt', $test_results);


    ######
    # ok 8
    #
    $__test__++; 
    $__tests__{ 8 } .= "$__test__,";    

   # Perl code from C:
$test_results = `perl tgA1.t`;
    $fu->fout('tgA1.txt', $test_results);


    ######
    # ok 9
    #
    $__test__++; 
    $__tests__{ 9 } .= "$__test__,";    

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
    $tmaker->tmake('demo', { pm => 't::Test::STDmaker::tgA1', replace => 1});
    shift @INC;


    ######
    # ok 10
    #
    $__test__++; 
    $__tests__{ 10 } .= "$__test__,";    

   # Perl code from C:
no warnings;
    open SAVEOUT, ">&STDOUT";
    use warnings;
    open STDOUT, ">tgA1.txt";
    $tmaker->tmake('verify', { pm => 't::Test::STDmaker::tgA1', run => 1, verbose => 1});
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


    ######
    # ok 11
    #
    $__test__++; 
    $__tests__{ 11 } .= "$__test__,";    

   # Perl code from C:
no warnings;
    open SAVEOUT, ">&STDOUT";
    use warnings;
    open STDOUT, ">tgA1.txt";
    $main::SIG{__WARN__}=\&__warn__; # kill pesty Format STDOUT and Format STDOUT_TOP redefined
    $tmaker->tmake('verify', { pm => 't::Test::STDmaker::tgA1', run => 1});
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


    ######
    # ok 12
    #
    $__test__++; 
    $__tests__{ 12 } .= "$__test__,";    

   # Perl code from C:
copy 'tgC0.pm', 'tgC1.pm';
    $tmaker->tmake('STD', { pm => 't::Test::STDmaker::tgC1', fspec_out=>'os2'});


    ######
    # ok 13
    #
    $__test__++; 
    $__tests__{ 13 } .= "$__test__,";    

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


   print "tests\n$__test__\n";

   foreach $__test__ (keys %__tests__) {
      print "$__test__\n$__tests__{$__test__}\n";
   }

