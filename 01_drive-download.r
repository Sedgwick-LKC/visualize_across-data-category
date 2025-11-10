## ------------------------------------------------ ##
# Download Data (from Google Drive)
## ------------------------------------------------ ##
# Purpose:
## Download pre-wrangled data from various parts of the LKC Shared Drive

# For the code to talk to Drive, you need to tell R who you are (in Google)
## Work through the following tutorial to do so
### https://lter.github.io/scicomp/tutorial_googledrive-pkg.html
## Alternatively, see the help file for the following function:
### `?googledrive::drive_auth`

# Load libraries
# install.packages("librarian")
librarian::shelf(tidyverse, googledrive)

# Get set up
source("00_setup.r")

# Clear environment
rm(list = ls()); gc()

## ----------------------------- ##
# Download ___ Data ----
## ----------------------------- ##

# Identify the relevant file in Google Drive

# Did that work?
## It did if you see the name of a CSV when you run the next line

# Identify the file path we want locally

# Download this file


# End ----
