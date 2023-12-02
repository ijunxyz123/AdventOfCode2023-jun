{
	first=0
	last=0
	for (i=1;i<=length($0);i++) {
		c=substr($0,i,1)
		d=c
		gsub("[0-9]*","",d)
		if (d=="") {
			last=int(c)
			if (first==0) first=int(c)
		}
	}
	total=total+first*10+last             
	print NR,first*10+last,total
}
