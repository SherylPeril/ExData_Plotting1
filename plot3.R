## Download the data

if (!file.exists(rawdata.zip)) {
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "rawdata.zip", method = "curl")
	  library(tools)            
	   sink("download_metadata2.txt")
        print("Download date:")
        print(Sys.time() )
        print("Download URL:")
        print(fileUrl)
        print("Downloaded file Information")
        print(file.info(rawdata.zip))
        print("Downloaded file md5 Checksum")
        print(md5sum(rawdata.zip))
        sink()
        }
        
## Unzip the data
        
unzip("rawdata.zip")

## Read the data

power.data <- file.path("household_power_consumption.txt")

PowerData <- read.table(power.data, header = TRUE, sep = ";", na.strings = "?")

## Create a subset of the date period needed

PowerData <- subset(PowerData,Date == "1/2/2007" | Date == "2/2/2007")

## Combine date and time to create a DateTime variable for plotting

PowerData$DateTime <- strptime(paste(PowerData$Date, PowerData$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

## Create plot

png(filename = "plot3.png")

plot(PowerData$DateTime, PowerData$Sub_metering_1, type = "l", bg = "white", ylab = "Energy sub metering", xlab = "")

points(PowerData$DateTime, PowerData$Sub_metering_2, type = "l", col = "red")

points(PowerData$DateTime, PowerData$Sub_metering_3, type = "l", col = "blue")

legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1, col=c("black","red","blue"))

dev.off()

