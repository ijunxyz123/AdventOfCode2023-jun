{
    for (i=1;i<=NF;i++) {
        if ( $i == "|" ) {
            bar=i
        }
    }
    score=-1
    for (i=bar+1;i<=NF;i++) {
        for (j=3;j<=bar-1;j++) {
            if ( $i == $j ) {
                score++
            }
        }
    }
    if (score==-1) {
        print $1 " " $2 " 0"
    } else {
        print $1 " " $2 " " 2**score
        total=total+2**score
    }
}

END {
    print total
}