# Install necessary package for dmy function
if(!require("lubridate"))
install.packages("lubridate")
library(lubridate)

#reading raw data
data<-read.delim("household_power_consumption.txt",sep=";",stringsAsFactors = F)

#Converting Date & Time column in raw data from charater to POSIXlt & POSIXt format
data$Date<-dmy(data$Date)
data$Time<-hms(data$Time)
data$DateAndTime<-data$Date+data$Time

#Extracting data for 2 days
data_subset<-subset(data,Date>="2007-02-01" & Date<="2007-02-02")
rm(data)

#Converting Global_active_power from character to numeric format
data_subset$Global_active_power<-as.numeric(data_subset$Global_active_power)

#Opening png graphiz device
png("./figure/plot2.png",width=480,height = 480)

#Plotting the required graph
par(mfrow=c(1,1))
with(data_subset,plot(DateAndTime,Global_active_power,type="n",xlab="",ylab= "Global Active Power (kilowatts)"))
lines(data_subset$DateAndTime,data_subset$Global_active_power)
dev.off()
