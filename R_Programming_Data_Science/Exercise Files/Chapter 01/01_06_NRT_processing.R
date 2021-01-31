
# an example of NRT processing high velocity data
 
# Setup -------------------------------------------------------------------
# install.packages("DBI")
# install.packages("RSQLite")
library(DBI)
library(RSQLite)

mySQLiteDB <- dbConnect(RSQLite::SQLite(), 
                        "AcquisitionDB.SQLite",
                        flags = SQLITE_RO)

# Process -----------------------------------------------------------------
doThisSQL <- " SELECT avg(V3), count(*) FROM 'Acquired Data' "

while (TRUE) {
  dataRead <- dbGetQuery(mySQLiteDB, doThisSQL)
  
  # Present -----------------------------------------------------------------
  flush.console()
  cat(sprintf("With %d observations, the mean of V3 is %.3f",
              dataRead$`count(*)`,
         dataRead$`avg(V3)`),
      "\r"
  )
  Sys.sleep(3) # because SQLite doesn't handle concurrency very well

}

# Clean up ----------------------------------------------------------------

dbDisconnect(mySQLiteDB)

