rhelpSearch <- function(string,
                 restrict = c("Rhelp10", "Rhelp08", "Rhelp02", "functions" ),
                 matchesPerPage = 100, ...)
        RSiteSearch(string=string,  restrict = restrict,
                    matchesPerPage = matchesPerPage, ...)

#rhelpSearch("approxfun integrate")


