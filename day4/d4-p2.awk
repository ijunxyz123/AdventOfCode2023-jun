{
    CARDCOUNT[NR]=1
    CARDCONTENT[NR]=$0
    MaxCards=NR
    print "Ingest " NR
}

END {
    for (i=1;i<=MaxCards;i++) {
        print "I " i " MC " MaxCards
        for (j=1;j<=CARDCOUNT[i];j++) {
            rc = CountWinners(i)
            for (k=1;k<=rc;k++) {
                print "INC " i+k 
                CARDCOUNT[i+k]++
            }
        }
    } 
    for (i=1;i<=MaxCards;i++) {
        print CARDCOUNT[i], CARDCONTENT[i]
        Total=CARDCOUNT[i] + Total
    }
    print Total
}

function CountWinners(cwa,  cwb,cwc,cwd,cwe,    cwi,cwj) {
    # cwa is the index to CARDCONTENT
    # What card are we working on?
    cwb=CARDCONTENT[cwa]
    delete ELEMENTS
    # cwc is the number of fields
    cwc=split(cwb,ELEMENTS," ")

    for (cwi=1;cwi<=cwc;cwi++) {
        if ( ELEMENTS[cwi] == "|" ) {
            # cwd is where the vertical bar is
            cwd=cwi
        }
    }

    # number of correct answers in cwe
    cwe=0
    for (cwi=cwd+1;cwi<=cwc;cwi++) {
        for (cwj=3;cwj<=cwd-1;cwj++) {
            if ( ELEMENTS[cwi] == ELEMENTS[cwj] ) {
                cwe++
            }
        }
    }

    return cwe
}