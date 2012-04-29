
##=============================================================================
## INITIALIZE
##=============================================================================

source('000 Initialize Script.R')

##=============================================================================
## LOAD DATA
##=============================================================================
list.files()

td = loader("TrainingData")
sitelocs = loader('sitelocs')
# 
# getloc = function(loc, dat){
# 	jj = grep(loc, colnames(dat))
# 	ret = dat[ , jj]
# 	return(ret)
# }
# getloc()


tempmax = loader('tdl.tempmax.RData')
tempmin = loader('tdl.tempmin.RData')
baro = loader('tdl.baro.RData')
baromax = loader('tdl.baromax.RData')
baromin = loader('tdl.baromin.RData')
target = loader('tdl.target.RData')



##=============================================================================
## ANALYSIS START
##=============================================================================
sitelocs


# idcols = 1:6
# varcols = (1:ncol(td))[-idcols]


NAsummary(td)
colnames(tempmax)
# aggregate(ifelse(is.na(tempmax$x), 0, 1), list(tempmax$SITE_ID, tempmax$hour), mean)
table(tempmax$SITE_ID, tempmax$hour, is.na(tempmax$x))


colnames(tempmax)

# qplot(factor(month), x, geom=c("boxplot", "jitter"), 
# 	facets=.~SITE_ID, data=tempmax)
# qplot(factor(month), x, geom=c("boxplot", "jitter"), 
# 	facets=.~SITE_ID, data=tempmax, outlier.size = .25)

boxplot(x~month, data=tempmax)
# plot(x~month, data=tempmax)

str(target)
boxplot(x~TARGET_ID, data=target)
boxplot(x~SITE_ID, data=target)

tmp = split(tempmax, tempmax$SITE_ID)

# cols = topo.colors(length(tmp))
cols = 1:length(tmp)
i=1; boxplot(x~month, data=tmp[[i]], col=cols[i], 
		 ylim=range(tempmax$x, na.rm=TRUE))
i=2; boxplot(x~month, data=tmp[[i]], col=cols[i], add=TRUE)
i=3; boxplot(x~month, data=tmp[[i]], col=cols[i], add=TRUE)
i=4; boxplot(x~month, data=tmp[[i]], col=cols[i], add=TRUE)
i=5; boxplot(x~month, data=tmp[[i]], col=cols[i], add=TRUE)
i=6; boxplot(x~month, data=tmp[[i]], col=cols[i], add=TRUE)
i=7; boxplot(x~month, data=tmp[[i]], col=cols[i], add=TRUE)
i=8; boxplot(x~month, data=tmp[[i]], col=cols[i], add=TRUE)
i=9; boxplot(x~month, data=tmp[[i]], col=cols[i], add=TRUE)
rm(tmp, cols)





# varcolsites = as.numeric(gsub('.+\\_','',colnames(td)[-idcols]))
# 
# sitevarlocs = rbind(
# 	lat=sitelocs$LATITUDE[match(varcolsites, sitelocs$SITE_ID)],
# 	long=sitelocs$LONGITUDE[match(varcolsites, sitelocs$SITE_ID)])
# 
# cbind(t(sitevarlocs), colnames(td)[varcols])
# unique(varcolsites)



plot(LATITUDE ~ LONGITUDE, data=sitelocs)
tempmax$long = sitelocs$LONGITUDE[match(tempmax$SITE_ID, sitelocs$SITE_ID)]
tempmax$lat = sitelocs$LATITUDE[match(tempmax$SITE_ID, sitelocs$SITE_ID)]

colnames(tempmax)

tmp = tempmax[apply(tempmax[, c('x', 'pos', 'long', 'lat')], 1, function(x)!any(is.na(x))), ]
tmp = split(tmp, tmp$chunkID)
str(tmp)
gammax = gam(x~te(lat, long)+hour , data=tmp[[1]])
gammax = gam(x~s(lat) , data=tmp)
?gam
plot(gammax)


colnames(tempmax)
# gammax = gam(x~s(pos) , data=tempmax)
plot(gammax, pages=1)
# gammax = gam(x~s(hour)+as.factor(chunkID) , data=tempmax)
plot(gammax, pages=1)
gammax = gam(x~s(hour) , data=tempmax)
plot(gammax, pages=1)
1
# sptd = split(td, td$chunkID)
# str(sptd[[1]])
# wtt(sptd[[1]])
# wtt(sptd[[2]])
# wtt(sptd[[3]])


target_means_by_hour_of_day = ddply(td, "hour", 
						function(df) colMeans(df[,target_names], na.rm = TRUE))


target_means_by_hour_of_day = ddply(td, c("hour", "weekday"), 
						function(df) colMeans(df[,target_names], na.rm = TRUE))


dat = sptr[[1]]
plot(LATITUDE ~ LONGITUDE, data=sitelocs)
ms.arrows(angle, r=1, adj=0.5, length=0.1)


gam()




