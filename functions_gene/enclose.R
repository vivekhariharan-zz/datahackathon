# Little function to enclose a bunch of stuff in 'c()' format
# 6/25/2009
# Author: gene.leynes 20090625
###############################################################################


enclose=function(x){
	step1=paste(x,collapse='\', \'')
	step2=paste('c(\'',step1,'\')',sep='')
	return(step2)
}

#enclose(etflist)



