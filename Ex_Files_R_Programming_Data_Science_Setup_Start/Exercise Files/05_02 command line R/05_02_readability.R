# Description: calculate readability of a sentence from command line

list.of.packages <- c("readability")

if (! "readability" %in% installed.packages() ) {
	install.packages("readability", repos = "https://cloud.r-project.org")
	}

library(readability)

# read arguments
argv <- commandArgs(trailingOnly = TRUE)

readability(argv[1], NULL)
