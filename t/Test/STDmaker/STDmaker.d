#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.04';   # automatically generated file
$DATE = '2003/06/21';


##### Demonstration Script ####
#
# Name: STDmaker.d
#
# UUT: Test::STDmaker
#
# The module Test::STDmaker generated this demo script from the contents of
#
# t::Test::STDmaker::STDmaker 
#
# Don't edit this test script file, edit instead
#
# t::Test::STDmaker::STDmaker
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time Test::STDmaker generates this script file.
#
#

######
#
# The working directory is the directory of the generated file
#
use vars qw($__restore_dir__);

BEGIN {
    use Cwd;
    use File::Spec;
    use Test::Tech qw(tech_config plan demo);

    ########
    # Working directory is that of the script file
    #
    $__restore_dir__ = cwd();
    my ($vol, $dirs, undef) = File::Spec->splitpath( $0 );
    chdir $vol if $vol;
    chdir $dirs if $dirs;
}

END {

    #########
    # Restore working directory back to when enter script
    #
    chdir $__restore_dir__;
}

print << 'MSG';

 ~~~~~~ Demonstration overview ~~~~~
 
Perl code begins with the prompt

 =>

The selected results from executing the Perl Code 
follow on the next lines. For example,

 => 2 + 2
 4

 ~~~~~~ The demonstration follows ~~~~~

MSG

demo( "\ \ \ \ use\ vars\ qw\(\$loaded\)\;\
\ \ \ \ use\ File\:\:Glob\ \'\:glob\'\;\
\ \ \ \ use\ File\:\:Copy\;\
\ \ \ \ use\ File\:\:FileUtil\;\
\ \ \ \ use\ Test\:\:STD\:\:Scrub\;\
\ \
\ \ \ \ \#\#\#\#\#\#\#\#\#\
\ \ \ \ \#\ For\ \"TEST\"\ 1\.24\ or\ greater\ that\ have\ separate\ std\ err\ output\,\
\ \ \ \ \#\ redirect\ the\ TESTERR\ to\ STDOUT\
\ \ \ \ \#\
\ \ \ \ my\ \$restore_testerr\ \=\ tech_config\(\ \'Test\.TESTERR\'\,\ \\\*STDOUT\ \)\;\ \ \ \
\
\ \ \ \ my\ \$internal_number\ \=\ tech_config\(\'Internal_Number\'\)\;\
\ \ \ \ my\ \$fu\ \=\ \'File\:\:FileUtil\'\;\
\ \ \ \ my\ \$s\ \=\ \'Test\:\:STD\:\:Scrub\'\;\
\ \ \ \ my\ \$tgB0_pm\ \=\ \(\$internal_number\ eq\ \'string\'\)\ \?\ \'tgB0s\.pm\'\ \:\ \'tgB0n\.pm\'\;\
\ \ \ \ my\ \$tgB2_pm\ \=\ \(\$internal_number\ eq\ \'string\'\)\ \?\ \'tgB2s\.pm\'\ \:\ \'tgB2n\.pm\'\;\
\ \ \ \ my\ \$tgB2_txt\ \=\ \(\$internal_number\ eq\ \'string\'\)\ \?\ \'tgB2s\.txt\'\ \:\ \'tgB2n\.txt\'\;\
\
\ \ \ \ my\ \$test_results\;\
\ \ \ \ my\ \$loaded\ \=\ 0\;\
\ \ \ \ my\ \@outputs\;"); # typed in command           
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
    my @outputs;; # execution

demo( "my\ \$errors\ \=\ \$fu\-\>load_package\(\ \'Test\:\:STDmaker\'\ \)"); # typed in command           
      my $errors = $fu->load_package( 'Test::STDmaker' ); # execution

demo( "\$errors", # typed in command           
      $errors # execution
) unless     $loaded; # condition for execution                            

demo( "\$fu\-\>fin\(\'tgA0\.pm\'\)", # typed in command           
      $fu->fin('tgA0.pm')); # execution


demo( "\ \ \ \ copy\ \'tgA0\.pm\'\,\ \'tgA1\.pm\'\;\
\ \ \ \ Test\:\:STDmaker\-\>fgenerate\(\'t\:\:Test\:\:STDmaker\:\:tgA1\'\,\ \{output\=\>\'STD\'\}\)\;"); # typed in command           
          copy 'tgA0.pm', 'tgA1.pm';
    Test::STDmaker->fgenerate('t::Test::STDmaker::tgA1', {output=>'STD'});; # execution

demo( "\$s\-\>scrub_date_version\(\$fu\-\>fin\(\'tgA1\.pm\'\)\)", # typed in command           
      $s->scrub_date_version($fu->fin('tgA1.pm'))); # execution


demo( "\$fu\-\>fin\(\'tgB0n\.pm\'\)", # typed in command           
      $fu->fin('tgB0n.pm')); # execution


demo( "\ \ \ \ copy\ \$tgB0_pm\,\ \'tgB1\.pm\'\;\
\ \ \ \ Test\:\:STDmaker\-\>fgenerate\(\'t\:\:Test\:\:STDmaker\:\:tgB1\'\,\ \{output\=\>\'STD\ verify\'\}\)\;"); # typed in command           
          copy $tgB0_pm, 'tgB1.pm';
    Test::STDmaker->fgenerate('t::Test::STDmaker::tgB1', {output=>'STD verify'});; # execution

demo( "\$s\-\>scrub_date_version\(\$fu\-\>fin\(\'tgB1\.pm\'\)\)", # typed in command           
      $s->scrub_date_version($fu->fin('tgB1.pm'))); # execution


demo( "\ \ \ \ \$test_results\ \=\ \`perl\ tgB1\.t\`\;\
\ \ \ \ \$fu\-\>fout\(\'tgB1\.txt\'\,\ \$test_results\)\;"); # typed in command           
          $test_results = `perl tgB1.t`;
    $fu->fout('tgB1.txt', $test_results);; # execution

demo( "\$s\-\>scrub_probe\(\$s\-\>scrub_file_line\(\$test_results\)\)", # typed in command           
      $s->scrub_probe($s->scrub_file_line($test_results))); # execution


demo( "\$fu\-\>fin\(\ \'tg0\.pm\'\ \ \)", # typed in command           
      $fu->fin( 'tg0.pm'  )); # execution


demo( "\ \ \ \ \#\#\#\#\#\#\#\#\#\
\ \ \ \ \#\
\ \ \ \ \#\ Individual\ generate\ outputs\ using\ options\
\ \ \ \ \#\
\ \ \ \ \#\#\#\#\#\#\#\#\
\ \ \ \ \#\#\#\#\#\
\ \ \ \ \#\ Make\ sure\ there\ is\ no\ residue\ outputs\ hanging\
\ \ \ \ \#\ around\ from\ the\ last\ test\ series\.\
\ \ \ \ \#\
\ \ \ \ \@outputs\ \=\ bsd_glob\(\ \'tg\*1\.\*\'\ \)\;\
\ \ \ \ unlink\ \@outputs\;\
\ \ \ \ copy\ \'tg0\.pm\'\,\ \'tg1\.pm\'\;\
\ \ \ \ copy\ \'tgA0\.pm\'\,\ \'tgA1\.pm\'\;\
\ \ \ \ my\ \@cwd\ \=\ File\:\:Spec\-\>splitdir\(\ cwd\(\)\ \)\;\
\ \ \ \ pop\ \@cwd\;\
\ \ \ \ pop\ \@cwd\;\
\ \ \ \ unshift\ \@INC\,\ File\:\:Spec\-\>catdir\(\ \@cwd\ \)\;\ \ \#\ put\ UUT\ in\ lib\ path\
\ \ \ \ Test\:\:STDmaker\-\>fgenerate\(\'t\:\:Test\:\:STDmaker\:\:tgA1\'\,\ \{\ output\=\>\'demo\'\,\ replace\ \=\>\ 1\}\)\;\
\ \ \ \ shift\ \@INC\;"); # typed in command           
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
    Test::STDmaker->fgenerate('t::Test::STDmaker::tgA1', { output=>'demo', replace => 1});
    shift @INC;; # execution

demo( "\$s\-\>scrub_date_version\(\$fu\-\>fin\(\'tg1\.pm\'\)\)", # typed in command           
      $s->scrub_date_version($fu->fin('tg1.pm'))); # execution


demo( "\ \ \ \ no\ warnings\;\
\ \ \ \ open\ SAVEOUT\,\ \"\>\&STDOUT\"\;\
\ \ \ \ use\ warnings\;\
\ \ \ \ open\ STDOUT\,\ \"\>tgA1\.txt\"\;\
\ \ \ \ Test\:\:STDmaker\-\>fgenerate\(\'t\:\:Test\:\:STDmaker\:\:tgA1\'\,\ \{\ output\=\>\'verify\'\,\ run\=\>1\,\ verbose\=\>1\}\)\;\
\ \ \ \ close\ STDOUT\;\
\ \ \ \ open\ STDOUT\,\ \"\>\&SAVEOUT\"\;\
\ \ \ \ \
\ \ \ \ \#\#\#\#\#\#\
\ \ \ \ \#\ For\ some\ reason\,\ test\ harness\ puts\ in\ a\ extra\ line\ when\ running\ u\
\ \ \ \ \#\ under\ the\ Active\ debugger\ on\ Win32\.\ So\ just\ take\ it\ out\.\
\ \ \ \ \#\ Also\ the\ script\ name\ is\ absolute\ which\ is\ site\ dependent\.\
\ \ \ \ \#\ Take\ it\ out\ of\ the\ comparision\.\
\ \ \ \ \#\
\ \ \ \ \$test_results\ \=\ \$fu\-\>fin\(\'tgA1\.txt\'\)\;\
\ \ \ \ \$test_results\ \=\~\ s\/\.\*\?1\.\.9\/1\.\.9\/\;\ \
\ \ \ \ \$test_results\ \=\~\ s\/\-\-\-\-\-\-\.\*\?\\n\(\\s\*\\\(\)\/\\n\ \$1\/s\;\
\ \ \ \ \$fu\-\>fout\(\'tgA1\.txt\'\,\$test_results\)\;"); # typed in command           
          no warnings;
    open SAVEOUT, ">&STDOUT";
    use warnings;
    open STDOUT, ">tgA1.txt";
    Test::STDmaker->fgenerate('t::Test::STDmaker::tgA1', { output=>'verify', run=>1, verbose=>1});
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
    $fu->fout('tgA1.txt',$test_results);; # execution

demo( "\$s\-\>scrub_probe\(\$s\-\>scrub_test_file\(\$s\-\>scrub_file_line\(\$test_results\)\)\)", # typed in command           
      $s->scrub_probe($s->scrub_test_file($s->scrub_file_line($test_results)))); # execution


demo( "\$fu\-\>fin\(\'tgC0\.pm\'\)", # typed in command           
      $fu->fin('tgC0.pm')); # execution


demo( "\ \ \ \ copy\ \'tgC0\.pm\'\,\ \'tgC1\.pm\'\;\
\ \ \ \ Test\:\:STDmaker\-\>fgenerate\(\'t\:\:Test\:\:STDmaker\:\:tgC1\'\,\ \{fspec_out\=\>\'os2\'\,\ \ output\=\>\'STD\'\}\)\;"); # typed in command           
          copy 'tgC0.pm', 'tgC1.pm';
    Test::STDmaker->fgenerate('t::Test::STDmaker::tgC1', {fspec_out=>'os2',  output=>'STD'});; # execution

demo( "\$s\-\>scrub_date_version\(\$fu\-\>fin\(\'tgC1\.pm\'\)\)", # typed in command           
      $s->scrub_date_version($fu->fin('tgC1.pm'))); # execution


demo( "\ \ \ \ \#\#\#\#\#\
\ \ \ \ \#\ Make\ sure\ there\ is\ no\ residue\ outputs\ hanging\
\ \ \ \ \#\ around\ from\ the\ last\ test\ series\.\
\ \ \ \ \#\
\ \ \ \ \@outputs\ \=\ bsd_glob\(\ \'tg\*1\.\*\'\ \)\;\
\ \ \ \ unlink\ \@outputs\;\
\ \ \ \ tech_config\(\ \'Test\.TESTERR\'\,\ \$restore_testerr\)\;\ \ \ \
\
\
\ \ \ \ sub\ __warn__\ \
\ \ \ \ \{\ \
\ \ \ \ \ \ \ my\ \(\$text\)\ \=\ \@_\;\
\ \ \ \ \ \ \ return\ \$text\ \=\~\ \/STDOUT\/\;\
\ \ \ \ \ \ \ CORE\:\:warn\(\ \$text\ \)\;\
\ \ \ \ \}\;"); # typed in command           
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
    };; # execution


=head1 NAME

STDmaker.d - demostration script for Test::STDmaker

=head1 SYNOPSIS

 STDmaker.d

=head1 OPTIONS

None.

=head1 COPYRIGHT

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

## end of test script file ##

=cut

