# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: R command line program shell

# stash command line arguments in traditional argv/argc notation
argv <- commandArgs(trailingOnly = TRUE)
argc <- length(argv)

argCounter <- 1 # used by getNextArg

getNextArg <- function() {
	# returns the next argument or NULL if finished
	if (argCounter > argc) { returnval <- NULL }
	else returnval <- argv[argCounter]
	argCounter <<- argCounter + 1
	return(returnval)
}

firstFunction <- function( ) {
	# handler for --doThis
	# --doThis is followed by a single integer
	# This should do some sort of validation - I'm leaving that up to you
	cat(getNextArg(), "little monkeys jumping on the bed.\n")
}

secondFunction <- function( doThis ) {
	# handler for --doThat
	# --doThat is followed by a string
	cat("Two little", getNextArg(), "jumping on the bed.\n")
}

while( !is.null(thisArg <- getNextArg())) {
switch ( thisArg,
	"--doThis" = firstFunction(),
	"--doThat" = secondFunction()
)
}


