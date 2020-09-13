## Assignment 1 - Exploratory Data Analysis

## C) Emilio Gonzalez, September 2020.

library(dplyr)

## The goal of this script is to create a plot with data on household energy
## consumption.

# Read input file

## Get data from the Internet (if not already done)
if (!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./data/household_power_consumption.zip")){
    print("Downloading zip")
    download.file(fileUrl,"./data/household_power_consumption.zip",method="curl")
}
if(!file.exists("./data/household_power_consumption.txt")){
    print("Unzipping data")
    unzip("./data/household_power_consumption.zip",exdir="./data")
}
# 2,075,259 rows and 9 columns take approximately
# 2,075,259 x 9 x 8 bytes/numeric = 149,418,648 bytes = 142.5 Mb
# We'll do a little memory check before loading the file in memory:

if(memory.limit() > 2*142.5){
    
    data <- read.table("./data/household_power_consumption.txt",sep=";",
                       header=TRUE,na.strings="?",
                       colClasses=c("character","character",rep("numeric",7)))
    
    # Keeps only data from the two specified days
    data<-filter(data,data$Date %in% c("1/2/2007","2/2/2007"))
    
    # Keep the date and time in a single variable of type POSIXlt
    data<-mutate(data,datetime=strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"),
                 .keep="unused")
    
    # Open graphical device
    png(filename="plot2.png",width=480, height=480, units="px")
    
    # Plot exploratory graph
    print("Plotting graphic in file plot2.png")
    plot(data$datetime,data$Global_active_power,type="l",xlab="",
         ylab="Global Active Power (kilowatts)")
    
    # Close graphical device
    dev.off()
    
}else{
    # if no memory...
    print("Out of memory")
}