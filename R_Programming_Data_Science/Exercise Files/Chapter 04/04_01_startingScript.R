
# setup -------------------------------------------------------------------
# start up the high velocity data simulator
HighVelSimTxt <- "../HighVelocitySimulation.txt" # set this to the pathname of the simulation data

# setwd to chapter 4

library(lubridate)
library(profvis)

# first attempt with no optimization ---------------------------------------------------------

collectOneSecond <- function() {
  oneSecData <- data.frame(
    "V1" = NA,
    "V2" = NA,
    "V3" = NA,
    "V4" = NA
  )
  
  amountOfRunTime <- now() + seconds(1)
  
  while (amountOfRunTime > now()) {
    
    newData <- read.table(HighVelSimTxt)

      if (newData$V3 > 128) {
        newData$V4 <- "higher"
      } else {
        newData$V4 <- "lower"
      }
      
      oneSecData <- rbind(oneSecData, newData)
  }
  
  return(oneSecData)
}

oneSecondOfData <- collectOneSecond()

profvis(collectOneSecond())
