BEGIN {
    # X - Left to Right
    # Y - Top to Bottom
    TestString="*+-/=#$%&@"
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

function SymbolTest(x,y,    stx,sty) {
    for (stx=x-1;stx<=x+1;stx++) {
        for (sty=y-1;sty<=y+1;sty++) {
            if ( GRID[stx "-" sty]!="" ) {
                if ( index(TestString,GRID[stx "-" sty])>0 ) {
                    print "ST " stx " " sty " " GRID[stx "-" sty]
                    return 1
                }
            }
        }
    }
    return 0
}

END {
    CurrentNumber=""
    PartNumber=0
    for (y=1;y<=MaxRow;y++) {
        print "ROW " y 
        for (x=1;x<=MaxLength+1;x++) {
            print "COL " x 
            CurrentCell=GRID[x "-" y]
            print "CC " CurrentCell
            if ( (CurrentCell ~ /[0-9]/) ) {
                CurrentNumber=CurrentNumber CurrentCell
                print "BEFORE CN " CurrentNumber " PN " PartNumber
                if (PartNumber==0) {
                    PartNumber=SymbolTest(x,y)
                }
                print "AFTER CN " CurrentNumber " PN " PartNumber
            } else {
                if (CurrentNumber!="") {
                    print "FINISHED CN " CurrentNumber " PN " PartNumber
                    if ( PartNumber!=0 ) Total=Total+CurrentNumber
                    CurrentNumber=""
                    PartNumber=0
                }
            }
        }
    }
    print Total
}