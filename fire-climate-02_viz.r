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
# Load & Prepare Data ----
## ----------------------------- ##

# Load the LFM data
df_lfm <- read.csv(file = file.path("data", "fire", "viz-ready_lfm.csv")) %>% 
  dplyr::mutate(Date = as.Date(Date))

# Check structure
dplyr::glimpse(df_lfm)

# Load the precipitation data too
df_prec <- read.csv(file = file.path("data", "climate", "viz-ready_precip.csv")) %>% 
  dplyr::mutate(date = as.Date(date))

# Check structure
dplyr::glimpse(df_prec)

## ----------------------------- ##
# LFM & Precip ----
## ----------------------------- ##

# Define custom colors for included species
spp_colors <- c("Purple Sage" = "#762a83",
                "California Sagebrush" = "#c2a5cf",
                "Blue Oak" = "#a6dba0",
                "Coast Live Oak" = "#1b7837")

# Make the LFM graph
graph_lfm <- ggplot2::ggplot(df_lfm, aes(x = Date, y = Moisture, color = Species)) +
  ggplot2::geom_line() + 
  ggplot2::geom_point() +
  # Add horizontal lines for key threshold LFM values
  ggplot2::geom_hline(yintercept = 60, lwd = 0.5, linetype = 2) +
  ggplot2::geom_hline(yintercept = 79, lwd = 0.5, linetype = 2, color = 'red') +
  # Tweak theme elements
  ggplot2::scale_color_manual(values = spp_colors) +
  ggplot2::labs(y = "Live Fuel Moisture (%)", x = "Date") +
  ggplot2::scale_x_date(date_breaks = "3 months") +
  theme_lkc.series +
  ggplot2::theme(legend.position = "top",
    axis.text.x = element_blank(),
    axis.title.x = element_blank()); graph_lfm

# Make the precip graph
graph_prec <- ggplot2::ggplot(df_prec, aes(x = date, y = precip_mm)) +
  ggplot2::geom_bar(stat = 'identity', color = "#0077b6") +
  ggplot2::labs(y = "Precipitation (mm)", x = "Date") +
  ggplot2::scale_x_date(date_breaks = "3 months") +
  ggplot2::theme_classic(base_size = 16) +
  ggplot2::theme(axis.title.y = element_text(),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title.x = element_blank()); graph_prec

# Assemble a multi-panel graph
cowplot::plot_grid(graph_lfm, graph_prec, ncol = 1, align = "hv")

# Export
ggplot2::ggsave(filename = file.path("graphs", "fire-climate_lfm-and-precip.png"),
width = 10, height = 8, units = "in")

# End ----
