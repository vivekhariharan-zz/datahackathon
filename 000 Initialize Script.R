

##=============================================================================
## INITIALIZE
##=============================================================================




rm(list=ls())

## SOURCE ALL THE FILES IN ANY FOLDER STARTING WITH THE WORD "FUNCTION"
local({
	ProjFunFolders = dir(pattern='[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]')
	ProjFuns = list.files(ProjFunFolders, pattern='\\.[rR]$', full.names=TRUE)
	## Load functions
	for(tmp in ProjFuns) source(tmp)	
})

# installedpackages = row.names(installed.packages())
library(mgcv)
library(reshape)
library(plyr)
library(ggplot2)
library(TeachingDemos)

