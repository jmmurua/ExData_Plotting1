

#       Plot 2
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

# Opening the PNG device to create the plot
png("plot2.png")

# Creating the plot
with(data2, plot(Time, 
                 Global_active_power, 
                 ylab = "Global Active Power (kilowatts)", 
                 type = "l"))

# Closing the png device
dev.off()
