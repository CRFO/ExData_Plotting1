# Coursera - Exploratory Data Analysis Project 1
# Script: plot4.R
# This script does the following:
# 1. Set directory to Exploratory Data Analysis folder
# 2. Reads household_power_consumption.txt file
# 3. Converts date data and subsets data from dates:"2007-02-01" to 2007-02-02"
# 4. Creates plot4.png file with charts matching the ones included in
# figure/unnamed-chunk-5.png

setwd("/Users/cfoust/Desktop/Coursera/Exploratory Data Analysis")

if(!file.exists("data")){
        dir.create("data")
} 

archive <- paste(getwd(), "./data/household_power_consumption.txt", sep = "")
summary_data <- paste(getwd(), "./data/summary_data.rds", sep = "")
if(!file.exists(summary_data)){
        data <- "./data/household_power_consumption.txt"
        converted_data <- read.table(data, header=TRUE, sep=";", colClasses=c("character", "character", rep("numeric",7)), na.strings="?")
        converted_data$Time <- strptime(paste(converted_data$Date, converted_data$Time), "%d/%m/%Y %H:%M:%S")
        converted_data$Date <- as.Date(converted_data$Date, "%d/%m/%Y")
        dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
        subset_data <- subset(converted_data, Date %in% dates)
        summary_data <- paste(getwd(), "/", "data", "/", "summary_data", ".rds", sep="")
        saveRDS(subset_data, summary_data)
} else {
        data <- "./data/summary_data.rds"
        subset_data <- readRDS(data)
}

png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))	
plot(subset_data$Time, subset_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(subset_data$Time, subset_data$Voltage, type = "l", xlab = "datetime", ylab = "Global Active Power")
plot(subset_data$Time, subset_data$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(subset_data$Time, subset_data$Sub_metering_2, type="l", col="red")
lines(subset_data$Time, subset_data$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2, col=c("black", "red", "blue"))
plot(subset_data$Time, subset_data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Active Power")
dev.off()