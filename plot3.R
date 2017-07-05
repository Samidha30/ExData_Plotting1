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

#Extracting the required subset of data
data_subset<-subset(data,Date>="2007-02-01" & Date<="2007-02-02")
rm(data)

#plotting
par(mfrow=c(1,1))
with(data_subset,plot(DateAndTime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
with(data_subset,lines(DateAndTime,Sub_metering_2,type="l",col="red"))
with(data_subset,lines(DateAndTime,Sub_metering_3,type="l",col="blue"))
legend("topright",col=c("black","red","blue"),lwd=2,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Copying the plots from screen device to file device
dev.copy(png,"./figure/plot3.png",width=480,height=480)
dev.off()