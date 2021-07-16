#!/usr/bin/perl
use strict;
use warnings;
use v5.10;

# a(n) = number of r such that n is base-r 
# is consisted of 1's and 0's only, where r > 1.

# 3 <= a(n) <= n-2 for n > 4

# Question:
#  I. For a positive integer s > 2, does it exists  
#   positive integer m such that a(n) > s for all n > m?
#II. For any positive integer s > 2, does it always exists
#   a positive integer m such that a(m) >= s ?
#III. For any positive integer s > 2, does it always exists
#   a positive integer m such that a(m) = s ?

my $UPPER = $ARGV[0] || 20;

sub toBase {
    my $n = $_[0];
    my $b = $_[1];
    my $_n = $n;
    my @r;
    while ($_n > 0) {
        unshift @r, $_n % $b;
        $_n = int $_n/$b;
    }
    return join "", @r;
}

sub countA {
    my $n = $_[0];
    my $ans = 1;
    for my $r (3..$n) {
        $ans++ if toBase($n, $r) =~ m/^[01]+$/;
    }
    return $ans;
}


for my $n (2..$UPPER) {
    my $c = countA($n);
    printf "%3d %3d\n", $n, $c ;
}

=pod

Question II can be answered by considering 2^($k)+1 .

  2   1
  3   2
  4   3
  5   3
  6   3
  7   3
  8   3
  9   4
 10   4
 11   3
 12   4
 13   4
 14   3
 15   3
 16   4
 17   4
 18   3
 19   3
 20   4
 21   5
 22   4
 23   5
 24   5
 25   6
 26   6
 27   6
 28   6
 29   5
 30   7

1000  15
1001  14
1002  12
1003  11
1004   9
1005   9
1006   9
1007   9
1008  10
1009  11
1010  13
1011  14
1012  12
1013  10
1014   9
1015   9
1016   9
1017   9
1018   9
1019   9
1020  11
1021  11
1022  10
1023  11
1024  12
1025  11
1026  10
1027  10
1028  10
1029  10
1030  11
1031  11
1032   9
1033  10
1034  12
1035  11
1036  10
1037  10
1038   9
1039   9
1040  12
1041  12
1042   9
1043   9
1044  11
1045  12
1046  10
1047   9
1048   9
1049   9
1050  11
1051  11
1052   9
1053  10
1054  10
1055  10
1056  13
1057  12
1058   9
1059   9
1060  11
1061  11
1062  10
1063  10
1064  10
1065  11
1066  12
1067  12
1068  10
1069   9
1070  11
1071  11
1072   9
1073   9
1074  10
1075  10
1076   9
1077  10
1078  11
1079  10
1080  12
1081  12
1082   9
1083  10
1084  10
1085   9
1086   9
1087   9
1088  11
1089  14
1090  14
1091  11
1092  12
1093  12
1094   9
1095   9
1096   9
1097   9
1098   9
1099  11
1100  15
1101  13
1102  10
1103  10
1104  10
1105  10
1106   9
1107   9
1108  10
1109  10
1110  14
1111  14
1112  10
1113   9
1114   9
1115   9
1116   9
1117   9
1118   9
1119   9
1120  12
1121  13
1122  12
1123  11
1124   9
1125   9
1126   9
1127   9
1128   9
1129   9
1130  12
1131  13
1132  12
1133  12
1134  10
1135   9
1136   9
1137   9
1138   9
1139   9
1140  12
1141  13
1142  10
1143  10
1144  11
1145  10
1146   9
1147   9
1148   9
1149   9
1150  12
1151  12
1152   9
1153   9
1154  10
1155  11
1156  11
1157  10
1158   9
1159   9
1160  13
1161  13
1162   9
1163   9
1164   9
1165  10
1166  12
1167  11
1168   9
1169   9
1170  13
1171  13
1172   9
1173   9
1174   9
1175   9
1176  10
1177  11
1178  10
1179   9
1180  12
1181  12
1182   9
1183   9
1184   9
1185   9
1186   9
1187  10
1188  11
1189  10
1190  13
1191  13
1192   9
1193   9
1194   9
1195   9
1196   9
1197   9
1198  10
1199  11
1200  15
