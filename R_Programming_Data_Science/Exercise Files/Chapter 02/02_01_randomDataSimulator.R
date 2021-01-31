 
rowcounter <- 0

HSDtmpFile <- "tempSim.txt"
HSDFinalFile <- "HighVelocitySimulation.txt"

while (TRUE) {
  writeThisLine <- data.frame(rowcounter,
                              strftime(Sys.time()),
                              rnorm(1, mean = 128, sd = 5))
  
  write.table(writeThisLine, 
              file = HSDtmpFile,
              append = FALSE,
              col.names = FALSE,
              row.names = FALSE)
  
  file.rename(from = HSDtmpFile, to = HSDFinalFile) 
  
  rowcounter <- rowcounter + 1
  while (file.exists(HSDFinalFile)) { Sys.sleep(.1) }
  Sys.sleep(runif(1, min = 0.1, max = 1.5))
  
}


