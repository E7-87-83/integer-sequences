#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw/sum/;
use Integer::Partition;

sub split_binstr {
    my @small;
    my $binstr = shift @_;
    my @partial = @_;
    die "wrong input for &split_binstr" if (sum @partial) != (length $binstr); 
    my $indent = 0;
    my $a = 0;
    for (0..$#partial) {
        push @small , (substr $binstr, $indent, $partial[$_]);
        $indent += $partial[$_];
    }
    return @small;
}

sub is_non_increasing {
    my @small = @_;
    my $ning = 1;
    my $a = 0;
    while ($ning && $a <= $#small-1 ) {
        $ning = $small[$a] >= $small[$a+1];
        $a++;
    }
    return $ning;
}

sub int_part {
    my $num_of_parti = 0;
    my $binstr = $_[0];
    my $i = Integer::Partition->new(length $binstr);
    while (my $p = $i->next) {
        my @temp = split_binstr($binstr, @{$p});
        if (is_non_increasing(@temp)) {
#           print join( ' ', @temp ), "\n";
            $num_of_parti++;
        }
    }
    return $num_of_parti;
}

for (1..1024) {
    print "", int_part(sprintf("%0b", $_)), "\n";
}


print "\n";

#1010100
