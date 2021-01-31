# Copyright Mark Niemann-Ross, 2017
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Quick Overview on Installing Bioconductor

# Minimal code to demonstrate how to use bioconductor packages

# First - source biocLite.r
source("http://bioconductor.org/biocLite.R")

# Second - use biocLite to install packages.
# use biocLite instead of install.packages
biocLite("EBImage")
# biocLite might do updates.
# It may ask "Update all/some/none? [a/s/n]: "
# It may ask "Do you want to install from sources the packages which need compilation?" (needs gcc)

# Third - use library to load the package (same as Base R)
library("EBImage")

# Then - EBImage is ready to go
anImage <- readImage("https://apod.nasa.gov/apod/image/1801/M31Clouds_DLopez_1500.jpg")
display(anImage)
hist(anImage)

# If your installation is having problems
biocLite() # will update packages
biocLite("BiocUpgrade") # will upgrade bioconductor
biocValid() # will check for correct installations
# check troubleshooting instructions at https://www.bioconductor.org/install/