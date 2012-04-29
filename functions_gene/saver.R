# TODO: Add comment
# Original save date: 8/13/09
# modified 2010-02-10 to add 'override'
# Modified on 12/16/09 to add debug option (and troubleshoot)
# Author: gene.leynes
###############################################################################


saver=function(x, override=FALSE, debug=FALSE){
	if(debug)browser()
	fname=paste('Output/',x,'.RData',sep='')
	if(file.exists(fname) & !override){
		warning('A file already exists in ',fname,'\n')
		#cat('A file already exists in ',fname,'\n')
	}else{
		if(as.name(x)=='x'){
			rm(x)
			save(x,file=fname)
		}else{
			eval(substitute(
							save(variable,file=fname),
							list(variable = as.name(x))
					))
		}
	}
}

#test=1:10
#saver('test')
#loader('test')
#saver('x')
#loader('x')
#Q

#save(test,file='Data/test.RData')

#rm(list=ls())
#load('Data/test.RData')
#ls()
#test









