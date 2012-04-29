## Author: Gene Leynes
## Date Nov 10, 2010
##
## Very similar to "addbg()"
## Difference is that this is intended to be run with "panel first"
## Will aid in printing / copying / exporting images

if(FALSE){
	## SAMPLE USAGE:
	plot(faithful)
	plot(faithful, panel.first=bgfun())
	plot(faithful, panel.first=bgfun('honeydew'))
	plot(faithful, panel.first=bgfun('lightyellow'))
	plot(faithful, panel.last=bgfun('lightyellow'))  # COVERS THE IMAGE!

	## DEMO OF addbg()
	## THIS WILL WORK BEFORE OR AFTER PLOTTING, BUT MAY NOT COPY PROPERLY
	plot(faithful, panel.first=addbg())
	plot(faithful, panel.last=addbg()) # COVERS IMAGE, BUT WITH TRANSPARENCY
	plot(faithful)
	addbg()
	addbg()
}

#~ bgfun=function(color=NULL, addgridlines=TRUE, debug=FALSE){
        #~ if(debug)browser()
        #~ tmp=par("usr")
        #~ if(is.null(color))
                #~ color='honeydew2'
        #~ rect(tmp[1], tmp[3], tmp[2], tmp[4], col=color)
        #~ if(addgridlines){
                #~ ylimits=par()$usr[c(3,4)]
                #~ yrange=diff(ylimits)
                #~ if(yrange>2){
                        #~ yscale=log(yrange,10)+.150
                #~ }else{
                        #~ yscale=log(yrange,10)-.150
                #~ }
                #~ yexp=round(yscale)-1
                #~ ystep=10^yexp
                #~ if(yrange>2){
                        #~ ybot=trunc(ylimits[1]/ystep)*ystep-ystep
                        #~ ytop=(1+trunc(ylimits[2]/ystep))*ystep
                #~ }else{
                        #~ ybot=trunc(ylimits[1])-1
                        #~ ytop=trunc(ylimits[2])+1
                #~ }
                #~ if(abs(ystep)>getOption('ts.eps')){
                        #~ ysegs=seq(ybot, ytop, ystep)
                        #~ abline(h=ysegs, lty=2, col='grey75')
                #~ }
        #~ }
#~ }

bgfun=function(color='honeydew2',linecolor='grey45', addgridlines=TRUE, debug=FALSE){
	if(debug)browser()
	tmp=par("usr")
	rect(tmp[1], tmp[3], tmp[2], tmp[4], col=color)
	if(addgridlines){
		ylimits=par()$usr[c(3,4)]
		abline(h=pretty(ylimits,10), lty=2, col=linecolor)
	}
}

