##simple script to produce time series plots and summary stats for
##thermocouple data formatted using 00_setpr, fxn_read-logger.r,thermo-01_wrangle.r
library(ggplot2)
#library(dygraphs)
#library(plotly)
library(xts)
library(ggfortify)
##
###select data, default to therm_v03 from thermo-01_wrangle.r
tdat <- therm_v03 ##note data in fahrenheit
    #select logger
#table(tdat$logger.number)
#3 = T11, 11/9
#4 = T13, 11/8
#8 = sra80, 11/8
#13 = T10, 11/9
      tdat1 <- tdat[tdat$logger.number == 13,]
    #select tcouple
      tcouple_names <- unique(tdat1$port)
      tdat2 <- tdat1[tdat1$port == tcouple_names[4],]
    #convert to xts object
    tdat3 <- xts((tdat2$temperature_deg.F-32)*5/9,tdat2$date.time)
    #extract burn date
    tdat4 <- tdat3["2025-11-09"]
    #get time of max t
    tmax <- which.max(tdat4)
    #plot time series using autoplot
    plot_path <- file.path("graphs")
    pdat <- tdat4[(tmax-1200):(tmax+7200)] #1 hr before, 6 hours after
    pdat2 <- tdat4[(tmax-300):(tmax+1200)] #15 min before, 1 hour after
    p1 <- autoplot(pdat, main = "logger 4, T10,port d", xlab = "time",ylab= "deg C")
    p2 <- autoplot(pdat2, main = "logger 4, T10,port d", xlab = "time", ylab = "deg C")
    ggsave("T10_logger4_portd_7hrs.png", path=plot_path, plot = p1, width = 6, height = 4, units = "in", dpi = 300)
    ggsave("T10_logger4_portd_75min.png", path=plot_path, plot = p2, width = 6, height = 4, units = "in", dpi = 300)