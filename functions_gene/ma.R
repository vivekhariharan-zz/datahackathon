ma=function(dat,n=10){
	ret=sapply((plen+1):length(dat),function(x)
		mean(dat[(x-plen):x]))
	firstdiff=ret[2]-ret[1]
	lastdiff=ret[length(ret)]-ret[length(ret)-1]
	for(i in 1:(plen/2)) ret=c(ret[1]-firstdiff,ret)
	for(i in 1:(plen/2)) ret=c(ret,ret[length(ret)]+lastdiff)
	return(ret)
}
