use v5.30.0;
use Data::Dump qw/pp/;

{
    use strict;
    package Node;
    use List::Util qw/all any/;

    sub new {
        my ($class) = @_;
        bless {
            _value => $_[1],
            _children => $_[2],
            _player => $_[3],     # 1 or 2
            _winner => $_[4],
        }, $class;
    }

    sub value { $_[0]->{_value} }

    sub children { $_[0]->{_children} }
    sub set_children { $_[0]->{_children} = $_[1]; $_[1]; }
    sub add_child { 
        push @{$_[0]->{_children}}, $_[1];
    }

    sub player { $_[0]->{_player} }
    sub alt_player { $_[0]->{_player} == 1 ? 2 : 1; }
    sub set_player { $_[0]->{_player} = $_[1];}
    sub winner { $_[0]->{_winner} }
    sub set_winner {$_[0]->{_winner} = $_[1]; $_[1];}

    sub player_piece {
        scalar grep {$_== $_[0]->player} split "", $_[0]->value
    }
    sub alt_player_piece {
        scalar grep {$_ == $_[0]->alt_player} split "", $_[0]->value 
    }
    
    sub _me {
        my $node = $_[0];
        return $node->player == 1 ? 1 : -1;
    }

    sub _opp {
        my $node = $_[0];
        return $node->player == 1 ? -1 : 1;
    }

    sub make_children {
        my $node = $_[0];
        my @desc = @{available_nxt($node->value, $node->player)};
        if (scalar @desc != 0) {
            for my $v (@desc) {
                $node->add_child( \(Node->new( $v, [], $node->alt_player)) );
            }
        }
        else {
            @desc = @{available_nxt($node->value, $node->alt_player)};
            if (scalar @desc != 0) {
                for my $v (@desc) {
                    $node->add_child( \(Node->new( $v, [], $node->player)) );
                }
                $node->set_player($node->alt_player);
            }
            else {
                $node->set_children(undef);
                if ($node->player_piece > $node->alt_player_piece) {
                    $node->set_winner($node->_me);
                }
                elsif ($node->alt_player_piece > $node->player_piece) {
                    $node->set_winner($node->_opp);
                }
                else {
                    $node->set_winner(0);
                }
            }
        }
    }

    sub available_nxt {
        my $board = $_[0];
        my $player = $_[1];
        my $alt_player = $_[1] == 1 ? 2 : 1;
        my $kids;
        $board = add_lding_zero($board);
        my @arr = split "", $board;
        for my $p (0..$#arr) {
            my $left =  substr($board,0,$p+1) =~ /$player$alt_player+0$/; 
            my $right = substr($board,$p) =~ /^0$alt_player+$player/  ;
            if ($arr[$p] == 0 && ($left || $right)) {
                push $kids->@*, make_move($board, $player, $p, $left, $right);
            }
        }
        $kids = [ map {remove_lding_zero($_)} $kids->@* ];
        return $kids;
    }



    sub remove_lding_zero {
        my $v = $_[0];
        return $v =~ /^0/ ? substr($v, 1) : $v;
    }

    sub add_lding_zero {
        return "0".$_[0];
    }

    sub make_move {
        my $board = $_[0];
        my $player = $_[1];
        my $alt_player = $_[1] == 1 ? 2 : 1;
        my $pos = $_[2];
        my @arr = split "", $board;
        my $left = $_[3];
        my $right = $_[4];
        if ($left) {
            my $lbd = length $board;
            my $rboard = scalar reverse $board;
            my $rpos = $lbd - $pos - 1;
            my $j = $lbd - index($rboard, $player, $rpos+2 ) - 1;
            $arr[$_] = $player for ($j+1 .. $pos);
        }
        if ($right) {
            my $j = index($board, $player, $pos+2 );
            $arr[$_] = $player for ($pos .. $j-1);
        }
        $board = join "", @arr;
        return $board;
    }

    sub depth_first {
        my @stack;
        my $node = $_[0];
        my $n0;
        push @stack, \$node;
        while(scalar @stack > 0) {
            $n0 = (pop @stack)->$*;
            $n0->make_children;
            if (defined($n0->children)) { 
                push @stack, reverse $n0->children->@*;
            }
        }
    }

    sub node_winner {
        my $node = $_[0];
        return if defined($node->winner);
        $node->set_winner(undef) if any {!defined $$_->winner} $node->children->@*;
        $node->set_winner(1) if all {$$_->winner == 1} $node->children->@*;
        $node->set_winner(-1) if all {$$_->winner == -1 } $node->children->@*;
        $node->set_winner(0) if all {$$_->winner == 0 } $node->children->@*;
        if (!defined($node->winner)) {  
            if (any {$$_->winner == $node->_me } $node->children->@*) {
                $node->set_winner($node->_me);
            }
            else {
                $node->set_winner($node->_opp);
            }
        }
    }

    sub df_winner {
        my $t = 0;
        my $n0 = $_[0];
        if (defined($n0->children)) { 
            if (all {defined($$_->winner)} $n0->children->@*) {
                $n0->node_winner;
            }
            else {
                $$_->df_winner for $n0->children->@*;
                $n0->node_winner;
            }
        }
    }

}



sub base3 {
    my $num = $_[0];
    my @arr;
    while ($num != 0) {
        unshift @arr, $num % 3;
        $num = int $num / 3;
    }
    return join "", @arr;
}


=pod
    my $o1 = Node->new( 1210111212 , [], 1);
    $o1->make_children;

    pp $o1;

    my $o2 = Node->new( 21012 , [], 2);
    $o2->make_children;
    ${$o2->children->[0]}->make_children;
    pp $o2;
    my $o3 = Node->new( 21012 , [], 1);
    $o3->make_children;
    ${$o3->children->[0]}->make_children;
    ${${$o3->children->[0]}->children->[0]}->make_children;
    ${${${$o3->children->[0]}->children->[0]}->children->[0]}->make_children;
    ${${$o3->children->[0]}->children->[0]}->node_winner;
    ${$o3->children->[0]}->node_winner;
    $o3->node_winner;
    pp $o3;
=cut

=pod
    my $o4 = Node->new( 2111012 , [], 1);
    $o4->depth_first;
    $o4->df_winner;
    pp $o4;
    my $o5 = Node->new( 2111012 , [], 2);
    $o5->depth_first;
    $o5->df_winner;
    pp $o5;
    my $o6 = Node->new( 1221 , [], 2);
    $o6->depth_first;
    $o6->df_winner;
    pp $o6;
    my $o7 = Node->new( 1210111212 , [], 1);
    $o7->depth_first;
    $o7->df_winner;
    pp $o7;
    say $o7->winner;

    my $o8 = Node->new(2100111220 , [], 1);
    $o8->depth_first;
    $o8->df_winner;
    pp $o8;
    say $o8->winner;
    my $o9 = Node->new(111220 , [], 1);
    $o9->depth_first;
    pp $o9;
=cut


for my $i (1..300000) {
    my $o = Node->new(base3($i), [], $ARGV[0] || 1);
    $o->depth_first;
    $o->df_winner;
    say (
        $i, " ",
        # $o->value, " " , 
        $o->winner
    );
}
