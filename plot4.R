## setwd to the folder that contains the unzipped household power consumption dataset

plot4 <- function() {
        library(dplyr)
        library(lubridate)
        data <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
        names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
        data <- tbl_df(transform(data, Date = as.Date(Date, format = "%d/%m/%Y"), Time = format(strptime(Time, "%H:%M:%S"), "%H:%M:%S")))
        data <- mutate(data, datetime = ymd_hms(paste(data$Date, data$Time)))
        png("plot4.png")
        par(mfrow = c(2,2))
        
        #graph1
        plot(data$Global_active_power~data$datetime, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
        lines(data$Global_active_power~data$datetime)
        
        #graph2
        plot(data$Voltage~data$datetime, type = "n", xlab = "datetime", ylab = "Voltage")
        lines(data$Voltage~data$datetime)
        
        #graph3
        plot(data$Sub_metering_1~data$datetime, type = "n", xlab = "", ylab = "Energy sub metering")
        lines(data$Sub_metering_1~data$datetime)
        lines(data$Sub_metering_2~data$datetime, col = "red")
        lines(data$Sub_metering_3~data$datetime, col = "blue")
        legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1), col = c("black", "red", "blue"))
        
        #graph4
        plot(data$Global_reactive_power~data$datetime, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
        lines(data$Global_reactive_power~data$datetime)
        
        dev.off()
}