# Tic Toc functions, similar to matlab




tic = function()
	ticTime<<-proc.time()

toc = function()
	print(proc.time()-ticTime)

if(FALSE){
	# Run these lines to test functions
	
	tic()
	# Wait for it... wait for it...
	toc()
}








