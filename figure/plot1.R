

#       Plot 1
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

# Selecting the dates of the data
data2 <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

# Opening the PNG device to create the plot
png(filename = "plot1.png")

# Creating the plot
hist(data2$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
 
# Closing the png device
dev.off()






