

#Read the data:
TrainingData = read.csv("./upload/TrainingData.csv")
SubmissionZeros = read.csv("./upload/SubmissionZerosExceptNAs.csv")
sitelocs = read.csv('upload/SiteLocations.csv')

save(TrainingData, file='TrainingData.RData')
save(SubmissionZeros, file='SubmissionZeros.RData')
save(sitelocs, file='sitelocs.RData')

source('loader.R')


