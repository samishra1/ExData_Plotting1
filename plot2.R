##Choose a working directory and setwd
##Download the source file to this directory

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="data.zip")
unzip("data.zip")

##Extract the zip file to the current directory
pwr <- read.csv("household_power_consumption.txt", sep=";", header = T)

##Create new columns with combined date and time
pwr$Datetime <- paste(pwr$Date, pwr$Time, sep = " ")

##Set Datetime as time format
pwr$Dttm <- strptime(pwr$Datetime, "%d/%m/%Y %H:%M:%S")

##Set pwr$date as date format
pwr$Date <- as.Date(pwr$Date, '%d/%m/%Y')

##Limit data to 2007-02-01 and 2007-02-02
pwr1 <- subset(pwr, pwr$Date == as.Date("2007/02/01", "%Y/%m/%d"))
pwr2 <- subset(pwr, pwr$Date == as.Date("2007/02/02", "%Y/%m/%d"))
pwr3 <- rbind(pwr1, pwr2)

## Create Plot 2
png(filename = "plot2.png",
    width = 480, height = 480, units = "px",
    pointsize = 12, bg = "white")
with(pwr3, plot(Dttm, as.numeric(Global_active_power)/1000, type = "l", xlab = "Datetime", ylab = "Global Active Power (kilowatts)"))

dev.off()
