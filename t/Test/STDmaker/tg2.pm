#!perl
#
# Documentation, copyright and license is at the end of this file.
#
package  Test::STDmaker::tg1;

use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION);

$VERSION = '0.02';

1

__END__

=head1 Requirements

=head2 Capability-A 

The requriements are as follows:

=over 4

=item capability-A [1]

This subroutine shall[1] have feature 1. 

=item capability-A [2]

This subroutine shall[2] have feature 2.

=back

=head2 Capability-B
 
=over 4

=item Capability-B [1]

This subroutine shall[1] have feature 1.

=item Capability-B [2]

This subroutine shall[2] have feature 2.

=item Capability-B [3]

This subroutine shall[3] have feature 3.

=back

=head1 DEMONSTRATION

 ~~~~~~ Demonstration overview ~~~~~

Perl code begins with the prompt

 =>

The selected results from executing the Perl Code 
follow on the next lines. For example,

 => 2 + 2
 4

 ~~~~~~ The demonstration follows ~~~~~

 =>     #########
 =>     # For "TEST" 1.24 or greater that have separate std err output,
 =>     # redirect the TESTERR to STDOUT
 =>     #
 =>     tech_config( 'Test.TESTERR', \*STDOUT );
 => my $x = 2
 => my $y = 3
 => $x + $y
 5

 => $y-$x
 1

 => $x+4
 6

 => $x*$y*2
 12

 => $x
 2

 =>     my @expected = ('200','201','202');
 =>     my $i;
 =>     for( $i=0; $i < 3; $i++) {
 => $i+200
 200

 => $i + ($x * 100)
 200

 =>     };
 => $i+200
 201

 => $i + ($x * 100)
 201

 =>     };
 => $i+200
 202

 => $i + ($x * 100)
 202

 =>     };
 => $x + $y
 5

 => $x + $y + $x
 7

 => $x + $y + $x + $y
 10


=head1 SEE ALSO

http://perl.SoftwareDiamonds.com

