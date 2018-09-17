## setwd to the folder that contains the unzipped household power consumption dataset

plot3 <- function() {
        library(dplyr)
        library(lubridate)
        data <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
        names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
        data <- tbl_df(transform(data, Date = as.Date(Date, format = "%d/%m/%Y"), Time = format(strptime(Time, "%H:%M:%S"), "%H:%M:%S")))
        data <- mutate(data, datetime = ymd_hms(paste(data$Date, data$Time)))
        png("plot3.png")
        plot(data$Sub_metering_1~data$datetime, type = "n", xlab = "", ylab = "Energy sub metering")
        lines(data$Sub_metering_1~data$datetime)
        lines(data$Sub_metering_2~data$datetime, col = "red")
        lines(data$Sub_metering_3~data$datetime, col = "blue")
        legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1), col = c("black", "red", "blue"))
        dev.off()
}