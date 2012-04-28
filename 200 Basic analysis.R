

##=============================================================================
## INITIALIZE
##=============================================================================

library(mgcv)
library(TeachingDemos)
library(reshape)
library(plyr)

source('loader.R')

rm(list=ls())


##=============================================================================
## LOAD DATA
##=============================================================================
list.files()

TrainingData = loader("TrainingData")
SubmissionZeros = loader("SubmissionZeros")
sitelocs = loader('sitelocs')


##=============================================================================
## ANALYSIS START
##=============================================================================
sitelocs
plot(LATITUDE ~ LONGITUDE, data=sitelocs)

ls()

str(TrainingData)

sptr = split(TrainingData, TrainingData$chunkID)
str(sptr[[1]])
# wtt(sptr[[1]])
wtt(sptr[[2]])


target_means_by_hour_of_day = ddply(TrainingData, "hour", 
		function(df) colMeans(df[,target_names], na.rm = TRUE))


target_means_by_hour_of_day = ddply(TrainingData, c("hour", "weekday"), 
						function(df) colMeans(df[,target_names], na.rm = TRUE))


dat = sptr[[1]]
plot(LATITUDE ~ LONGITUDE, data=sitelocs)
ms.arrows(angle, r=1, adj=0.5, length=0.1)


gam()





