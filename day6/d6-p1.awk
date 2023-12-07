BEGIN {

}

# Input Loop
{
    if ($1=="Time:") {
        for (i=2;i<=NF;i++) { 
            TIME[i-1]=$i
        }
    }
    if ($1=="Distance:") {
        for (i=2;i<=NF;i++) { 
            DISTANCE[i-1]=$i
        }
    }

}

END {
    for (i in TIME) {
        Combos=0
        for (j=1;j<TIME[i];j++) {
            results=Test(TIME[i],DISTANCE[i],j)
            print i " TIME " TIME[i] " DISTANCE " DISTANCE[i] " TEST " j " WIN " results
            if (results==1) {
                Combos++
            } 
        }
        print i " Combos " Combos
        if ( Final==0 ) {
            Final=Combos
        } else {
            Final=Final*Combos
        }
    }
    print "ANSWER " Final
}

function Test(ta,tb,tc) {
    # ta - Total race time
    # tb - Total race distance
    # tc - Test this hold time
    # td - Speed
    td=tc
    # te - Distance Traveled
    te=(ta-tc)*td
    # Did we exceed the distance?
    if (te>tb) return 1
    return 0
}