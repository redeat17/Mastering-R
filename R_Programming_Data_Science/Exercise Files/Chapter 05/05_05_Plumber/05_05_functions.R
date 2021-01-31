
# setup -------------------------------------------------------------------
# start up the high velocity data simulator
HighVelSimTxt <- "../../HighVelocitySimulation.txt" # set this to the pathname of the simulation data

library(lubridate)

#* @get /collectOneSecond
collectOneSecond <- function() {
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

    oneSecData[[dataIDX]] <- newData
    dataIDX <- dataIDX + 1

  }

  # remove empty elements of oneSecondOfData
  allGoodData <- oneSecData[!sapply(oneSecData, is.null)]

  return(allGoodData)
}


# get one read ------------------------------------------------------------

#* @get /collectOneRead
collectOneRead <- function() {
  newData <- read.table(HighVelSimTxt)

  return(newData)
}

