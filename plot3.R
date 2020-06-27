## Download csv and read it into a data frame


plot3 <- function () {
  library(dplyr)
  library(datasets)
  
  if (!file.exists("data")) {
    dir.create("data") 
  }
  
  if (!file.exists("./data/ePowerC.zip")) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, destfile = "./data/ePowerC.zip", method = "curl")
    date_downloaded = date()
  }
  
  ## reading data 
  mydf <- read.csv(unzip("./data/ePowerC.zip", "household_power_consumption.txt"), sep=";", header = TRUE, na.strings = "?")
  
  ## change column types and substract rows
  mydf$Time <- paste(mydf$Date, mydf$Time, sep=" ")
  mydf$Time <- as.POSIXct(strptime(mydf$Time, format = "%d/%m/%Y %H:%M:%S"))
  mydf$Date <- as.Date(mydf$Date, format ="%d/%m/%Y")
  mydf <- filter(mydf, mydf$Date >= "2007-02-01" & mydf$Date <= "2007-02-02")
  
  ## create plot 
  png(file ="plot3.png")
  plot(mydf$Time, mydf$Sub_metering_1, type="l", ylab="Energy sub metering", xlab=" " )
  lines(mydf$Time, mydf$Sub_metering_2, col="red")
  lines(mydf$Time, mydf$Sub_metering_3, col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1:1)
  
  dev.off()
  
  
}
