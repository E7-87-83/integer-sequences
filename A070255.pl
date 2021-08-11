#!/usr/bin/perl
# OEIS: A070255
use strict;
use warnings;
use v5.10.0;

sooo($_) for (11..30_000_000);

sub sooo {
    my $n = $_[0];

    return if $n % 10 == 0;


    for my $p (1..(length $n) - 1) {
        my $c = substr( $n , 0, $p );
        my $d = substr( $n, $p, (length $n) - $p);
        return if ($c % $d != 0) && ($d % $c != 0);   
    }

    say $n;
    return;

}
