#!/usr/bin/perl
# inspired by The Weekly Challenge 113 Task 1 Represent Integer
# ref: https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/#TASK1
use strict;
use warnings;

my $B_MAX = 30;


=pod
my $_N = $ARGV[0];
my $_D = $ARGV[1];
my $_B = $ARGV[2] || 10;

die "Usage: ch-1.pl [a positive integer] [a non-zero digit] [optional: base]\n" 
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

for (my $_b = 2; $_b <= $B_MAX; $_b++) {
    for (my $m = 1; $m < $_b; $m++) {
        my $a = 0;
        for (my $i = 1; $i < $m*$_b; $i++) {
            $a++ if representable($i, $m, $_b);
        }
        print "$a, ";
    }
    print "\n";
}

=pod

1, 
2, 3, 
3, 3, 6, 
4, 6, 8, 10, 
5, 5, 5, 9, 15, 
6, 9, 12, 15, 18, 21, 
7, 7, 14, 7, 21, 18, 28, 
8, 12, 8, 20, 24, 15, 32, 36, 
9, 9, 18, 16, 9, 23, 36, 30, 45, 
10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 
11, 11, 11, 11, 33, 11, 44, 21, 30, 45, 66, 
12, 18, 24, 30, 36, 42, 48, 54, 60, 66, 72, 78, 
13, 13, 26, 23, 39, 33, 13, 43, 65, 53, 78, 63, 91, 
14, 21, 14, 35, 14, 26, 56, 63, 38, 27, 84, 50, 98, 105, 
15, 15, 30, 15, 45, 38, 60, 15, 75, 61, 90, 42, 105, 84, 120, 
16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 128, 136, 
17, 17, 17, 30, 51, 17, 68, 56, 17, 69, 102, 33, 119, 95, 75, 108, 153, 
18, 27, 36, 45, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135, 144, 153, 162, 171, 
19, 19, 38, 19, 19, 48, 76, 36, 95, 19, 114, 53, 133, 106, 54, 70, 171, 135, 190, 
20, 30, 20, 50, 60, 37, 20, 90, 54, 110, 120, 71, 140, 39, 88, 170, 180, 105, 200, 210, 
21, 21, 42, 37, 63, 53, 84, 69, 105, 85, 21, 101, 147, 117, 168, 133, 189, 149, 210, 165, 231, 
22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165, 176, 187, 198, 209, 220, 231, 242, 253, 
23, 23, 23, 23, 69, 23, 92, 23, 62, 93, 138, 23, 161, 128, 101, 45, 207, 66, 230, 105, 140, 198, 276, 
24, 36, 48, 60, 24, 84, 96, 108, 120, 46, 144, 156, 168, 180, 68, 204, 216, 228, 240, 90, 264, 276, 288, 300, 
25, 25, 50, 44, 75, 63, 100, 82, 125, 101, 150, 120, 25, 139, 200, 158, 225, 177, 250, 196, 275, 215, 300, 234, 325, 
26, 39, 26, 65, 78, 48, 104, 117, 26, 143, 156, 92, 182, 195, 114, 221, 234, 51, 260, 273, 158, 299, 312, 180, 338, 351, 
27, 27, 54, 27, 81, 68, 27, 51, 135, 109, 162, 75, 189, 27, 216, 99, 243, 191, 270, 123, 78, 232, 324, 147, 351, 273, 378, 
28, 42, 56, 70, 84, 98, 112, 126, 140, 154, 168, 182, 196, 210, 224, 238, 252, 266, 280, 294, 308, 322, 336, 350, 364, 378, 392, 406, 
29, 29, 29, 51, 29, 29, 116, 95, 78, 29, 174, 56, 203, 161, 29, 183, 261, 83, 290, 57, 176, 249, 348, 110, 135, 293, 225, 315, 435, 


Read as a triangle  --> t(row num, col num) 

It seems that t(x-1, y) = (x-1)*(y+1)/2 if x,y is coprime, x > y >= 1.

In particular, a general formula for the p-th column where p is an odd prime:
t(r, p) = r if p|r+1, else t(r, p) = (p+1)/2 * r;
and also a general formula for the (p-1)-th row:
t(p-1, q) = (p-1)*(q+1)/2.


The last terms in each row are the triangular numbers. (A000217)
The second-last terms of each even row are A001105. ( a(n) = 2*n^2.  )  Since n is always coprime with n-2 for odd n.)
The third-last terms of the (3n+1)-th rows are  3, 15, 36, 66, 105, 153     ( A062741 3 times pentagonal numbers)
The fourth-last terms of the (4n+1)-th rows are 5, 23, 53, 95, 149  A140811 ( a(n) =  6*n^2 - 1. )
The fifth-last terms of the (5n+1)-th rows are 9, 44, 104, 189, 299, ... (no known seq on OEIS)
The sixth-last terms of the (6n+1)-th rows are 7, 43, 106, 196... (no known seq on OEIS)
The seventh-last terms of the (7n+1)-th rows are 12, 75, 187, 348... (no known seq on OEIS)
The eighth-last terms of the (8n+1)-th rows are 9, 69, 177, 416 ... (no known seq on OEIS)

=cut
