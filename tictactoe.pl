use strict;
use Set::Scalar;

# Tic-Tac-Toe endings
# start 10th June 01:30am; roughly ok at 10th June 03:21
# The output of this file is not numerically sorted.

my @lines = ();
$lines[0] = Set::Scalar->new(1, 2, 3);
$lines[1] = Set::Scalar->new(4, 5, 6);
$lines[2] = Set::Scalar->new(7, 8, 9);
$lines[3] = Set::Scalar->new(1, 4, 7);
$lines[4] = Set::Scalar->new(2, 5, 8);
$lines[5] = Set::Scalar->new(3, 6, 9);
$lines[6] = Set::Scalar->new(3, 5, 7);
$lines[7] = Set::Scalar->new(1, 5, 9);

sub checkwinner {
    my $seq = $_[0];
    my $board = $_[1];
    my $sx = Set::Scalar->new();      #for x (the first player)
    my $so = Set::Scalar->new();      #for o (the second player)
    for my $j (0..8) {
        if ((substr $board, $j, 1) eq 'x') {$sx->insert($j+1);}
        elsif ((substr $board, $j, 1) eq 'o' ) {$so->insert($j+1);}
    }

    for my $i (0..7) {
        if ($sx->is_superset($lines[$i])  
                or 
            $so->is_superset($lines[$i])) {
            return 1;
        }
    }
    return 0;
}

sub makemove {
    my $seq = $_[0];
    my $filp = $_[1];
    my $board = $_[2];
    my $pos = $_[3];
    if ($filp == 0) {
        substr $board, $pos-1, 1, 'x';
        $seq .= $pos;
    } else {
        substr $board, $pos-1, 1, 'o';
        $seq .= $pos;
    }
    $filp = ($filp+1) % 2;

    return ($seq, $filp, $board);
}

sub nextmove {
    my $seq = $_[0];
    my $filp = $_[1];
    my $board = $_[2];
    my $pos = $_[3];
    ($seq, $filp, $board) = makemove($seq, $filp, $board, $pos);
#   print "~", $seq, "\n";  #testing
    if ( length($seq) == 9 or checkwinner($seq,$board) ) {
        print $seq, "\n";
    } else {
        my @a = ();
        for my $j (0 .. 8) {
            if ((substr $board, $j, 1) eq '0') {
                push @a, $j+1;
            }
        }
        for my $t_pos (@a) {
            nextmove($seq, $filp, $board, $t_pos);
        }
    }
}

for my $k (1..9) {
    nextmove('', 0, '000000000', $k);   # $seq, $filp, $board, $pos
}
