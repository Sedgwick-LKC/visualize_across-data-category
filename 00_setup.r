## ------------------------------------------------ ##
# Visualize - Setup
## ------------------------------------------------ ##
# Purpose:
## Do setup steps that are necessary for at least one of the visualization scripts in this repo

# Clear environment
rm(list = ls()); gc()

## ----------------------------- ##
# Make Folders ----
## ----------------------------- ##

# Create necessary folders
dir.create(path = file.path("data", "tidy"), showWarnings = F, recursive = T)
dir.create(path = file.path("data", "precip"), showWarnings = F)
dir.create(path = file.path("graphs"), showWarnings = F)

# End ----