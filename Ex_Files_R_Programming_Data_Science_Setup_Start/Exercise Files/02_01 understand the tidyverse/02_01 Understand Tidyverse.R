# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Understanding the Tidyverse


# Not as per Tidyverse Guidelines -----------------------------------------

myfunc <- function(a = 1, x = data) 
{
  print(x[ , a])
}

myfunc(3, data.frame(3,4,5))
# this works, but data isn't first

# as per Tidyverse Guidelines ---------------------------------------------

myfunc <- function(x = data, a = 1) 
{
  print(x[ , a])
}

myfunc(data.frame(3,4,5), 3)
# this still works, but data is first


# Quick demo of pipeline --------------------------------------------------

install.packages("tidyverse")
library(tidyverse)

data.frame(3,5,7) %>% 
  myfunc()
# pipeline places data in first argument of function

# consistent data across a family of functions ----------------------------

firstThis <- function(x) {
  tempList <- list(firstArg = x, lengthOf = length(x))
  return(tempList)
}

firstThis( data.frame(3,5,7) )
# this works - but returns a list

data.frame(3,5,7) %>% 
  firstThis() %>%
  myfunc()
# and it breaks the pipeline example

firstThis <- function(x) {
  tempList <- data.frame(firstArg = x, lengthOf = length(x))
  return(tempList)
}
# simply changing the return class to data.frame fixes pipeline


# tidy data ---------------------------------------------------------------

# not tidy
notTidyCats <- data.frame(Panthera = c(Weight = "172 lbs", lifespan = 19),
                          Lynx = c(Weight = "15 kg", lifespan = 8),
                          Domestic = c(Weight = "8 pounds", lifespan = 15))

# tidy
tidyCats <- data.frame(Species = "Panthera", Key = "Weight", Value = 172)
tidyCats <- rbind(tidyCats, data.frame(Species = "Panthera", Key = "lifespan", Value = 19))
tidyCats <- rbind(tidyCats, data.frame(Species = "Lynx", Key = "Weight", Value = 34))
tidyCats <- rbind(tidyCats, data.frame(Species = "Lynx", Key = "lifespan", Value = 8))
tidyCats <- rbind(tidyCats, data.frame(Species = "Domestic", Key = "Weight", Value = 8))
tidyCats <- rbind(tidyCats, data.frame(Species = "Domestic", Key = "lifespan", Value = 15))

# with tidy data, this code works...
mean(tidyCats[ tidyCats$Key == "Weight", "Value"])

plot(tidyCats[ tidyCats$Key == "Weight", "Value"],
     xlab = "Weight",
     tidyCats[ tidyCats$Key == "lifespan", "Value"],
     ylab = "lifespan"
     )
