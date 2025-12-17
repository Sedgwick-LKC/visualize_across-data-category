###select data, default to therm_v03 from thermo-01_wrangle.r
#table(tdat$logger.number)
#3 = T11, 11/9
#4 = T13, 11/8
#8 = sra80, 11/8
#13 = T10, 11/9
tdat <- therm_v03 ##note data in fahrenheit
  tdat$tempC <- (tdat$temperature_deg.F - 32) *5/9 #new variable, temp in deg C
#get logger sequence for loop
  logger_numbers <- unique(tdat$logger.number) #8 (SRA80),4 (T14),13 (T10), 3 (T11)
#get logger ports for loop
  tcouple_names <- unique(tdat$port)
#to select burn day in loop
  burn_dates <- c(8,8,9,9)
#to associate logger with site in output table
site <- c("SRA80","T13","T10","T11")
#create output data frame
num_rows <- length(logger_numbers) * 4 ##loggers $ 4 tcouples per logger
num_cols <- 8 #columns "site","burn_date","logger","port","tmax","t60","t100","t300"
tc <- length(tcouple_names)
tcouple_stats <- as.data.frame(matrix(NA,nrow = num_rows,ncol=num_cols))
colnames(tcouple_stats) <- c("site","burn_date","logger","port","tmax","t60","t100","t300")
####
##collect temperature statistics for each logger and each thermocouple per logger
  for(i in c(1:length(logger_numbers))){
   tdat1 <- tdat[tdat$logger.number == logger_numbers[i],]
    for(j in c(1:length(tcouple_names))) {
      tcouple_stats[(i-1)* tc + j,1] <- site[i]
      tcouple_stats[(i-1)* tc + j,2] <- burn_dates[i]
      tcouple_stats[(i-1)* tc + j,3] <- logger_numbers[i]
      tcouple_stats[(i-1)* tc + j,4] <- tcouple_names[j]
      tdat2 <- tdat1[tdat1$port == tcouple_names[j],]
      tdat3 <- tdat2[day(tdat2$date.time) == burn_dates[i],6]
      tcouple_stats[(i-1)*tc + j,5] <- max(tdat3)
      tcouple_stats[(i-1)*tc + j,6] <- as.numeric(length(tdat3[tdat3 > 60]) * 3) #3 seconds per obs
      tcouple_stats[(i-1)*tc + j,7] <- as.numeric(length(tdat3[tdat3 > 100]) * 3) #3 secs poer obs
      tcouple_stats[(i-1)*tc + j,8] <- as.numeric(length(tdat3[tdat3 > 300]) * 3) #3 secs per ob
  }
  }
write.csv(tcouple_stats,"stats_out/vmp25_css_tcouple_stats.csv")
