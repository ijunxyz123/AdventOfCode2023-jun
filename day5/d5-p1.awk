BEGIN {
    # Are we in a map? 
    InAMap=0
    # Map number?
    MapNumber=0

    M["seed-to-soil"]=1
    M["soil-to-fertilizer"]=2
    M["fertilizer-to-water"]=3
    M["water-to-light"]=4
    M["light-to-temperature"]=5
    M["temperature-to-humidity"]=6
    M["humidity-to-location"]=7

}

# Process the seed input
/^seeds:/ {
    for (i=2;i<=NF;i++) {
        SEEDLIST[$i]=1
    }
}

# End Of A Map
/^$/ {
    print "MAP END"
    InAMap=0
    MapNumber=0
}

# Map 
/^[a-z-]* map:/ {
    print "MAP '" $1 "' '" M[$1] "'"
    # InAMap is used as the row inside the map
    InAMap=1
    MapNumber=M[$1]
}

# Main Input Loop
{
    print NR " '" $0 "'";
    if ( InAMap>0 ) {
        if ( index($0,"map:")==0 ) {
            # InAMap is used as the row inside the map
            MAP[ MapNumber "|" InAMap "|DRS" ]=$1
            MAP[ MapNumber "|" InAMap "|SRS" ]=$2
            MAP[ MapNumber "|" InAMap "|RL" ]=$3
            MAP[ MapNumber "|ROWS" ]=InAMap
            InAMap++
        } else {
            # This is the header line, ignore it.
        }
    }
}

END {
    if (1) {
        printf("SEEDLIST: ")
        for (i in SEEDLIST) {
            printf("%s,",i)
        }
        print "EOL"
    }
    if (1) {
        for (i=1;i<=7;i++) {
            for (j=1;j<=MAP[ i "|ROWS" ]; j++) {
                print "MAP '" i "' ROW '" j "' DRS '" MAP[ i "|" j "|DRS" ] "' SRS '" MAP[ i "|" j "|SRS" ] "' RL '" MAP[ i "|" j "|RL" ] "'"
            }
        }
    }
}


