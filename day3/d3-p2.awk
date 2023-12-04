BEGIN {
    # X - Left to Right
    # Y - Top to Bottom
    TestString="*"
}

{
    # X is i, Y is NR
    for (x=1;x<=length($0);x++) {
        GRID[ x "-" NR ]=substr($0,x,1)
    }
    if ( MaxLength<length($0) ) {
        MaxLength=length($0)
    }
    MaxRow=NR
}

# Looks for nothing but gears and returns a list of gears found
function SymbolTest(x,y,    stx,sty) {
    rc=""
    for (stx=x-1;stx<=x+1;stx++) {
        for (sty=y-1;sty<=y+1;sty++) {
            if ( GRID[stx "-" sty]!="" ) {
                if ( index(TestString,GRID[stx "-" sty])>0 ) {
                    print "ST " stx " " sty " " GRID[stx "-" sty]
                    rc=rc "|"stx"-"sty"|"
                }
            }
        }
    }
    return rc 
}

END {
    CurrentNumber=""
    GearList=""
    for (y=1;y<=MaxRow;y++) {
        print "ROW " y 
        for (x=1;x<=MaxLength+1;x++) {
            print "COL " x 
            CurrentCell=GRID[x "-" y]
            print "CC " CurrentCell
            if ( (CurrentCell ~ /[0-9]/) ) {
                CurrentNumber=CurrentNumber CurrentCell
                print "BEFORE CN " CurrentNumber " GL " GearList 
                GearList=GearList SymbolTest(x,y)
                print "AFTER CN " CurrentNumber " GL " GearList 
            } else {
                if (CurrentNumber!="") {
                    print "FINISHED CN " CurrentNumber " GL " GearList 
                    HowMany=split(GearList,X,"|")
                    for (i=1;i<=HowMany;i++) {
                        TestString2="|" CurrentNumber "~"
                        if (X[i]!="") {
                            if ( index(ADJ[X[i]],TestString2)==0) {
                                ADJ[X[i]]=ADJ[X[i]] TestString2
                            }
                        }
                    }
                    CurrentNumber=""
                    GearList="" 
                }
            }
        }
    }
    for (x in ADJ) {
        TTT=ADJ[x]
        print TTT
        gsub("[|]","",TTT)
        print TTT
        NumSplit=split(TTT,UUU,"~")
        print x,ADJ[x],TTT,NumSplit
        if ( NumSplit==3 ) {
            print "HIT HIT HIT",x,ADJ[x],UUU[1]*UUU[2]
            Total=Total+UUU[1]*UUU[2]
        } 
    }
    print Total
}