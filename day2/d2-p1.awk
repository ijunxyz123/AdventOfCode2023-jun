{

    delete MAX

    GameNumber = $0
    gsub("^Game ","",GameNumber)
    gsub(":.*$","",GameNumber)
    print "Game Number is '" GameNumber "'"

    AllTurns=$0
    gsub("^.*:","",AllTurns)
    # print "  AllTurns is '" AllTurns "'"

    split(AllTurns,EachTurn,";")
    for (i in EachTurn) {
        split(EachTurn[i],EachPull,",")
        for (j in EachPull) {
            work=EachPull[j]
            gsub("^ ","",work)
            split(work,Atomic)
            if ( MAX[Atomic[2]]<Atomic[1]) {
                MAX[Atomic[2]]=Atomic[1] 
                print "Setting " Atomic[2] " to " MAX[Atomic[2]] 
            }
            print Atomic[1],Atomic[2]
        }
    }

    if ( MAX["red"]<=12) {
        if ( MAX["green"]<=13) {
            if (MAX["blue"]<=14) {
                output=output+GameNumber
            }
        }
    }

}

END {
    print output;
}