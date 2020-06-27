## Download csv and read it into a data frame


plot1 <- function () {
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
  png(file ="plot1.png")
  hist(mydf$Global_active_power, col ="red", main = "Global Active Power", xlab="Global Active Power (kilowats)")
  dev.off()
  
  return(mydf)
}
