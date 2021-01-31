# Copyright Mark Niemann-Ross, 2017
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Optimal example for MRO

library(RevoUtilsMath)

setMKLthreads (1000) #set to max...
maxThreads <- getMKLthreads()

timeAMatrix <- function(MatrixSize, NumOfCores) {
    # this function enables cores, multiplies two matrices, then returns the performance
    setMKLthreads(NumOfCores)
    MatrixRows <- MatrixSize / 10
    matrixOne <- matrix(rnorm(MatrixSize), nrow = MatrixRows)
    matrixTwo <- matrix(rnorm(MatrixSize), nrow = MatrixRows)
    elapsedTime <- system.time(matrixOne * matrixTwo)
    return(data.frame(MatrixSize = as.integer(MatrixSize),
                    cores = getMKLthreads(),
                    Elapsed = as.double(elapsedTime["elapsed"], length = 10)))
}

timeAMatrix(100, 1)
timeAMatrix(10000000, maxTreads)
timeAMatrix(10000000, 1)

savedDataPoints <- data.frame(MatrixSize = numeric(), 
                              cores = numeric(),
                              Elapsed = numeric() )

testTheseSizes <- seq(from = 1000000, to = 100000000, by=1000000)

for (matrixSize in testTheseSizes) {
    for (numbCores in 1:4) {
        savedDF <- as.data.frame(timeAMatrix(matrixSize,numbCores))
        savedDataPoints <- rbind(savedDataPoints, savedDF)
        cat("Matrix Size = ",matrixSize,"Number of Cores = ", numbCores,"\n")
    }
}

savedDataPoints$cores <- factor(savedDataPoints$cores)

library(ggplot2)
performPlot <- ggplot(data = savedDataPoints,
       aes(x = MatrixSize, y = Elapsed)) +
       geom_smooth(se = FALSE, aes(color = cores, linetype = cores)) +
       theme(legend.position = "right")

performPlot

# try this version to see the data points
performPlot + geom_point(aes(color = cores))
       