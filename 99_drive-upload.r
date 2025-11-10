## ------------------------------------------------ ##
# Upload Data (to Google Drive)
## ------------------------------------------------ ##
# Purpose:
## Upload outputs of the code to various parts of the LKC Shared Drive

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

# Identify the relevant local files
(x_graphs <- dir(path = file.path("graphs"), pattern = "x"))

# Identify link to destination Drive folder
x_drive <- googledrive::as_id("")

# Upload relevant graphs to that folder
# purrr::walk(.x = x_graphs, .f = ~ googledrive::drive_upload(media = file.path("graphs", .x),
#                                                             overwrite = T, path = x_drive))

# End ----
