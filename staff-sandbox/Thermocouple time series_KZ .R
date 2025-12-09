#Title: Thermocouple time series 

#To do
###make a time series plot for every data logger
###then decide on a window of time to extract
###find the date/time of the max temp. 
##notes: burn dates:SW2/3/5 11/08/2025 and SW4s/5 11/09/2025

##drive-download: how to: https://lter.github.io/scicomp/tutorial_googledrive-pkg.html

## ------------------------ ##
# Housekeeping ----
## ------------------------ ##

##load libraries
# install.packages("librarian")
librarian::shelf(tidyverse)

# Get set up
source("00_setup.r")

# Clear environment
rm(list = ls()); gc()

## ------------------------ ##
# Load Data ----
## ------------------------ ##

#load data
all_loggers <- read.csv(file = file.path("data", "fire", "vmp-25_thermocouple-logger-data.csv") )

#checking column classes
str(all_loggers)

## ------------------------ ##
# Subset Data ----
## ------------------------ ##

##subset to one logger & fix date/time class
single_logger <- filter(all_loggers, logger.number == 1) %>%
  dplyr::mutate(date.time = as.POSIXct(date.time, format = "%Y-%m-%d %H:%M:%S"))

# Check structure (i.e., column classes)
str(single_logger)

# Grab just the mean values
mean_logger <- single_logger %>%
  dplyr::select(-port, -temperature_deg.F, -height_cm, -dist.from.tree_cm) %>% 
  dplyr::distinct()

# Check structure
str(mean_logger)

# Make exploratory graph
ggplot(mean_logger, aes(x = date.time, y = mean.temperature_deg.F)) +
  geom_point() +
  geom_line() +
  theme_classic()

## ------------------------ ##
# Subset Around Peak ----
## ------------------------ ##

# Identify peak temperature (and _when_ that was)
peak_moment <- mean_logger %>% 
  filter(mean.temperature_deg.F == max(mean.temperature_deg.F, na.rm = T))

# Filter data to only some distance from that peak
interest_logger <- mean_logger %>% 
  # Get time difference between peak and each date
  dplyr::mutate(time.difference_hours = (as.numeric(date.time - peak_moment$date.time) / 60) / 60) %>% 
  # Filter to within desired range
  dplyr::filter(time.difference_hours >= -10 & time.difference_hours <= 20)

# Check structure
str(interest_logger)

# Make another exploratory graph
ggplot(interest_logger, aes(x = date.time, y = mean.temperature_deg.F)) +
  geom_point() +
  geom_line() +
  theme_classic()

# BASEMENT ----
## Superseding everything belowc (will delete as it is replaced)


# Load them
library(googledrive)
googledrive::drive_auth(email = "kazumdahl@ucsb.edu")
##to download helpful R scripts this is for logger one only. must do for every logger
drive_url <- googledrive::as_id("https://drive.google.com/drive/folders/1qWM1-HT6SFnzQ5O0dPRAy9ntYc_h-6pw?usp=share_link")
drive_folder <- googledrive::drive_ls(path = drive_url) %>% filter(name == "vmp-25_thermocouple-logger-data.csv") ##ask Nick for help. why can't I see inside folder, gives error: Parent specified via `path` is invalid:
#the pipe filter returned the exact file name to extract
drive_folder

# Identify the file path we want locally
log_path <- file.path("data", "fire")

# Download this file
purrr::walk2(.x = drive_folder$id, .y = drive_folder$name,
             .f = ~ googledrive::drive_download(file = .x, overwrite = T,
                                                path = file.path(log_path, .y)))
logger1 <- read.csv(file = file.path(log_path, "vmp-25_thermocouple-logger-data.csv") )


##next wrangle each RAW logger file 

library(ggplot2)
library(astsa)
library(chron)
library(timetk)
library(dplyr)
library(lubridate)
###############logger1: plot 5 tag#2463

names(d0) <- c("x","DateTime","Aport", "Bport", "Cport", "Dport")
d0 <- select(d0, DateTime, Aport, Bport, Cport, Dport)


##create tiem series plot

  
  ## ----------------------------- ##
  # Make Folders ----
## ----------------------------- ##

###############logger2: plot 6 tag#3994

###############logger4: plot CSS14 ground

###############logger5: plot 6 tag#9772

###############logger6: plot 6 tag#3992

###############logger7: plot 13 tag#V119

###############logger8: plot SRA80 ground

###############logger9: plot 13 tag#V670

###############logger10: plot 13 tag#V92

###############logger11: plot 13 tag#V137

###############logger13: plot 10 ground

###############logger14: plot 13 tag#V136

###############logger15: plot 5 tag#3914

