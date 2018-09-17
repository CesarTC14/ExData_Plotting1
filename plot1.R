## setwd to the folder that contains the unzipped household power consumption dataset

plot1 <- function() {
        data <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
        names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
        png("plot1.png")
        data <- transform(data, Date = as.Date(Date, format = "%d/%m/%Y"), Time = format(strptime(Time, "%H:%M:%S"), "%H:%M:%S"))
        with(data, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
        dev.off()
}