{
	WorkString=$0
	gsub("[0-9.]","",WorkString);
	for (i=1;i<=length(WorkString);i++) {
		Char=substr(WorkString,1,1);
		ARRAY[Char]=1
	}
}

END {
	for (x in ARRAY) print x
}
