## ------------------------------------------------ ##
# Graphs - Fire & Climate
## ------------------------------------------------ ##
# Purpose:
## Make graphs that include both fire and climate data

# Load libraries
# install.packages("librarian")
librarian::shelf(tidyverse, cowplot)

# Get set up
source("00_setup.r")

# Clear environment
rm(list = ls()); gc()

# Load custom themes
source(file = file.path("tools", "ggplot2-themes.r"))

## ----------------------------- ##
# Load Data ----
## ----------------------------- ##

# Load the LFM + precipitation data
combo_lfm.prec <- read.csv(file = file.path("data", "multi-category", "fire-climate_lfm-and-precip.csv")) |> 
  # Make date a real date
  dplyr::mutate(Date = as.Date(Date)) |> 
  # Keep only rows with all needed data
  dplyr::filter(dplyr::if_all(.cols = dplyr::everything(),
    .fns = ~ !is.na(.)))

# Check structure
dplyr::glimpse(combo_lfm.prec)

## ----------------------------- ##
# LFM & Precip ----
## ----------------------------- ##

# Define custom colors for included species
spp_colors <- c("Purple Sage" = "#762a83",
                "California Sagebrush" = "#c2a5cf",
                "Blue Oak" = "#a6dba0",
                "Coast Live Oak" = "#1b7837")

# Make the LFM graph
graph_lfm <- ggplot(combo_lfm.prec, aes(x = Date, y = Moisture, color = Species)) +
  geom_line() + 
  geom_point() +
  # Add horizontal lines for key threshold LFM values
  geom_hline(yintercept = 60, lwd = 0.5, linetype = 2) +
  geom_hline(yintercept = 79, lwd = 0.5, linetype = 2, color = 'red') +
  # Tweak theme elements
  scale_color_manual(values = spp_colors) +
  labs(y = "Live Fuel Moisture (%)", x = "Date") +
  scale_x_date(date_breaks = "3 months") +
  theme_lkc.series +
  theme(legend.position = "top",
    axis.text.x = element_blank(),
    axis.title.x = element_blank()); graph_lfm

# Split off the precip data (currently rain is duplicated across species & sites)
prec_lfm.duration <- combo_lfm.prec |> 
  dplyr::select(Date, precip_mm) |> 
  dplyr::distinct()

# Check structure
dplyr::glimpse(prec_lfm.duration)

# Make the precip graph
graph_prec <- ggplot(prec_lfm.duration, aes(x = Date, y = precip_mm)) +
  geom_bar(stat = 'identity', color = "#0077b6") +
  labs(y = "Precipitation (mm)", x = "Date") +
  scale_x_date(date_breaks = "3 months") +
  theme_classic(base_size = 16) +
  theme(axis.title.y = element_text(),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title.x = element_blank()); graph_prec

# Assemble a multi-panel graph
cowplot::plot_grid(graph_lfm, graph_prec, ncol = 1, align = "hv")

# Export
ggsave(filename = file.path("graphs", "fire-climate_lfm-and-precip.png"),
width = 10, height = 8, units = "in")

# End ----
