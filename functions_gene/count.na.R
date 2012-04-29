count.na=function(x){
	length(x[is.na(x)])
}

count.TRUE=function(x){
	length(x[x])
}

count.FALSE=function(x){
	length(x[!x])
}



