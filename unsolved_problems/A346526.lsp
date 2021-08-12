; "Conjecture: Lim_{n->infinity} a(n)/a(n-1) = 1. "

(setf candidates (list 25))
(setf result nil)

(defun factor (num small-num)
  (equalp 0 (mod num small-num)))

(defun same-end-digit (num1 num2 num3)
  (and (equalp (mod num1 10) (mod num2 10))
       (equalp (mod num2 10) (mod num3 10))))

(defun good-factor-p (num)
  (loop for i from 5 to (sqrt num)
    do (
      if (factor num i) ( 
        if (same-end-digit num i (/ num i) ) 
            (return T) ))))


(loop for i from 26 to 9000
    do (
        if (or (equalp 0 (mod i 10))
               (equalp 1 (mod i 10)) 
               (equalp 5 (mod i 10)) 
               (equalp 6 (mod i 10))) 
          (push i candidates)))

(dolist (element candidates)
  (if (good-factor-p element) 
    (push element result)))

(format t (write-to-string result))

;( 25 36 75 96 100 121 125 156 175 200 216 225 231 256 275 276 300 325 336 341
; 375 396 400 416 425 441 451 456 475 500 516 525 561 575 576 600 625 636 651
; 671 675 676 696 700 725 736 756 775 781 800 816 825 861 875 876 891 896 900
; 925 936 961 975 996 1000 1001 1025 1056 1071 1075 1100 1111 1116 1125 1175
; 1176 1196 1200 1216 1221 1225 1236 1271 1275 1281 1296 1300 1325 1331 1356
; 1375 1376 1400 1416 1425 1441 1456 1475 1476 1491 1500 1525 1536 1551 1575
; 1581 1596 1600 1625 1656 1661 1675 1681 1696 1700 1701 1716 1725 1771 1775
; 1776 1800 1825 1836 1856 1875 1881 1891 1896 1900 1911 1925 1956 1975 1976
; 1991 2000 2016 2025 2075 2076 2091 2100 2101 2116 2121 2125 2136 2175 2176
; 2196 2200 2201 2211 2225 2236 2256 2275 2300 2316 2321 2325 2331 2336 2375
; 2376 2400 2425 2431 2436 2475 2496 2500 2501 2511 2525 2541 2556 2575 2576
; 2600 2601 2616 2625 2651 2656 2675 2676 2700 2725 2736 2751 2756 2761 2775
; 2796 2800 2816 2821 2825 2856 2871 2875 2900 2911 2916 2925 2961 2975 2976
; 2981 3000 3016 3025 3036 3075 3091 3096 3100 3111 3125 3131 3136 3156 3171
; 3175 3200 3201 3216 3225 3275 3276 3296 3300 3311 3321 3325 3336 3375 3381
; 3396 3400 3421 3425 3441 3456 3475 3496 3500 3516 3525 3531 3536 3575 3576
; 3591 3600 3616 3621 3625 3636 3641 3675 3696 3700 3721 3725 3731 3751 3756
; 3775 3776 3796 3800 3801 3816 3825 3861 3875 3876 3900 3925 3936 3956 3971
; 3975 3996 4000 4011 4025 4056 4061 4075 4081 4096 4100 4116 4125 4131 4141
; 4175 4176 4191 4200 4221 4225 4236 4256 4275 4296 4300 4301 4316 4325 4331
; 4356 4371 4375 4400 4411 4416 4425 4431 4475 4476 4500 4521 4525 4536 4551
; 4575 4576 4596 4600 4625 4631 4641 4656 4675 4681 4700 4716 4725 4736 4741
; 4775 4776 4800 4816 4825 4836 4851 4875 4876 4896 4900 4925 4941 4956 4961
; 4975 4991 5000 5016 5025 5041 5056 5061 5071 5075 5076 5096 5100 5125 5136
; 5151 5175 5181 5196 5200 5216 5225 5256 5271 5275 5291 5300 5301 5316 5325
; 5336 5356 5371 5375 5376 5400 5401 5425 5436 5475 5481 5496 5500 5511 5525
; 5536 5551 5556 5575 5600 5611 5616 5621 5625 5661 5675 5676 5691 5696 5700
; 5725 5731 5736 5751 5775 5776 5781 5796 5800 5825 5841 5856 5875 5876 5900
; 5901 5916 5921 5925 5936 5951 5975 5976 6000 6016 6025 6036 6061 6075 6096
; 6100 6111 6125 6136 6156 6161 6171 6175 6176 6191 6200 6216 6225 6231 6256
; 6275 6276 6281 6300 6321 6325 6336 6375 6391 6396 6400 6425 6456 6461 6475
; 6496 6500 6501 6516 6525 6531 6536 6541 6561 6575 6576 6600 6601 6611 6625
; 6636 6656 6675 6681 6696 6700 6716 6721 6725 6741 6756 6771 6775 6800 6816
; 6825 6831 6851 6875 6876 6900 6916 6925 6936 6941 6951 6975 6976 6996 7000
; 7011 7025 7051 7056 7075 7100 7116 7125 7136 7161 7171 7175 7176 7191 7200
; 7225 7236 7271 7275 7296 7300 7325 7356 7371 7375 7381 7396 7400 7416 7421
; 7425 7436 7456 7471 7475 7476 7491 7500 7525 7536 7575 7581 7596 7600 7601
; 7616 7625 7636 7656 7675 7696 7700 7701 7711 7716 7725 7775 7776 7781 7791
; 7800 7821 7825 7831 7836 7875 7881 7896 7900 7925 7931 7936 7956 7975 7991
; 8000 8001 8016 8025 8041 8056 8075 8076 8091 8096 8100 8125 8136 8151 8175
; 8176 8181 8196 8200 8211 8216 8225 8241 8256 8261 8275 8281 8300 8316 8325
; 8371 8375 8376 8400 8401 8416 8421 8425 8436 8475 8476 8481 8496 8500 8525
; 8556 8575 8576 8591 8600 8601 8616 8625 8631 8651 8675 8676 8700 8701 8711
; 8721 8725 8736 8775 8796 8800 8811 8816 8825 8841 8856 8875 8896 8900 8916
; 8921 8925 8975 8976 8991 8996 9000)

;(90000 90016 90021 90025 90036 90075 90096 90100 90101 90111 90116 90125 90136
; 90156 90175 90176 90181 90200 90201 90211 90216 90225 90241 90275 90276 90300
; 90321 90325 90336 90341 90375 90376 90381 90396 90400 90425 90431 90436 90456
; 90475 90496 90500 90501 90516 90521 90525 90531 90541 90551 90575 90576 90600
; 90601 90611 90625 90636 90651 90656 90675 90681 90696 90700 90725 90736 90741
; 90751 90756 90761 90775 90800 90801 90816 90825 90831 90861 90871 90875 90876
; 90896 90900 90925 90936 90941 90951 90975 90976 90981 90996 91000 91001 91025
; 91056 91061 91075 91091 91096 91100 91116 91125 91131 91136 91156 91161 91171
; 91175 91176 91200 91201 91225 91236 91275 91296 91300 91311 91325 91336 91341
; 91356 91371 91375 91396 91400 91416 91421 91425 91456 91471 91475 91476 91481
; 91500 91525 91531 91536 91561 91575 91581 91596 91600 91611 91616 91625 91641
; 91656 91661 91675 91676 91700 91716 91725 91751 91756 91775 91776 91791 91796
; 91800 91816 91821 91825 91831 91836 91851 91861 91871 91875 91876 91881 91896
; 91900 91925 91931 91936 91956 91971 91975 92000 92001 92011 92016 92025 92036
; 92075 92076 92081 92096 92100 92101 92125 92136 92171 92175 92176 92191 92196
; 92200 92211 92225 92241 92256 92261 92275 92276 92291 92296 92300 92301 92316
; 92325 92336 92361 92371 92375 92376 92400 92411 92416 92421 92425 92436 92456
; 92475 92491 92496 92500 92511 92521 92525 92536 92556 92575 92576 92600 92616
; 92625 92631 92661 92675 92676 92700 92701 92716 92721 92725 92736 92741 92775
; 92781 92796 92800 92825 92841 92851 92856 92871 92875 92896 92900 92911 92916
; 92925 92961 92975 92976 93000 93011 93021 93025 93031 93036 93041 93051 93056
; 93071 93075 93081 93096 93100 93111 93121 93125 93141 93156 93175 93176 93181
; 93196 93200 93201 93216 93225 93231 93236 93261 93275 93276 93291 93296 93300
; 93325 93336 93341 93351 93375 93376 93381 93391 93396 93400 93401 93411 93425
; 93456 93471 93475 93496 93500 93511 93516 93521 93525 93536 93541 93575 93576
; 93600 93611 93621 93625 93636 93651 93656 93675 93681 93696 93700 93725 93731
; 93756 93771 93775 93781 93791 93800 93816 93821 93825 93841 93856 93875 93876
; 93891 93900 93916 93925 93931 93936 93951 93956 93961 93975 93996 94000 94001
; 94016 94025 94031 94041 94056 94061 94075 94100 94101 94116 94125 94171 94175
; 94176 94200 94221 94225 94231 94236 94256 94271 94275 94276 94281 94296 94300
; 94301 94311 94316 94325 94336 94341 94356 94375 94391 94400 94401 94416 94425
; 94451 94461 94475 94476 94496 94500 94501 94521 94525 94536 94575 94576 94581
; 94596 94600 94611 94625 94656 94671 94675 94696 94700 94716 94721 94725 94731
; 94751 94775 94776 94796 94800 94816 94825 94831 94836 94851 94875 94891 94896
; 94900 94911 94925 94941 94956 94975 94976 95000 95016 95025 95036 95041 95051
; 95056 95075 95076 95100 95116 95121 95125 95136 95151 95161 95175 95196 95200
; 95201 95211 95221 95225 95251 95256 95271 95275 95281 95296 95300 95316 95325
; 95361 95375 95376 95381 95400 95421 95425 95436 95456 95475 95491 95496 95500
; 95511 95525 95536 95556 95571 95575 95576 95600 95601 95616 95625 95631 95641
; 95661 95675 95676 95691 95700 95711 95725 95736 95761 95775 95776 95781 95796
; 95800 95816 95821 95825 95831 95836 95856 95875 95900 95916 95921 95925 95931
; 95936 95956 95975 95976 95981 95991 95996 96000 96016 96021 96025 96036 96041
; 96051 96075 96096 96100 96111 96125 96131 96151 96156 96175 96200 96201 96216
; 96225 96256 96261 96275 96276 96300 96321 96325 96336 96356 96371 96375 96391
; 96396 96400 96411 96416 96425 96441 96456 96471 96475 96481 96496 96500 96516
; 96525 96551 96575 96576 96591 96600 96616 96621 96625 96631 96636 96641 96656
; 96675 96681 96696 96700 96701 96721 96725 96736 96751 96756 96761 96775 96791
; 96800 96801 96811 96816 96825 96831 96836 96875 96876 96896 96900 96921 96925
; 96936 96951 96975 96976 96996 97000 97025 97031 97041 97051 97056 97061 97071
; 97075 97096 97100 97116 97125 97136 97141 97175 97176 97200 97211 97216 97225
; 97236 97251 97271 97275 97276 97281 97296 97300 97325 97336 97341 97356 97361
; 97371 97375 97376 97396 97400 97416 97425 97431 97461 97471 97475 97476 97500
; 97525 97536 97575 97581 97596 97600 97601 97621 97625 97641 97656 97661 97671
; 97675 97681 97691 97696 97700 97716 97725 97736 97775 97776 97791 97796 97800
; 97801 97825 97831 97836 97856 97875 97881 97896 97900 97911 97916 97921 97925
; 97956 97971 97975 97991 98000 98016 98021 98025 98031 98051 98056 98071 98075
; 98076 98091 98100 98125 98131 98136 98141 98156 98175 98176 98196 98200 98225
; 98241 98256 98271 98275 98300 98301 98316 98325 98336 98351 98371 98375 98376
; 98381 98400 98425 98436 98441 98461 98475 98481 98496 98500 98511 98525 98536
; 98556 98571 98575 98600 98611 98616 98625 98631 98656 98675 98676 98681 98691
; 98696 98700 98716 98721 98725 98736 98761 98775 98791 98796 98800 98816 98825
; 98841 98851 98856 98875 98881 98896 98900 98901 98916 98921 98925 98931 98936
; 98956 98975 98976 98991 99000 99011 99025 99036 99051 99075 99081 99096 99100
; 99121 99125 99136 99141 99156 99175 99176 99200 99216 99225 99231 99256 99261
; 99275 99276 99281 99296 99300 99325 99336 99341 99351 99375 99381 99396 99400
; 99416 99425 99441 99451 99456 99471 99475 99476 99491 99500 99501 99511 99516
; 99525 99541 99561 99575 99576 99600 99616 99625 99631 99636 99671 99675 99691
; 99696 99700 99711 99725 99731 99736 99756 99771 99775 99776 99781 99800 99811
; 99816 99825 99831 99851 99856 99875 99876 99891 99900 99925 99936 99975 99981
; 99996 100000)

