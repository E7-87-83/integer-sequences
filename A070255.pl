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

# A New Conjecture: If no zeros is allowed, the sequence is finite.
# Another conjecture: are all very large terms one of the form 
# d*10^n + d , where d goes from 1 to 9? i.e.
# 10...01, 20...02, 30...03, 40...04, 
# 50...05, 60...06, 70...07, 80..08, 90..09 ?
