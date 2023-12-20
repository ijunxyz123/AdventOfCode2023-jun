BEGIN {
    for(i=2;i<=14;i++) {
        Card=i
        if (i==10) Card="T" 
        if (i==11) Card="J"
        if (i==12) Card="Q"
        if (i==13) Card="K"
        if (i==14) Card="A"

        CARD[Card]=i
        # Not sure I'm going to actually use this
        STRENGTH[Card]=2^(i-2)

        # print i,Card,CARD[Card],STRENGTH[Card]
    }
}

{
    Hand=$1
    Bet=$2
    HandA=""
    delete COUNT
    # Hand is the actual text hand in original order
    # HandA is it converted to numbers (original order)
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
    # Three of a kind?
    ThreeFlag=0
    # Number of pairs?
    TwoFlag=0
    # Type of hand
    Type=0
    for (i in COUNT) {
        # Found a three
        if (COUNT[i]==3) {
            ThreeFlag=1
        }
        # Found a two 
        if (COUNT[i]==2) {
            TwoFlag++
        }
        # 5
        if (COUNT[i]==5) {
            what="5 of a kind"
            Type=7
        }
        # 4
        if (COUNT[i]==4) {
            what="4 of a kind"
            Type=6
        }
    }
    # This code tests for Full House (3+2) and three of a kind (3+1+1)
    if ( ThreeFlag ) {
        if ( TwoFlag ) {
            what="Full house"
            Type=5
        } else {
            what="Three of a kind"
            Type=4
        }
    # Invoked when the only options left involve pairs
    } else {
        if ( TwoFlag==2 ) {
            what="Two Pair"
            Type=3
        }
        if ( TwoFlag==1 ) {
            what="One Pair"
            Type=2
        }
        if ( TwoFlag==0 ) {
            what="High Card"
            Type=1
        }
    }

    HAND[NR]=HandA "," Type "," Hand "," Bet "," NR "," what

    # print $1,HandA,Type

}

END {
    # Sort by hand type
    SortFinished=0
    for (; SortFinished==0 ;) {
        SortFinished=1
        for (i=1;i<NR;i++) {
            print i,"TEST",HAND[i],HAND[i+1]
            split(HAND[i],WOW,",")
            split(HAND[i+1],ZER,",")
            if ( WOW[6]>ZER[6]) {
                SortFinished=0
                TA=HAND[i]
                TB=HAND[i+1]
                HAND[i]=TB
                HAND[i+1]=TA
                print "SWAP"
            }
        }
    }
    for (i=1;i<=NR;i++) {
        print i " " HAND[i] 
    }

    function SortThing(sta) {
        
    }

}