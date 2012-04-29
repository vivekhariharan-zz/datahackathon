## Updated version of lll
## 	- Simpler version of "ll" from the gdata package
##		- basic functionality of original ll: List objects and include 
##			some object information
##		- ll had several options, including environment specification, sort,
##			invert, etc...
##	- lll only lists objects in the global environment (pos=1)
##	- lll always includes dimensions
##	- This is a complete rewrite of lll that removes ll dependency
##
## Date: 2/6/12
## Author: Gene
###############################################################################

lll = function(sortBy=c('name', 'class', 'size')[1], digits = 0) {
	
	## DEFINE FUNCTION TO RETREIVE OBJECT CLASS
	objClass = function(object.name, pos) {
		object = get(object.name, pos = pos)
		class = class(object)[1]
		return(class)
	}
	
	## DEFINE FUNCTION TO RETREIVE OBJECT DIMENSION
	objDim = function(object.name, pos) {
		obj = get(object.name, pos = pos)
		objdim = paste(dim(obj),collapse=' x ')
		if(objdim == ''){
			objdim = length(obj)
		}
		return(objdim)
	}
	
	## DEFINE FUNCTION TO RETREIVE OBJECT SIZE
	objSize = function(objName, pos) {
		obj = get(objName, pos = pos)
		size = try(unclass(object.size(obj)), silent = TRUE)
		if (class(size) == "try-error") {
			size = 0
		}
		return(size)
	}
	
	## DEFINE ENVIRONMENT POSITION, ALWAYS USING POSTION 1
	pos = 1
	
	## GET OBJECTS
	items = ls(pos)
	
	## ATTACH ATTRIBUTES TO OBJECT
	if (length(items) == 0) {
		## If there are no objects, return empty data frame
		ret = data.frame()
	} else {
		## Otherwise, attach attributes using functions above
		ret = data.frame(
				Class = sapply(items, objClass, pos = pos), 
				KB = round(sapply(items, objSize, pos = pos)/1024, digits),
				Dims = sapply(items, objDim, pos = pos))
		## If there are no objects, return empty data frame
		row.names(ret) = items
		## Remove any functions
		ret = ret[ret$Class != 'function', ]
	}
	
	## Clean up output if when only functions existed
	if(nrow(ret)==0){
		ret = data.frame()
	}

	## Sort by option:
	ret = switch(sortBy,
			name = ret,
			class = ret[order(ret$Class), ],
			size = ret[rev(order(ret$KB)), ])
	
	return(ret)
}


if(FALSE){
	## SET WORKING DIRECTORY BEFORE RUNNING ANY TESTS
	setwd('C:/Eclipse_workspace/Home')
}

if(FALSE){
	## TEST 1
	## Basic function test
	## **Warning**
	## This test deletes the global workspace
	
	x = matrix(rnorm(1e3),5)
	y = matrix(rpois(1e3,3),5)
	xx = matrix(rnorm(4e4),8)
	myList=list(x,xx)
	xmyList=list(x,xx, x, x)
	ymyList=list(x,xx, y, y)
	
	source('lll.R')
	lll()
	lll('name')
	lll('class')
	lll('size')
}

if(FALSE){
	## TEST 2
	## Does the function if there are only functions
	## **Warning**
	## This test deletes the global workspace
	
	rm(list=ls())	
	source('lll.R')
	lll()
}

if(FALSE){
	## TEST 3
	## Does the function if there is nothing
	## **Warning**
	## This test deletes the global workspace
	## **Warning**
	## This test modifies the "Autoloads" environment
	
	## Is ll already defined?
	sapply(search(), function(x) {'lll' %in% ls(x)} )
	## Delete lll from Autoloads if necessary
	if('lll' %in% ls('Autoloads')){
		rm('lll', pos='Autoloads')
		sapply(search(), function(x) {'lll' %in% ls(x)} )
	}
	
	source('lll.R')
	assign('lll', lll, pos='Autoloads')
	rm(list=ls())
	lll()
	
	## Now delete lll from autoloads
	rm('lll', pos='Autoloads')
	
}

## OLD VERSION:
## Function to list data frames and matricies 
## 
## Author: gene.leynes
################################################################################
#
#lll=function(showall=FALSE){
#	require(gdata)
#	if(showall==TRUE){
#		ll(dim=TRUE)[order(ll(dim=TRUE)$Class),]
#	}else{
#		ii=order(ll(dim=TRUE)[ll(dim=TRUE)$Class != 'function',]$Class)
#		ll(dim=TRUE)[ll(dim=TRUE)$Class != 'function',][ii,]
#	}
#}
#

