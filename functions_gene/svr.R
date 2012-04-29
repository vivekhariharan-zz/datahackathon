# Changed saver and loader into svr and ldr
# so that the default save format is a text file
# Author: gene.leynes 5/5/2009
###############################################################################

svr = function(x){
	fname=paste('./Output/',x,'.txt',sep='')
	eval(substitute(
					write.table(variable,file=fname,
							sep='\t', quote=FALSE, na = "#N/A"),
					list(variable = as.name(x))
			))
}

ldr=function(x){
	path=paste('./Output/',x,'.txt',sep='')
	newobj = read.delim(path, header=TRUE, na.string="#N/A")
	rm(x,path)
	x=ls()[1]
	return(eval(substitute(variable,
							list(variable = as.name(x))	)))
	#	load(paste('Data/',x,'.RData',sep=''),env=,.GlobalEnv)
}










