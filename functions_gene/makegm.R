# TODO: Add comment
# 
# Author: gene.leynes
###############################################################################


## 2/28/11 UPDATE: Now uses cumsum, which is about 7% faster

makegm=function(mu=0.05, sigma=0.20, dt=1, T=10, sims=1e4){
	###############################################################################
	## MakeGM - "Make Brownian Motion"
	## Function to generate geometric brownian motion
	## Returns matrix of accumulation factors (simulations x timesteps)
	## Author: gene.leynes
	## Date: 2010-07-07
	###############################################################################
	
	#browser()
	timesteps = T/dt
	phi = matrix(rnorm(timesteps*sims), nrow=sims, ncol=timesteps)
	x = (mu-sigma*sigma/2)*dt + sigma*phi*sqrt(dt)
	for (i in 1:nrow(x)) x[i,] = cumsum(x[i,])
	s = exp(x)
	#ds = exp(x)
	#s = matrix(NA,nrow(ds),ncol(ds))
	#for (i in 1:nrow(ds)) s[i,]<-cumprod(ds[i,])
	
	attr(s,'mu')=mu
	attr(s,'sigma')=sigma
	attr(s,'dt')=dt
	attr(s,'T')=T
	attr(s,'sims')=sims
	#attr(s,'ds')=ds
	return(s)
	
	##-----------------------------------------------------------------------------
	## Syntax example:
	##-----------------------------------------------------------------------------
	if(FALSE){
		setwd('J:/frm_group/MStarFundResearch/R_Milliman')
		source('Functions/Function_makegm.R')
		## Replicating a European option
		x=makegm(mu=0.05, sigma=0.2, dt=1, T=10, sims = 1e6)
		mean(pmax(1.1 - x[,10], 0))*exp(-10*.05)# Put worth .0794
		mean(pmax(x[,10] - 1.1, 0))*exp(-10*.05)# Call worth .4122
	}
}



###############################################################################
###############################################################################
###############################################################################
## More experimentation:
if(FALSE){
	makegm(mu=0.05, sigma=0.20, dt=1, T=10, sims=15)
	makegm(mu=0.05, sigma=0.002, dt=1, T=10, sims=15)
	set.seed(sqrt(370))
	x=makegm(mu=0.05, sigma=0.20, dt=1, T=10, sims=1e5)
	range(log(x))
	mean(x[,10])^(1/10)
	mean(x[,10]^(1/10))
	mean(log(x[,10]))/10
	log(mean(x[,10]))/10
	log(mean(x[,10])^(1/10))
	
	sd(x[,10]/x[,9])    	 # 0.2122
	sd(log(x[,10]/x[,9]))    # 0.20
	mean(log(x[,10]/x[,9]))  # 0.03
	log(mean(x[,10]/x[,9]))  # 0.05
	xx1=t(apply(x,1, function(z) {exp(diff(log(z)))}  ))
	log(apply(xx1, 2, mean))
	apply(log(xx1), 2, mean)
	range(xx1)
	xx2=t(apply(x,1, function(z) {1+(diff(log(z)))}  ))
	log(apply(xx2, 2 ,mean))
	apply(exp(xx2-1), 2, mean)
	range(xx2)
	
	plot(density(xx2),xlim=range(xx1,xx2), main='Normal in black, lognormal in blue')
	lines(density(xx1),col='blue')
	abline(v=c(min(xx1),min(xx2)), col=c('blue','black'), lty=2)
	abline(v=c(max(xx1),max(xx2)), col=c('blue','black'), lty=2)
	
	## Replicating a European option
	x=makegm(mu=0.05, sigma=0.2, dt=1, T=10, sims = 1e6)
	mean(pmax(1.1 - x[,10], 0))*exp(-10*.05)# Put worth .0794
	mean(pmax(x[,10] - 1.1, 0))*exp(-10*.05)# Call worth .4122
}

