
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

##=============================================================================
## TRANSFORMATIONS
##=============================================================================


idcols = 1:6
varcols = (1:ncol(td))[-idcols]

td.tempmax = td[, c(idcols, grep('Ambient\\.Max\\.Temperature.+', colnames(td)))]
td.tempmin = td[, c(idcols, grep('Ambient\\.Min\\.Temperature.+', colnames(td)))]
td.baro = td[, c(idcols, grep('Sample\\.Baro\\.Pressure.+', colnames(td)))]
td.baromax = td[, c(idcols, grep('Sample\\.Max\\.Baro\\.Pressure.+', colnames(td)))]
td.baromin = td[, c(idcols, grep('Sample\\.Min\\.Baro\\.Pressure.+', colnames(td)))]
td.target = td[, c(idcols, grep('target.+', colnames(td)))]

str(td.tempmax)
str(td.tempmin)
str(td.baro)
str(td.baromax)
str(td.baromin)
str(td.target)

tdl.tempmax = reshape(td.tempmax, v.names="x", idvar='rowID', timevar='SITE_ID',
			    varying=list(7:15), direction='long')
tdl.tempmin = reshape(td.tempmin, v.names="x", idvar='rowID', timevar='SITE_ID',
			    varying=list(7:15), direction='long')
tdl.baro = reshape(td.baro, v.names="x", idvar='rowID', timevar='SITE_ID',
			 varying=list(7:15), direction='long')
tdl.baromax = reshape(td.baromax, v.names="x", idvar='rowID', timevar='SITE_ID',
			    varying=list(7:15), direction='long')
tdl.baromin = reshape(td.baromin, v.names="x", idvar='rowID', timevar='SITE_ID',
			    varying=list(7:15), direction='long')
tdl.target = reshape(td.target, v.names="x", idvar='rowID', timevar='SITE_ID',
			   varying=list(7:45), direction='long')

## convert site id from the index value (i.e. original column number)
## back to the column name (which is stored in the reshapeLong attribute)
tdl.tempmax$SITE_ID = attr(tdl.tempmax, 'reshapeLong')$varying[[1]][tdl.tempmax$SITE_ID]
tdl.tempmin$SITE_ID = attr(tdl.tempmin, 'reshapeLong')$varying[[1]][tdl.tempmin$SITE_ID]
tdl.baro$SITE_ID    = attr(tdl.baro   , 'reshapeLong')$varying[[1]][tdl.baro$SITE_ID]
tdl.baromax$SITE_ID = attr(tdl.baromax, 'reshapeLong')$varying[[1]][tdl.baromax$SITE_ID]
tdl.baromin$SITE_ID = attr(tdl.baromin, 'reshapeLong')$varying[[1]][tdl.baromin$SITE_ID]
# tdl.target$SITE_ID  = attr(tdl.target, 'reshapeLong')$varying[[1]][tdl.target$SITE_ID]

## the target requires special treatment since the col id contains
## both the site id and the target id
tmp = attr(tdl.target, 'reshapeLong')$varying[[1]]
tmp = do.call(rbind, strsplit(tmp, '_'))[,-1]
tmp = apply(tmp, 2, as.numeric)
tmp
ind = tdl.target$SITE_ID
tdl.target$SITE_ID = tmp[,1][ind]
tdl.target$TARGET_ID = tmp[,2][ind]
rm(tmp, ind)

## convert the site id labels to numeric values
str(tdl.tempmax$SITE_ID)
table(tdl.tempmax$SITE_ID)
table(as.numeric(gsub('.+\\_','',tdl.tempmax$SITE_ID)))
tdl.tempmax$SITE_ID = as.numeric(gsub('.+\\_','',tdl.tempmax$SITE_ID))
tdl.tempmin$SITE_ID = as.numeric(gsub('.+\\_','',tdl.tempmin$SITE_ID))
tdl.baro$SITE_ID = as.numeric(gsub('.+\\_','',tdl.baro$SITE_ID))
tdl.baromax$SITE_ID = as.numeric(gsub('.+\\_','',tdl.baromax$SITE_ID))
tdl.baromin$SITE_ID = as.numeric(gsub('.+\\_','',tdl.baromin$SITE_ID))
# tdl.target$SITE_ID = as.numeric(gsub('.+\\_','',tdl.target$SITE_ID))



str(tdl.tempmax)
str(tdl.tempmin)
str(tdl.baro)
str(tdl.baromax)
str(tdl.baromin)
str(tdl.target)


attr(tdl.tempmax, 'reshapeLong') = NULL
attr(tdl.tempmin, 'reshapeLong') = NULL
attr(tdl.baro, 'reshapeLong') = NULL
attr(tdl.baromax, 'reshapeLong') = NULL
attr(tdl.baromin, 'reshapeLong') = NULL
attr(tdl.target, 'reshapeLong') = NULL

colnames(tdl.tempmax) = gsub('position_within_chunk', 'pos', colnames(tdl.tempmax))
colnames(tdl.tempmin) = gsub('position_within_chunk', 'pos', colnames(tdl.tempmin))
colnames(tdl.baro) = gsub('position_within_chunk', 'pos', colnames(tdl.baro))
colnames(tdl.baromax) = gsub('position_within_chunk', 'pos', colnames(tdl.baromax))
colnames(tdl.baromin) = gsub('position_within_chunk', 'pos', colnames(tdl.baromin))
colnames(tdl.target) = gsub('position_within_chunk', 'pos', colnames(tdl.target))

colnames(tdl.tempmax) = gsub('month_most_common', 'month', colnames(tdl.tempmax))
colnames(tdl.tempmin) = gsub('month_most_common', 'month', colnames(tdl.tempmin))
colnames(tdl.baro) = gsub('month_most_common', 'month', colnames(tdl.baro))
colnames(tdl.baromax) = gsub('month_most_common', 'month', colnames(tdl.baromax))
colnames(tdl.baromin) = gsub('month_most_common', 'month', colnames(tdl.baromin))
colnames(tdl.target) = gsub('month_most_common', 'month', colnames(tdl.target))



save(tdl.tempmax, file='tdl.tempmax.RData')
save(tdl.tempmin, file='tdl.tempmin.RData')
save(tdl.baro, file='tdl.baro.RData')
save(tdl.baromax, file='tdl.baromax.RData')
save(tdl.baromin, file='tdl.baromin.RData')
save(tdl.target, file='tdl.target.RData')



