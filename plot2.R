## setwd to the folder that contains the unzipped household power consumption dataset

plot2 <- function() {
        library(dplyr)
        library(lubridate)
        data <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
        names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
        data <- tbl_df(transform(data, Date = as.Date(Date, format = "%d/%m/%Y"), Time = format(strptime(Time, "%H:%M:%S"), "%H:%M:%S")))
        data <- mutate(data, datetime = ymd_hms(paste(data$Date, data$Time)))
        png("plot2.png")
        plot(data$Global_active_power~data$datetime, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
        lines(data$Global_active_power~data$datetime)
        dev.off()
}