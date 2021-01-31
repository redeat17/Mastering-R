

# A demonstration of polling for data

HighVelSimTxt <- "HighVelocitySimulation.txt" # set this to the pathname of the simulation data

while (TRUE) {
  if (file.exists(HighVelSimTxt)) {
    Sys.sleep(1) # give the simulator time to finish writing
    dataFromPolling <- read.table(HighVelSimTxt)
    print(dataFromPolling)
    file.remove(HighVelSimTxt)
  }
}
