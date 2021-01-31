# Description: Optimal example for Bioconductor
# How many buildings in a satellite image?

# Load bioconductor and packages ------------------------------------------

source("http://bioconductor.org/biocLite.R")

biocLite("EBImage")
install.packages("ggmap")

library(EBImage)
library(ggmap)


# read the image ----------------------------------------------------------

# image from https://www.planet.com
city_image <- readImage("pdxFromAir.png")
  
hist_values <- hist(city_image) # from EBImage

# sensitivity setting
imageOfBuildingThreshold <- .6 
city_image_thresholded <- city_image > imageOfBuildingThreshold

display(city_image) # display from EBImage
display(city_image_thresholded) # from EBImage


# Count buildings ---------------------------------------------------------

building_count <- bwlabel(city_image_thresholded) # from EBImage

max(building_count) # returns the highest labeled item from bwlabel

