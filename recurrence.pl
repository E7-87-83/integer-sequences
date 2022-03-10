#!/usr/bin/perl
# Inspired by The Weekly Challenge 155 Task 2

# Output: (first 40 terms)
# 5, 13, 25, 26, 47, 52, 59, 65, 71, 97, 125, 130, 169, 191, 235, 260, 
# 271, 295, 325, 338, 355, 377, 467, 485, 507, 559, 611, 617, 625, 650, 
# 661, 676, 754, 767, 793, 845, 923, 953, 955, 967

# Primes: 5, 13, 47, 59, 71, 97, 191, 271, 467, 617, 661, 953, 967

#   5 * (1,5,13,25,26,47,52,59,65,71,97,125,130,169,191)
#  13 * (1,2,4,5,10,13,20,25,26,29,39,43,47,50,52,58,59,61,65,71)
#  47 * (1, 5, 13)
#  59 * (1, 5, 13)
#  71 * (1, 5, 13)
#  97 * (1, 5)
# 191 * (1, 5)

=pod
https://oeis.org/A271953  a(n) is the period of Narayana's cows sequence modulo n
Let the prime factorization of n be p1^e1*...*pk^ek. Then a(n) = lcm(a(p1^e1), ..., a(pk^ek)) [Engstrom]

https://www.ams.org/journals/tran/1931-033-01/S0002-9947-1931-1501585-5/
On sequences defined by linear recurrence relations, H. T. Engstrom, 1931
=cut



use v5.22.0;
use warnings;
use List::Util qw/any sum/;

for my $i (2..1000) {
    if (
        scalar @{pisano_period($i, 3, [1,1,1], [0,0,1])}  # Tribonacci numbers  #OEIS:A000073
     == scalar @{pisano_period($i, 3, [1,0,1], [1,1,1])}  # Narayana's cows sequence #OEIS:A000930
    ) {
        say $i;
    } 
}



sub pisano_period {
    my ($N, $t, $rec, $seq) = @_;
    @$seq = map {$_ % $N} @$seq;
    my $ori_seqstate = [@$seq];
    my $new_seqstate = [@$ori_seqstate];
    my $count = 0;
    do { 
        my $new_val = sum map {$rec->[$_]*$new_seqstate->[$_]} (0..$t-1);
        $new_val = $new_val % $N;
        push @{$seq}, $new_val;
        shift @{$new_seqstate};
        push @{$new_seqstate}, $new_val;
        $count++;
        die "Patterns not found\n" if $count > $N**$t + $t;
    } while (!cmp_num_arr($new_seqstate, $ori_seqstate));

    return [@$seq[0..$count-1]];
}


sub cmp_num_arr {
    my $l_a = $_[0];
    my $l_b = $_[1];
    my $i = 0;
    while ($l_a->[$i] == $l_b->[$i]) {
        $i++;
        return 1 if $i == scalar @$l_a;
    }
    return 0;
}


