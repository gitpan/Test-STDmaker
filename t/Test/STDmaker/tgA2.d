#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.01';   # automatically generated file
$DATE = '2003/06/03';


##### Demonstration Script ####
#
# Name: tgA1.d
#
# UUT: tg1
#
# The module STD::TestGen generated this demo script from the contents of
#
# STD/t/tgA1.std 
#
# Don't edit this test script file, edit instead
#
# STD/t/tgA1.std
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time STD::TestGen generates this script file.
#
#

######
#
# The working directory is the directory of the generated file
#
use vars qw($__restore_dir__ $T);

BEGIN {
    use Cwd;
    use File::Spec;
    use STD::Tester;
    use Getopt::Long;

    ##########
    # Pick up a output redirection file and tests to skip
    # from the command line.
    #
    my $test_log = '';
    GetOptions('log=s' => \$test_log);
 
    ########
    # Start a demo with a new tester
    #
    $T = new STD::Tester( $test_log );

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

$T->demo(   
"use\ Test\:\:t\:\:TestGen1A"); # typed in command           
use Test::t::TestGen1A; # execution

$T->demo(   
"my\ \$x\ \=\ 2"); # typed in command           
my $x = 2; # execution

$T->demo(   
"my\ \$y\ \=\ 3"); # typed in command           
my $y = 3; # execution

$T->demo(   
"\$x\ \+\ \$y", # typed in command           
$x + $y); # execution


$T->demo(   
"\(\$x\+\$y\,\$y\-\$x\)", # typed in command           
($x+$y,$y-$x)); # execution


$T->demo(   
"\(\$x\+4\,\$x\*\$y\)", # typed in command           
($x+4,$x*$y)); # execution


$T->demo(   
"\$x\*\$y\*2", # typed in command           
$x*$y*2 # execution
) unless     1; # condition for execution                            

$T->demo(   
"\$x\*\$y\*2", # typed in command           
$x*$y*2 # execution
) unless     0; # condition for execution                            

$T->demo(   
"\$x\ \+\ \$y", # typed in command           
$x + $y); # execution


$T->demo(   
"\$x\ \+\ \$y", # typed in command           
$x + $y); # execution


$T->demo(   
"\$x\ \+\ \$y", # typed in command           
$x + $y); # execution



$T->finish();


=head1 NAME

tgA1.d - demostration script for tg1

=head1 SYNOPSIS

 tgA1.d

=head1 OPTIONS

None.

=head1 COPYRIGHT

Public Domain

## end of test script file ##

=cut

