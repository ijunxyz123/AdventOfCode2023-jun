BEGIN {
	A[1]="one"
	A[2]="two"
	A[3]="three"
	A[4]="four"
	A[5]="five"
	A[6]="six"
	A[7]="seven"
	A[8]="eight"
	A[9]="nine"
}

{
	work=$0
	nums=""
	first=0
	last=0

	for (i=1;i<=length(work);i++) {

		b=substr(work,i)
		c=substr(work,i,1)

		if ( int(c)==0 ) {
			for (j=1;j<=9;j++) {
				if ( index(b,A[j])==1 ) {
					nums=nums j
				}
			}
		} else {
			nums=nums c
		}
	}

	first=substr(nums,1,1)
	last=substr(nums,length(nums),1)

	total=total+first*10+last             
	print NR,work,nums,first*10+last,total
}
