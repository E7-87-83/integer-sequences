# Conjecture: A349294 is finite.
# Note on the program: not fast enough

use v5.12.0;
use warnings;
use List::Util qw/first any shuffle/;

my $n = $ARGV[0] || 2;

# case I: $seq[1] <= n-1  and  $seq[1] > n/2
my @test_arr = shuffle (int $n/2 + 1 .. $n-1);
search( $_, $n ) for @test_arr;
say "highly probable => gone;";
search( $n, $n );
say "n on the second position => gone;";
search( $_, $n ) for 1..int $n/2;
say "small numbers on the second position => gone;";

sub appear_before {
    my @arr = @{$_[0]};
    my $num = $_[1];
    return (any { $_ == $num} @arr) ? 1 : 0;
}

my %probable_possible;
my %appear;


sub search {
    %probable_possible = ();
    %appear = ();
    my @seq;

    my $m = $_[0];
    my $n = $_[1];

    my @rand_arr = shuffle (1..$m-1, $m+1..$n);

    $seq[0] = undef;
    $seq[1] = $m;

    for my $k (0..$#rand_arr) {
        $seq[2] = $rand_arr[$k];
        search_tree([@seq], [@rand_arr]);
    }

    foreach my $key (keys %probable_possible) {
        my @_seq = split ",", $key;
        my $late = first { !appear_before([@_seq], $_) } (1..$n);
        if ( ($_seq[0] + $_seq[1]) % $late == 0 ) {
            unshift @_seq, $late;
            say join "," , @_seq;
        }
    }
}

sub search_tree {
    my @seq = @{$_[0]};
    my @rand_arr = @{$_[1]};
    my $key_str = join "," , @seq[1..$#seq];
    return 0 if ($appear{ $key_str });
    $appear{ $key_str } = 1;
    if ($#seq == $n-1) {
        $probable_possible{ join ",", @seq[1..$#seq] } = 1;
        return 1;
    }

    my @candidate_factors = 
        grep {     ($_ + $seq[-1]) % $seq[-2] == 0 
                && !(appear_before([@seq[1..$#seq]], $_)) } 
            @rand_arr;
    return 0 if (scalar @candidate_factors == 0);
    for (@candidate_factors) {
        search_tree([@seq, $_], [@rand_arr]);
    }
}

#Tuesday, November 16, 2021 AM11:22:59 HKT
