#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
package  Data::Str2Num;

use strict;
use 5.001;
use warnings;
use warnings::register;

#####
# Connect up with the event log.
#
use vars qw( $VERSION $DATE $FILE);
$VERSION = '0.05';
$DATE = '2004/05/19';
$FILE = __FILE__;

use vars qw(@ISA @EXPORT_OK);
require Exporter;
@ISA=('Exporter');
@EXPORT_OK = qw(str2int str2float);

use Data::Startup;

use vars qw($default_options);
$default_options = new();

#######
# Object used to set default, startup, options values.
#
sub new
{
   Data::Startup->new(
 
      ######
      # Make Test variables visible to tech_config
      #  
      ascii_float => 0
   );

}


######
# Covert a string to floats.
#
sub str2float
{
     shift if UNIVERSAL::isa($_[0],__PACKAGE__);
     return '',() unless @_;

     $default_options = Data::Str2Num->new() unless ref($default_options);
     my $options = $default_options->override(pop @_) if ref($_[-1]);

     #########
     # Drop leading empty strings
     #
     my @strs = @_;
     while (@strs && $strs[0] !~ /^\s*\S/) {
          shift @strs;
     }
     @strs = () unless(@strs); # do not shift @strs out of existance

     my @floats = ();
     my $early_exit unless wantarray;
     my ($sign,$integer,$fraction,$exponent);
     foreach (@strs) {
         while ( length($_) ) {

             ($sign, $integer,$fraction,$exponent) = ('',undef,undef,undef);

             #######
             # Parse the integer part
             #
             if($_  =~ s/^\s*(-?)\s*(0[0-7]+|0?b[0-1]+|0x[0-9A-Fa-f]+)\s*[,;\n]?//) {
                 $integer = 0+oct($1 . $2);
                 $sign = $1 if $integer =~ s/^\s*-//;
             }
             elsif ($_ =~ s/^\s*(-?)\s*([0-9]+)\s*[,;\n]?//) {
                 ($sign,$integer) = ($1,$2);
             }

             ######
             # Parse the decimal part
             # 
             $fraction = $1 if $_ =~ s/^\.([0-9]+)\s*[,;\n]?// ;

             ######
             # Parse the exponent part
             $exponent = $1 . $2 if $_ =~ s/^E(-?)([0-9]+)\s*[,;\n]?//;

             goto LAST unless defined($integer) || defined($fraction) || defined($exponent);

             $integer = '' unless defined($integer);
             $fraction = '' unless defined($fraction);
             $exponent = 0 unless defined($exponent);

             if($options->{ascii_float} ) {
                 $integer .= '.' . $fraction if( $fraction);
                 $integer .= 'E' . $exponent if( $exponent);
                 push @floats,$sign . $integer;  
             }
             else {
                 ############
                 # Normalize decimal float so that there is only one digit to the
                 # left of the decimal point.
                 # 
                 while($integer  && substr($integer,0,1) == 0) {
                    $integer = substr($integer,1);
                 }
                 if( $integer ) {
                     $exponent += length($integer) - 1;
                 }
                 else {
                     while($fraction && substr($fraction,0,1) == 0) {
                         $fraction = substr($fraction,1);
                         $exponent--;
                     }
                     $exponent--;
                 }
                 $integer .= $fraction;
                 while($integer  && substr($integer,0,1) == 0) {
                    $integer = substr($integer,1);
                 }
                 $integer = 0 unless $integer;
                 push @floats,[$sign . $integer,  $exponent];
             }
             goto LAST if $early_exit;
         }
         last if $early_exit;
     }

LAST:
     #########
     # Drop leading empty strings
     #
     while (@strs && $strs[0] !~ /^\s*\S/) {
          shift @strs;
     }
     @strs = () unless(@strs); # do not shift @strs out of existance

     return (\@strs, @floats) unless $early_exit;
     ($integer,$fraction,$exponent) = @{$floats[0]};
     "${integer}${fraction}E${exponent}"
}


######
# Convert number (oct, bin, hex, decimal) to decimal
#
sub str2int
{
     shift  if UNIVERSAL::isa($_[0],__PACKAGE__);
     unless( wantarray ) {
         return undef unless(defined($_[0]));
         my $str = $_[0];
         return 0+oct($1) if($str =~ /^\s*(-?\s*0[0-7]+|0?b[0-1]+|0x[0-9A-Fa-f]+)\s*[,;\n]?$/);
         return 0+$1 if ($str =~ /^\s*(-?\s*[0-9]+)\s*[,;:\n]?$/ );
         return undef;
     }

     #######
     # Pick up input strings
     #
     return [],() unless @_;

     $default_options = Data::Str2num->new() unless ref($default_options);
     my $options = $default_options->override(pop @_) if ref($_[-1]);
     my @strs = @_;

     #########
     # Drop leading empty strings
     #
     while (@strs && $strs[0] !~ /^\s*\S/) {
          shift @strs;
     }
     @strs = () unless(@strs); # do not shift @strs out of existance

     my ($int,$num);
     my @integers = ();
     foreach $_ (@strs) {
         while ( length($_) ) {
             if($_  =~ s/^\s*(-?)\s*(0[0-7]+|0?b[0-1]+|0x[0-9A-Fa-f]+)\s*[,;\n]?//) {
                 $int = $1 . $2;
                 $num = 0+oct($int);
             }
             elsif ($_ =~ s/^\s*(-?)\s*([0-9]+)\s*[,;\n]?// ) {
                 $int = $1 . $2;
                 $num = 0+$int;
 
             }
             else {
                 goto LAST;
             }

             #######
             # If the integer is so large that Perl converted it to a float,
             # repair the str so that the large integer may be dealt as a string
             # or converted to a float. The using routine may be using Math::BigInt
             # instead of using the native Perl floats and this automatic conversion
             # would cause major damage.
             # 
             if($num =~ /\s*[\.E]\d+/) {
                 $_ = $int;
                 goto LAST;
             }
 
             #######
             # If there is a string float instead of an int  repair the str to 
             # perserve the float. The using routine may decide to use str2float
             # to parse out the float.
             # 
             elsif($_ =~ /^\s*[\.E]\d+/) {
                 $_ = $int . $_;
                 goto LAST;
             }
             push @integers,$num;
         }
     }

LAST:
     #########
     # Drop leading empty strings
     #
     while (@strs && $strs[0] !~ /^\s*\S/) {
          shift @strs;
     }
     @strs = ('') unless(@strs); # do not shift @strs out of existance

     (\@strs, @integers);
}

1

__END__

=head1 NAME

Data::Str2int - int, int str to int; else undef. No warnings

=head1 SYNOPSIS

 int, int str to int; else undef. No warnings.

 #####
 # Subroutine interface
 #  
 use Data::Str2Num qw(str2int);

 $integer = str2int($string);

=head1 DESCRIPTION

The L<Data::SecsPack|Data::SecsPack> program module
supercedes this program module. 
The C<Data::SecsPack::str2int> subroutine,
in a scalar context, behaves the same and 
supercedes C&<Data::StrInt::str2int>.
In time, this module will vanish.

The C<str2int> subroutine translates an scalar numeric string 
and a scalar number to a scalar integer; otherwsie it returns
an C<undef>.

Perl itself has a documented function, '0+$x', that converts 
a number scalar 
so that its internal storage is an integer
(See p.351, 3rd Edition of Programming Perl).
"If it cannot perform the conversion, it leaves the integer 0."
In addition the C<0 +> also produces a warning.

So how do you tell a conversion failure from the number 0?
Compare the output to the input?
Trap the warning?
Surprising not all Perls, some Microsoft Perls in particular, may leave
the internal storage as a scalar string and do not do numeric strings.
Perl 5.6 under Microsoft has a broken '0+' and is
no longer actively supported.
It is still very popular and widely used on web hosting computers.

What is C<$x> for the following, Perl 5.6, Microsoft:

 my $x = 0 + '0x100';  # $x is 0 with a warning  

The C<str2int> provides a different behavior that
is more usefull in many situations as follows:

 $x = str2int('033');   # $x is 27
 $x = str2int('0xFF');  # $x is 255
 $x = str2int('255');   # $x is 255
 $x = str2int('hello'); # $x is undef no warning
 $x = str2int(0.5);     # $x is undef no warning
 $x = str2int(1E0);     # $x is 1 
 $x = str2int(0xf);     # $x is 15
 $x = str2int(1E30);    # $x is undef no warning

The C<str2int> pulls out
anything that resembles an integer; otherwise it returns undef
with no warning.
This makes the C<str2int> subroutine not only useful for forcing an
integer conversion but also for parsing scalars from
strings. 

The Perl code is a few lines without starting any whatevers
with a Perl C<eval> and attempting to trap all the warnings
and dies, and without the regular expression 
engine with its overhead.
The code works on broken Microsoft 5.6 Perls.

=head1 SEE ALSO

=over 4

=item L<Data::SecsPack|Data::SecsPack> 

=back

=cut

### end of script  ######