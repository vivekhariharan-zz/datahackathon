loader = function (x, xPath = ".") 
{
	if (length(grep("\\.[Rr][Dd]ata$", x)) == 0) {
		x = paste(x, ".RData", sep = "")
	}
	xWithPath = file.path(xPath, x)
	rm(xPath)
	if (as.name(x) == "x") {
		load(xWithPath)
		rm(xWithPath)
		return(x)
	}
	else {
		load(xWithPath)
		rm(x, xWithPath)
		NewVar = ls()[1]
		return(eval(substitute(variable, list(variable = as.name(NewVar)))))
	}
}

