#~ YahooAdjCloseAsZoo=function(x,freq='monthly',begin='2000-01-01'){
	#~ require(fImport)
	#~ tsObject=yahooImport(x, frequency=freq, from=begin, to=Sys.timeDate()) 
	#~ val=zoo(tsObject@data$Adj.Close, as.Date(rownames(tsObject@data)))
	#~ if(freq=='monthly'){
		#~ # CHANGE TO MONTHLY TIME STEPS
		#~ newdates=as.yearmon(time(val))
		#~ newdates=as.Date(newdates, frac = 1)
		#~ values=as.vector(val)
		#~ val=zoo(values,newdates)
	#~ }
	#~ return(val)
#~ }




YahooAdjCloseAsZoo=function(x,freq='monthly',begin='2000-01-01',end=Sys.timeDate(),debug=FALSE){
	require(fImport)
	if(debug)browser()
	#----------------------------------------------------------------------
	# DEFINE internal DOWNLOAD FUNCTION
	#----------------------------------------------------------------------
	YahooAdjCloseAsZoo.internal=function(x,freq.internal=freq,
				begin.internal=begin,end.internal=end){
		
		tsObject=yahooImport(x, frequency=freq.internal, from=begin.internal, 
				to=end.internal) 
		val=zoo(tsObject@data$Adj.Close, as.Date(rownames(tsObject@data)))
		if(freq=='monthly'){
			# CHANGE TO MONTHLY TIME STEPS
			newdates=as.yearmon(time(val))
			newdates=as.Date(newdates, frac = 1)
			values=as.vector(val)
			val=zoo(values,newdates)
		}
		return(val)
	}
	#----------------------------------------------------------------------
	# MAIN
	#----------------------------------------------------------------------
	if(length(x)>1) {
		temp=list()
		for (i in 1:length(x))
			temp[[i]]=YahooAdjCloseAsZoo.internal(x[i])
		names(temp)=x
		ret=do.call("merge.zoo", temp)
		return(ret)
	}else{
		return(YahooAdjCloseAsZoo.internal(x))
	}
}


if(FALSE){
	YahooAdjCloseAsZoo(c('PG','JNJ'),freq='daily',begin='2010-01-01')
	YahooAdjCloseAsZoo(c('PG','JNJ','AIG'),freq='daily',begin='2009-01-01',end='2009-01-31')
	YahooAdjCloseAsZoo(c('AIG','JNJ','GM'),freq='monthly',begin='2008-01-01',end='2008-12-31')

	YahooAdjCloseAsZoo(c('AIG','JNJ','GM'),freq='daily',begin='2009-01-01',end='2009-07-31')
	YahooAdjCloseAsZoo(c('AIG','JNJ','GM'),freq='daily',begin='2009-05-01',end='2009-07-31')

	x=YahooAdjCloseAsZoo(c('AIG','JNJ','GM'),freq='monthly',begin='2008-01-01',end='2009-08-31')
	x=YahooAdjCloseAsZoo(c('AIG','JNJ','GOOG'),freq='monthly',begin='2008-01-01',end='2009-08-31')
	x
	plot(x,screens=1,lty=c(1,2,3))
	legend("topright", names(x), lty=1:3, title="stocks")

	plot(cumsum(diff(log(x))),screens=1,lty=c(1,2,3))
	legend("bottomleft", names(x), lty=1:3, title="stocks")



	indTickers=c('^FTSE', '^IXIC', '^NDX', '^GSPC', '^DJI', '^OEX', 
			'^TYX', '^N225', '^HSI', '^SPSUPX', '^SML', 
			'^DWC', '^RUT', '^RUI', '^RUA', '^TNX', '^IRX', 
			'^TYX', '^FVX')
	x=YahooAdjCloseAsZoo(indTickers,freq='monthly',begin='2009-01-01',end='2009-12-31')
	x

	plot(cumsum(diff(log(x))),screens=1,lty=1:ncol(x))
	legend("bottomleft", names(x), lty=1:ncol(x), title="stocks")

	x=x[,-17]
	plot(cumsum(diff(log(x))),screens=1,lty=1:ncol(x))
	legend("bottomleft", names(x), lty=1:ncol(x), title="stocks")


	x=YahooAdjCloseAsZoo(indTickers,freq='monthly',begin='2008-01-01',end='2008-12-31')
	x

	plot(cumsum(diff(log(x))),screens=1,lty=1:ncol(x))
	legend("bottomleft", names(x), lty=1:ncol(x), title="stocks")

	x=x[,-17]
	plot(cumsum(diff(log(x))),screens=1,lty=1:ncol(x))
	legend("bottomleft", names(x), lty=1:ncol(x), title="stocks")


}
