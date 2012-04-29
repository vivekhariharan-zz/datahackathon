###############################################################################
# Function to return a data frame summary of the NA statistics
# 
# Author: gene.leynes
###############################################################################

#NAsummaryold = function(df){
#	newdf = data.frame(col=1:ncol(df))
#	rownames(newdf) = colnames(df)
#	newdf = cbind(newdf,'Count'=0)
#	newdf = cbind(newdf,'nNA'=0)
#	newdf = cbind(newdf,'rNA'=0)
#	newdf = cbind(newdf,'nUnique'=0)
#	newdf = cbind(newdf,'rUnique'=0)
#	
#	newdf$Count =nrow(df)
#	newdf$nNA = nrow(df) - sapply(sapply(df,na.omit),length)
#	newdf$rNA = newdf$nNA / newdf$Count
#	newdf$rNA = trunc(newdf$rNA*10000)/10000
#	# (nested SAPPLY :)
#	newdf$nUnique = sapply(sapply(df[,1:ncol(df)],unique),length) 
#	newdf$rUnique = newdf$nUnique / newdf$Count
#	newdf$rUnique = trunc(newdf$rUnique*10000)/10000
#	
#	return(newdf)
#	}

#NAsummary(equityuniverse)
#for (i in 1:13) print(CreateNAsummary(data[[i]]))

#system.time({sumold = NAsummaryold(stockdata)})
#system.time({sumnew = NAsummary(stockdata)})
#all.equal(sumold,sumnew)


#
#NAsummary = function(df){
#	newdf = data.frame(
#			col=1:ncol(df),
#			Count =nrow(df),
#			nNA = sapply(df,function(x)length(x[is.na(x)]))
#	)
#	
#	newdf$rNA = newdf$nNA / newdf$Count
#	newdf$rNA = trunc(newdf$rNA*10000)/10000
#	
#	newdf$nUnique = sapply(df,function(x)length(unique(x))) 
#	
#	newdf$rUnique = newdf$nUnique / newdf$Count
#	newdf$rUnique = trunc(newdf$rUnique*10000)/10000
#	
#	rownames(newdf) = colnames(df)
#	return(newdf)
#}


NAsummary = function(df, include.nan=FALSE){
	newdf = data.frame(
			col=1:ncol(df),
			Count =nrow(df),
			nNA = sapply(df,function(x)length(x[is.na(x)]))
	)
	
	newdf$rNA = newdf$nNA / newdf$Count
	newdf$rNA = trunc(newdf$rNA*10000)/10000
	
	if(include.nan){
		newdf$nNan = sapply(df,function(x)length(x[is.nan(x)]))
		newdf$rNan = newdf$nNan / newdf$Count
		newdf$rNan = trunc(newdf$rNan*10000)/10000
	}
	
	newdf$nUnique = sapply(df,function(x)length(unique(x))) 
	
	newdf$rUnique = newdf$nUnique / newdf$Count
	newdf$rUnique = trunc(newdf$rUnique*10000)/10000
	
	rownames(newdf) = colnames(df)
	return(newdf)
}

