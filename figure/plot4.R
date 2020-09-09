

#       Plot 4
#       ------


# Set your working directory
setwd("~/Coursera/Exploratory Data Analysis")

# Create a file for the data
if(!file.exists("./Data")){
  dir.create("./Data")}

# Load the data
data <- read.table("./Data/household_power_consumption.txt", 
                   header = TRUE, 
                   sep = ";",
                   colClasses = c("factor", "factor", "numeric", 
                                  "numeric", "numeric", "numeric", 
                                  "numeric", "numeric", "numeric"), 
                   na.strings = "?")

# Explore the data
names(data)
str(data)

# Coercing the date column to Date class
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# To ensure week days are in english
Sys.setlocale("LC_TIME","C")

# Selecting the dates of the data
data2 <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

# Coercing the time column to POSIXlt
data2$Time <- strptime(paste(data2$Date, data2$Time), "%Y-%m-%d %H:%M:%S")

# Melting the Sub metering columns into one, with values in "Energy"
library(tidyverse)
data3 <- pivot_longer(data2, cols = starts_with("Sub_metering"), 
                      names_to = "Metering", values_to = "Energy")

# Opening the PNG device to create the plot
png("plot4.png")

# Creating the plot
par(mfrow = c(2, 2))

with(data2, plot(Time, 
                 Global_active_power, 
                 ylab = "Global Active Power",
                 xlab = "",
                 type = "l"))

with(data2, plot(Time, 
                 Voltage,
                 xlab = "datetime",
                 type = "l"))
with(data3, 
     plot(Time,
          Energy, 
          type = "n",
          xlab = "",
          ylab = "Energy sub metering"))


with(subset(data3, Metering == "Sub_metering_1"), 
     lines(Time,
           Energy,
           xlab = "",
           type = "l"))

with(subset(data3, Metering == "Sub_metering_2"), 
     lines(Time,
           Energy,
           type = "l",
           xlab = "",
           col = "red"))
with(subset(data3, Metering == "Sub_metering_3"), 
     lines(Time,
           Energy,
           type = "l",
           xlab = "",
           col = "blue"))
legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1),
       bty = "n")

with(data2, plot(Time, 
                 Global_reactive_power, 
                 xlab = "datetime",
                 type = "l"))

# Closing the png device
dev.off()
