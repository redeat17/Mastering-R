
# setup -------------------------------------------------------------------
# start up the high velocity data simulator
HighVelSimTxt <- "../HighVelocitySimulation.txt" # set this to the pathname of the simulation data

library(lubridate)

nocopy_collectOneSecond <- function() {
  # oneSecData <- data.frame("V1" = NA,
  #                          "V2" = NA,
  #                          "V3" = NA,
  #                          "V4" = NA)
  oneSecData <- vector(mode = "list", 10000)
  dataIDX <- 1
  
  amountOfRunTime <- now() + seconds(1)
  
  while (amountOfRunTime > now()) {
    newData <- read.table(HighVelSimTxt)
    
    if (newData$V3 > 128 ) {
      newData$V4 <- "higher"
    } else {
      newData$V4 <- "lower"
    }
    
    # oneSecData <- rbind(oneSecData, newData)
    oneSecData[[dataIDX]] <- newData
    dataIDX <- dataIDX + 1
    
  }
  
  # remove empty elements of oneSecondOfData
  allGoodData <- oneSecData[!sapply(oneSecData, is.null)]
  
  return(allGoodData)
}

nocopy_oneSecondOfData <- nocopy_collectOneSecond()

profvis(nocopy_collectOneSecond())

