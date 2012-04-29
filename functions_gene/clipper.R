
clipper = function(x)
	#write.table(x,"clipboard",sep="\t",col.names=NA)
	write.table(x,"clipboard",sep="\t",col.names=TRUE,row.names=FALSE)



# 12/21/09 - Added lowercase and removedot options to "clipped"
clipped = function(lowercase=TRUE,removedot=TRUE){
	x=read.delim("clipboard")
	if (lowercase)	colnames(x)=tolower(colnames(x))
	if (removedot)	colnames(x)=gsub('\\.','',colnames(x))
	return(x)
}



# Something that did work on the mac... 
# I think I do something else now, but I don't have the code here
clipper2 = function(x)
	writeClipboard(as.character(x),format=1)

