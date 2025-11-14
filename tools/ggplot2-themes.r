## ------------------------------------------------ ##
# `ggplot2` Custom Themes
## ------------------------------------------------ ##
# Purpose
## Consolidate theme elements for certain types of graphs in one place

## ----------------------------- ##
# Time Series ----
## ----------------------------- ##

# Generic time series
theme_lkc.series <- theme_classic(base_size = 16) +
  theme(legend.title = element_blank(),
        axis.text.x = element_text(angle = 45, hjust = 1),
        axis.title.x = element_blank())

# End ----
