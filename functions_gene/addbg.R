addbg=function(color=heat.colors(40, alpha=.15)[30], 
		linecolor='grey75', addgridlines=TRUE, debug=FALSE){
	
	if(debug)browser()
	tmp=par("usr")
	rect(tmp[1], tmp[3], tmp[2], tmp[4], col=color)
	if(addgridlines){
		ylimits=par()$usr[c(3,4)]
		abline(h=pretty(ylimits,10), lty=2, col=linecolor)
	}
}
#addbg=function(color=NULL, addgridlines=TRUE, debug=FALSE){
#	if(debug)browser()
#	tmp=par("usr")
#	if(is.null(color))
#		color=heat.colors(40, alpha=.15)[30]
#	rect(tmp[1], tmp[3], tmp[2], tmp[4], col=color)
#	if(addgridlines){
#		ylimits=par()$usr[c(3,4)]
#		yrange=diff(ylimits)
#		if(yrange>2){
#			yscale=log(yrange,10)+.150
#		}else{
#			yscale=log(yrange,10)-.150
#		}
#		yexp=round(yscale)-1
#		ystep=10^yexp
#		if(yrange>2){
#			ybot=trunc(ylimits[1]/ystep)*ystep-ystep
#			ytop=(1+trunc(ylimits[2]/ystep))*ystep
#		}else{
#			ybot=trunc(ylimits[1])-1
#			ytop=trunc(ylimits[2])+1
#		}
#		if(abs(ystep)>getOption('ts.eps')){
#			ysegs=seq(ybot, ytop, ystep)
#			abline(h=ysegs, lty=2, col='grey75')
#		}
#	}
#}


if(FALSE){
	#THIS ONE WORKED, BUT NOT PERFECTLY
	addbg=function(color=NULL, addgridlines=TRUE, debug=FALSE){
		if(debug)browser()
		tmp=par("usr")

		if(is.null(color))
			color=heat.colors(40, alpha=.15)[30]
		rect(tmp[1], tmp[3], tmp[2], tmp[4], col=color)

		if(addgridlines){
			ylimits=par()$usr[c(3,4)]
			yupper=trunc(log(diff(ylimits),10))
			yseg=10^yupper
			ymin=trunc(ylimits[1]/yseg)
			ysegs=seq(ymin, ymin+yseg*20, yseg)
			abline(h=ysegs, lty=2, col='grey75')
		}
	}
}
