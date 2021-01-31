# Description: Demonstration of sqldf package

# sqldf adds two functions:
#    read.csv.sql - Read a file into R filtering it with an sql statement.
#    sqldf - SQL select on data frames

install.packages("sqldf")
library(sqldf)

# read.csv.sql ------------------------------------------------------------
# filter and import a csv file. Useful for files larger than available memory

doThisSQL <- "select ORIGIN_STATE_ABR, DEP_DELAY_NEW, DISTANCE from file where ORIGIN_STATE_ABR like '%OR%' "

OR_departures <- read.csv.sql(file = "../global_ontime.csv",
             sql = doThisSQL)

# There are lots of options - but tend to be system dependent.

# sqldf -------------------------------------------------------------------
# This doesn't do anything you can't do in Base R - but may be more familiar if you are comfortable with SQL

doThisSQL <- "select ORIGIN_STATE_ABR, DISTANCE * 1.6 as Kilometers, DISTANCE as Miles from OR_departures"

OR_distance_km <- sqldf(x = doThisSQL)

# ... the same thing in Base R

ORIGIN_STATE_ABR <- OR_departures[ , "ORIGIN_STATE_ABR" ]
Kilometers <- OR_departures[ , "DISTANCE" ] * 1.6
Miles <- OR_departures[ , "DISTANCE" ]

OR_distance_km2 <- data.frame( ORIGIN_STATE_ABR, Kilometers, Miles  )

