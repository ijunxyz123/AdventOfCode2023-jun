BEGIN {

}

# Input Loop
{
    if ($1=="Time:") {
        for (i=2;i<=NF;i++) { 
            TIME[1]=TIME[1] $i
        }
    }
    if ($1=="Distance:") {
        for (i=2;i<=NF;i++) { 
            DISTANCE[1]=DISTANCE[1] $i
        }
    }
}

END {
    print "INPUT TIME " TIME[1] " DISTANCE " DISTANCE[1]
    #### SEARCH FOR THE LOWER BOUND
    # Start at the midpoint 
    TP=int(TIME[1]/2)
    BOT=1
    TOP=TIME[1]
    Finished=0
    for (;Finished==0;) {
        TA=Test(TIME[1],DISTANCE[1],TP)
        TB=Test(TIME[1],DISTANCE[1],TP+1)
        print "CURRENT TOP " TOP " BOT " BOT " TP " TP " TA and TB " TA " " TB
        # Got It
        if ((TA==0)&&(TB==1)) {
            Finished=1
            TP=TP+1
            print "--->Lower Bound Is " TP
            LowerBound=TP
        }
        # The Number Is Lower
        if ((TA==1)&&(TB==1)) {
            TOP=TP
            TP=int((TOP-BOT)/2)+BOT
            print "--->Adjusting TOP " TOP " TP " TP
        }
        # The Number Is Higher 
        if ((TA==0)&&(TB==0)) {
            BOT=TP
            TP=int((TOP-BOT)/2)+BOT
            print "--->Adjusting BOT " BOT " TP " TP
        }
    }
    #### SEARCH FOR THE UPPER BOUND
    # Start at the midpoint 
    TP=int(TIME[1]/2)
    BOT=1
    TOP=TIME[1]
    Finished=0
    for (;Finished==0;) {
        TA=Test(TIME[1],DISTANCE[1],TP)
        TB=Test(TIME[1],DISTANCE[1],TP+1)
        print "CURRENT TOP " TOP " BOT " BOT " TP " TP " TA and TB " TA " " TB
        # Got It
        if ((TA==1)&&(TB==0)) {
            Finished=1
            TP=TP
            print "--->Upper Bound Is " TP
            UpperBound=TP
        }
        # The Number Is Higher 
        if ((TA==1)&&(TB==1)) {
            BOT=TP
            TP=int((TOP-BOT)/2)+BOT
            print "--->Adjusting BOT " BOT " TP " TP
        }
        # The Number Is Lower 
        if ((TA==0)&&(TB==0)) {
            TOP=TP
            TP=int((TOP-BOT)/2)+BOT
            print "--->Adjusting TOP " TOP " TP " TP
        }
    }
    print "ANSWER " UpperBound-LowerBound+1 
}

function Test(ta,tb,tc) {
    # ta - Total race time
    # tb - Total race distance
    # tc - Test this hold time
    # td - Speed
    td=tc
    # te - Distance Traveled
    te=(ta-tc)*td
    # Debug
    # print ta,tb,tc,td,te
    # Did we exceed the distance?
    if ((te-tb)>0) {
        #print "Return 1"
        return 1
    }
    #print "Return 0"
    return 0
}