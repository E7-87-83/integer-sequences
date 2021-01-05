#!/usr/bin/perl

# also published on 
# https://perlweeklychallenge.org/blog/advent-calendar-2020-12-12/

use strict;
use warnings;


sub max {
    return $_[0]>$_[1] ? $_[0] : $_[1];
}

sub mult_nt {
    my $z = $_[0];
    my $pow_two = 0;
    my $pow_five = 0;

    while ( $z % 2 == 0) {
        $z /= 2;
        $pow_two++;
    }

    while ( $z % 5 == 0) {
        $z /= 5;
        $pow_five++;
    }

    # let $x = max($pow_two,$pow_five)
    # answer = 10**$x * $z * something
    # Now we are going to calculate what "$z*something" should be

    my $key = undef;

    if ($z != 1) {
        my $k = 0;
        my $temp = 10 % $z;
        my @RMNDER = (undef);
        do {
            $RMNDER[2**$k] = $temp;
            for ( 1 .. 2**$k-1 ) {
                $RMNDER[2**$k + $_] = ( $RMNDER[$_] + $temp) % $z ;
                if ($RMNDER[2**$k + $_] == 0) {
                    $key = 2**$k + $_;
                    last;
                }
            }
            $temp = (10*$RMNDER[2**$k]) % $z;
            $k++;
        } while (!$key);
    }

    # Now we get all integers ready for the answer

    my $ans = ($z == 1)? 1 : sprintf( "%0b", $key);
    $ans .= "0" x max($pow_two,$pow_five);

    return $ans;
}

print mult_nt($ARGV[0]), "\n";
