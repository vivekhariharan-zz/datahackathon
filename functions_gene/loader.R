# Loader Function to give finer control over loading variables
# 
# Author: gene.leynes
###############################################################################

# MODIFIED ON 20100503
#  Added debug option
#  Added 'dirname'

#loader=function(x, dirname='Output', debug=FALSE){
#	if(debug) browser()
#	path=paste(dirname, '/', x,'.RData',sep='')
#	rm(debug, dirname)
#	
#	if(as.name(x)=='x') {
#		load(path)
#		rm(path)
#		return(x)
#	}else{
#		load(path)
#		rm(x,path)
#		x=ls()[1]
#		return(eval(substitute(variable,
#								list(variable = as.name(x))	)))
#	} 
#	#	load(paste('Data/',x,'.RData',sep=''),env=,.GlobalEnv)
#}



## Modified on 20110518
##   Added check to see if variable ends in .RData
##   Changed "dirname" to xPath
##   Removed "debug"
##   Changed the default path to '.'

loader=function(x, xPath='.'){
	## Check if x already has ".RData" at the end
	if(length(grep('\\.[Rr][Dd]ata$', x))==0){
		x=paste(x,'.RData',sep='')
	}
	## Check if x already has ".RData" at the end
	xWithPath=file.path(xPath, x)
	rm(xPath)
	
	if(as.name(x)=='x') {
		load(xWithPath)
		rm(xWithPath)
		return(x)
	}else{
		load(xWithPath)
		rm(x,xWithPath)
		NewVar=ls()[1]
		return(eval(substitute(variable,
				list(variable = as.name(NewVar))	
		)))
	} 
	#	load(paste('Data/',x,'.RData',sep=''),env=,.GlobalEnv)
}


