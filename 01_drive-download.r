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
# Download LFM Data ----
## ----------------------------- ##
## LFM = Live Fuel Moisture

# Identify the relevant file in Google Drive
lfm_drive <- googledrive::drive_ls(googledrive::as_id("https://drive.google.com/drive/folders/1EOrKk39IppCX9gQ5KWlpO890XGpcgwzg"), pattern = "csv") |> 
  dplyr::filter(stringr::str_detect(string = name, pattern = "live-fuel-moisture"))

# Did that work?
## It did if you see the name of a CSV when you run the next line
lfm_drive

# Identify the file path we want locally
lfm_path <- file.path("data", "fire")

# Download this file
purrr::walk2(.x = lfm_drive$id, .y = lfm_drive$name,
    .f = ~ googledrive::drive_download(file = .x, overwrite = T,
    path = file.path(lfm_path, .y)))

# Clear environment
rm(list = ls()); gc()

## ----------------------------- ##
# Download Precipitation Data ----
## ----------------------------- ##

# Identify the relevant file in Google Drive
prc_drive <- googledrive::drive_ls(googledrive::as_id("https://drive.google.com/drive/folders/1NlMRJSE5KQUdkUE_Nl4wcFansQsI_tT3"), pattern = "csv") |> 
  dplyr::filter(stringr::str_detect(string = name, pattern = "precipitation"))

# Did that work?
## It did if you see the name of a CSV when you run the next line
prc_drive

# Identify the file path we want locally
prc_path <- file.path("data", "climate")

# Download this file
purrr::walk2(.x = prc_drive$id, .y = prc_drive$name,
    .f = ~ googledrive::drive_download(file = .x, overwrite = T,
    path = file.path(prc_path, .y)))

# Clear environment
rm(list = ls()); gc()
    
# End ----
