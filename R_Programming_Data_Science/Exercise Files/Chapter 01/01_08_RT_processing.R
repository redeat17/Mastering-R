# an example of Real Time processing high velocity data
 
# Setup -------------------------------------------------------------------

# import necessary libraries
list.of.packages <- c("DBI","RSQLite", "rjson")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if ( length(new.packages) ) install.packages(new.packages)

# SQLite support
library(DBI)
library(RSQLite)
library(rjson)

mySQLiteDB <- dbConnect(RSQLite::SQLite(), "AcquisitionDB.SQLite")

# processing --------------------------------------------------------------

while (TRUE) {
  doThisSQL <- " SELECT avg(V3), max(V1) FROM 'Acquired Data' "
  
  dataRead <- dbGetQuery(mySQLiteDB, doThisSQL)
  
  JSON_representation <- toJSON( dataRead )
  
  write(JSON_representation, file = "meanOfV3.json")
  
  doThisSQL <- " DELETE FROM 'Acquired Data' WHERE V3 < :maxRow "
  myDBIResult <- dbSendQuery(mySQLiteDB, doThisSQL )
  dbBind(myDBIResult, list( maxRow = dataRead[[2]] ) )
  
  Sys.sleep(3) #because SQLite doesn't handle concurrency well
}

# Clean up ----------------------------------------------------------------

dbDisconnect(mySQLiteDB)
