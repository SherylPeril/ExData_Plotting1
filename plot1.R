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
unzip("rawdata.zip")

power.data <- file.path("household_power_consumption.txt")

PowerData <- read.table(power.data, header = TRUE, sep = ";", na.strings = "?")

PowerData <- subset(PowerData,Date == "1/2/2007" | Date == "2/2/2007")

library(lubridate)

PowerData$DateTime <- strptime(paste(PowerData$Date, PowerData$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

PowerData$Global_active_power <- as.character(PowerData$Global_active_power)

PowerData$Global_active_power <- as.numeric(PowerData$Global_active_power)

png(filename = "plot1.png")

hist(PowerData$Global_active_power, col = "red", bg = "white", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()

