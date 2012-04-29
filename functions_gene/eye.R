# 2010-02-15
# Identity matrix generator
# Author: gene.leynes
###############################################################################

eye=function(x){
	ret=matrix(0,x,x)
	diag(ret)=1
	return(ret)
}


