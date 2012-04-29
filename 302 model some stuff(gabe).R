
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
tmp = sapply(21:length(jjtgt), predictair)
save(tmp, file='tmp.RData')


