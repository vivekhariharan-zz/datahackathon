# 
# 02/04/2010 - A copy of sourceDir
# 07/15/2010 - Modified for new path 'J:\frm_group\R\Functions'
# Author: gene.leynes 
###############################################################################

sourceDir=function(path='J:/frm_group/R/Functions', trace = TRUE, ...) {
###     for (nm in list.files(path, pattern = "\\.[RrSsQq]$")) {
        for (nm in list.files(path, pattern = "\\.[Rr]$")) {
                        if(trace) cat(nm,":")           
                source(file.path(path, nm), ...)
                if(trace) cat("\n")
        }
}

