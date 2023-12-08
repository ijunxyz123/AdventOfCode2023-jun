BEGIN {
    for(i=2;i<=14;i++) {
        Card=i
        if (i==10) Card="T" 
        if (i==11) Card="J"
        if (i==12) Card="Q"
        if (i==13) Card="K"
        if (i==14) Card="A"

        CARD[Card]=i
        STRENGTH[Card]=2^(i-2)

        print i,Card,CARD[Card],STRENGTH[Card]
    }
}

{
    Hand=$1
    Bet=$2
    HandA=""
    delete COUNT
    for (i=1;i<=5;i++) {
        CC=substr(Hand,i,1)
        if (HandA=="") {
            HandA=CARD[CC] ","
        } else {
            if (i<=4) {
                HandA=HandA CARD[CC] ","
            } else {
                HandA=HandA CARD[CC]
            }
        }
        COUNT[CC]++
    }
    ThreeFlag=0
    TwoFlag=0
    for (i in COUNT) {
        if (COUNT[i]==3) {
            ThreeFlag=1
        }
        if (COUNT[i]==2) {
            TwoFlag++
        }
        if (COUNT[i]==5) {
            print "5 of  kind"
        }
        if (COUNT[i]==4) {
            print "4 of a kind"
        }
    }
    if ( ThreeFlag ) {
        if ( TwoFlag ) {
            print "Full house"
        } else {
            print "Three of a kind"
        }
    } else {
        if ( TwoFlag==2 ) {
            print "Two Pair"
        }
        if ( TwoFlag==1 ) {
            print "One Pair"
        }
    }

    print $1,HandA
}