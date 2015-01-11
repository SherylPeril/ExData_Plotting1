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

## Convert Global_active_power variable to numeric for plotting

PowerData$Global_active_power <- as.character(PowerData$Global_active_power)

PowerData$Global_active_power <- as.numeric(PowerData$Global_active_power)

## Create plot

png(filename = "plot2.png")


plot(PowerData$DateTime, PowerData$Global_active_power, type = "l", bg = "white", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()

