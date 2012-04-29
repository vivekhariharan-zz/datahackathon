# VERY simple table function
# the original df tab actually did a little more
# 20091208 - added total and debug functionality
# 20091208 - changed useNA to 'ifany'
# 20091216 - made "sort" option
# 20091222 - will sort in order of appearance, if not sorted by value
# Author: gene.leynes
###############################################################################

dftab = function(x,total=TRUE,sort=TRUE,debug=FALSE) {
	if (debug) browser()
	df=table(x, useNA='ifany')
	if(sort) df=df[order(df)]
	if(!sort) df=df[unique(x)]
	names(df)[is.na(names(df))]='NA'
	df=data.frame(count=df)
	if (total) df=rbind(df,TOTAL=sum(df))
	return(df)
}


