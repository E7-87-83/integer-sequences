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

# Some forms:
# 10...01,
# 10...02
# 10...05
# 12...01
# 12...02
# 12...03
# 12...06
# 13...01
# 14...01
# 14...02
# 14...07
# 15...01
# 15...03
# 15...05
# 16...01
# 16...02
# 16...08
# 17...01
# 17...51
# 18...01
# 18...02
# 18...03
# 18...06
# 18...09
# 19...01
# 20...01
# 20...02
# 20...01
# 20...02
# 20...04
# 30...03, 40...04, 
# 50...05, 60...06, 70...07, 80..08, 90..09 ...


# A New Conjecture: If no zeros are allowed, the sequence is finite.
# This Look like easy to prove.
