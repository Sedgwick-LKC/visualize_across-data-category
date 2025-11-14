## ------------------------------------------------ ##
# Visualization Data Prep - Fire & Climate
## ------------------------------------------------ ##
# Purpose:
## Prepare data for visualization

# Load libraries
# install.packages("librarian")
librarian::shelf(tidyverse)

# Get set up
source("00_setup.r")

# Clear environment
rm(list = ls()); gc()

## ----------------------------- ##
# Load LFM Data ----
## ----------------------------- ##

# Load the data
lfm_v01 <- read.csv(file = file.path("data", "fire", "live-fuel-moisture_2023-2025.csv"))

# Check structure
dplyr::glimpse(lfm_v01)

## ----------------------------- ##
# Load Precip Data ----
## ----------------------------- ##

# Load the data
prec_v01 <- read.csv(file = file.path("data", "climate", "precipitation_2017-05-24_2025-11-07.csv"))

# Check structure
dplyr::glimpse(prec_v01)

## ----------------------------- ##
# Prepare & Combine LFM w/ Precip ----
## ----------------------------- ##

# Prepare the LFM data
lfm_v02 <- lfm_v01 |> 
  dplyr::mutate(Moisture = Moisture_content * 100) |> 
  dplyr::select(Date, Site, Species, Moisture) |> 
  dplyr::distinct()

# Check structure
dplyr::glimpse(lfm_v02)

# Prepare the precip data
prec_v02 <- prec_v01 |> 
  dplyr::select(date, precip_mm) |> 
  dplyr::distinct()

# Check structure
dplyr::glimpse(prec_v02)

# Combine the two
combo_lfm.prec <- dplyr::left_join(x = lfm_v02, y = prec_v02,
  by = c("Date" = "date"))

# Check structure
dplyr::glimpse(combo_lfm.prec)

## ----------------------------- ##
# Export LFM w/ Precip ----
## ----------------------------- ##

# Export!
write.csv(x = combo_lfm.prec, na = '', row.names = F,
  file = file.path("data", "multi-category", "fire-climate_lfm-and-precip.csv"))

# End ----
