#!/usr/bin/perl
# The Weekly Challenge 113
# Task 1 Represent Integer
use strict;
use warnings;

my $_N = $ARGV[0];
my $_D = $ARGV[1];
my $_B = $ARGV[2] || 10;

=pod
die "Usage: ch-1.pl [a positive integer] [a non-zero digit] [the base]\n" 
    unless $_N =~ /^\d+$/ && $_D =~ /^\d$/;

print representable($_N, $_D, $_B), "\n";
=cut


sub representable {
    my $N = $_[0];
    my $D = $_[1];
    my $B = $_[2];
    
    return 1 if $N >= $B*$D;   
    # important line; below we deal with $N < 10*$D only

    return 1 if $N % $D == 0;  # $N = $D + $D + ... + $D, esp $D == 1

    return last_digit($D, $N, $B); 
}

sub last_digit {
    my $digit = $_[0];
    my $short = $_[1];
    my $B = $_[2];
    my $last_digit_of_short = $short % $B;
    my $i = 1;
    while ($digit*$i < $short) {
        if ( $digit*$i % $B  == $last_digit_of_short ) {
            return 1;
        }
        $i++;
    }
    return 0;
}

for (my $_b = 3; $_b <= 30; $_b++) {
    for (my $m = 2; $m < $_b; $m++) {
        my $a = 0;
        for (my $i = 1; $i < $m*$_b; $i++) {
            $a++ if representable($i, $m, $_b);
        }
        print "$a, ";
    }
    print "\n";
}


=pod
 Testing:
 for (my $i = 10; $i < 70; $i++) {
     print $i," " , representable($i, 7) , "\n";
 }
 for (my $i = 10; $i < 90; $i++) {
     print $i," " , representable($i, 9) , "\n";
 }
=cut
