# an example of batch processing high velocity data
 
# Setup -------------------------------------------------------------------
# install.packages("lubridate")
library(lubridate)
HighVelSimTxt <- "../HighVelocitySimulation.txt" # set this to the pathname of the simulation file

# Acquire -----------------------------------------------------------------
# grab one second worth of data

collectOneSecond <- function() {
  oneSecData <- data.frame("V1" = NA,
                                "V2" = NA,
                                "V3" = NA)
  
  amountOfRunTime <- now() + seconds(1)
  
  while (amountOfRunTime > now()) {
    newData <- read.table(HighVelSimTxt)
    oneSecData <- rbind(oneSecData, newData)
  }
  
  return(oneSecData)
}

oneSecondOfData <- collectOneSecond()

# Process -----------------------------------------------------------------
# do something with the data
meanResult <- mean(oneSecondOfData$V3, na.rm = TRUE)

# Present -----------------------------------------------------------------
print(paste("The Arithmetic Mean of V3 is ", meanResult))



