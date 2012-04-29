
##=============================================================================
## INITIALIZE
##=============================================================================

source('000 Initialize Script.R')

##=============================================================================
## LOAD DATA
##=============================================================================
list.files()

td = loader("TrainingData")
szeros = loader("SubmissionZeros")


colnames(td) = gsub('position_within_chunk', 'pos', colnames(td))
colnames(td) = gsub('month_most_common', 'month', colnames(td))

noaa = loader('noaa')


##=============================================================================
## ANALYSIS START
##=============================================================================

colnames(szeros)

str(td)
# wtt(td)
table(td$chunkID)

colnames(tempmax)
tab = aggregate(tempmax$x, list(tempmax$month), mean, na.rm=TRUE)
tab
# clipper(tab)

tab = aggregate(tempmin$x, list(tempmin$month), mean, na.rm=TRUE)
tab
# clipper(tab)

colnames(td)

meanMaxTemp = apply(td[ , grep('Max\\.Temperature', colnames(td))], 1, mean, na.rm=TRUE)
names(meanMaxTemp) = td$month
ii = is.na(meanMaxTemp)
meanMaxTemp[ii] = noaa$max[match(names(meanMaxTemp[ii]), noaa$month)]

meanMinTemp = apply(td[ , grep('Min\\.Temperature', colnames(td))], 1, mean, na.rm=TRUE)
names(meanMinTemp) = td$month
ii = is.na(meanMinTemp)
meanMinTemp[ii] = noaa$min[match(names(meanMinTemp[ii]), noaa$month)]

colnames(td)
meaWindDir = apply(td[ , grep('WindDirection', colnames(td))], 1, mean, na.rm=TRUE)
table(round(meaWindDir), useNA='always')
ii = is.nan(meaWindDir)
meaWindDir[ii] = NA

colnames(td)
meaWindSpeed = apply(td[ , grep('WindSpeed', colnames(td))], 1, mean, na.rm=TRUE)
table(round(meaWindSpeed), useNA='always')
ii = is.nan(meaWindSpeed)
meaWindSpeed[ii] = NA


lll()
str(szeros)

colnames(td)

gmmax = gam(meanMaxTemp ~ s(pos, chunkID) + s(month), data=td)
summary(gmmax)
plot(gmmax, pages=1)
gmmin = gam(meanMinTemp ~ s(pos, chunkID) + s(month), data=td)
summary(gmmin)
plot(gmmin, pages=1)


aggregate(meaWindDir, list(td$month), mean, na.rm=TRUE)
boxplot(meaWindDir~ factor(td$month))

# qplot(factor(hour), meaWindDir, geom=c("boxplot"), 
# 	facets=.~month, data=td, outlier.size = .25)
# qplot(factor(hour), meaWindSpeed, geom=c("boxplot"), 
# 	facets=.~month, data=td, outlier.size = .25)

gmwinddir = gam(meaWindDir ~ s(month) + s(hour), data=td)
summary(gmwinddir)
plot(gmwinddir, pages=1)

# gmwindspeed = gam(meaWindSpeed ~ s(pos, chunkID) + s(month) + 
# 	s(meaWindSpeed), data=td)
gmwindspeed = gam(meaWindSpeed ~ s(month) + s(hour), data=td)
summary(gmwindspeed)
plot(gmwindspeed, pages=1)


jjtgt = grep('target_', colnames(td))

save.image('ModelWorkspace.RData')
load('ModelWorkspace.RData')

predictair = function(i){
# 	browser()
	dat = data.frame(
		y = td[,jjtgt[i]],
		chunkID = td$chunkID,
		pos = td$pos,
		month = td$month,
		hour = td$hour)
	dat$meanWindDir = unname(predict.gam(gmwinddir, dat))
	dat$meanWindSpeed = unname(predict.gam(gmwindspeed, dat))
	dat$maxtemp = unname(predict.gam(gmmax, dat))
	dat$mintemp = unname(predict.gam(gmmin, dat))
	str(dat)
	
	gm = gam(y~s(maxtemp,mintemp,chunkID)+s(meanWindDir, meanWindSpeed)+
		s(hour,chunkID,pos), data=dat)
	print(summary(gm))
# 	plot(gm)
	
	datPred = szeros[,1:5]
	colnames(datPred) = gsub('position_within_chunk','pos',colnames(datPred))
	colnames(datPred) = gsub('month_most_common','month',colnames(datPred))
	
	datPred$meanWindDir = unname(predict.gam(gmwinddir, datPred))
	datPred$meanWindSpeed = unname(predict.gam(gmwindspeed, datPred))
	datPred$maxtemp = unname(predict.gam(gmmax, datPred))
	datPred$mintemp = unname(predict.gam(gmmin, datPred))
	
	
	yhat = predict.gam(gm, datPred)
	print(i)
	return(yhat)
}
tmpGWL = sapply(1:20, predictair)
save(tmpGWL, file='tmpGWL.RData')


