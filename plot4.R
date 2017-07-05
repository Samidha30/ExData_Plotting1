# Install necessary package for dmy function
if(!require("lubridate"))
install.packages("lubridate")
library(lubridate)

#reading raw data
data<-read.delim("household_power_consumption.txt",sep=";",stringsAsFactors = F,na.strings = "?")

#Converting Date & Time column in raw data from charater to POSIXlt & POSIXt format
data$Date<-dmy(data$Date)
data$Time<-hms(data$Time)
data$DateAndTime<-data$Date+data$Time

#Extracting the required subset from raw data
data_subset<-subset(data,Date>="2007-02-01" & Date<="2007-02-02")
rm(data)

#Dividing the plot area into a 2*2 matrix
par(mfrow=c(2,2),mar=c(4,4,2,1), oma=c(0,0,2,0))

#Plot 1
with(data_subset,plot(DateAndTime,Global_active_power,type="n",xlab="",ylab= "Global Active Power (kilowatts)"))
lines(data_subset$DateAndTime,data_subset$Global_active_power)

#Plot 2
with(data_subset,plot(DateAndTime,Voltage,type="l",xlab="datetime"))

#Plot 3
with(data_subset,plot(DateAndTime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab = ""))
with(data_subset,lines(DateAndTime,Sub_metering_2,type="l",col="red"))
with(data_subset,lines(DateAndTime,Sub_metering_3,type="l",col="blue"))
legend("topright",col=c("black","red","blue"),lty=1,lwd=2,xjust=1,yjust=1,cex=0.5,text.font = 2,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Plot 4
with(data_subset,plot(DateAndTime,Global_reactive_power,type="l",ylab="Global Reactive Power (kilowatts)",xlab="datetime"))

#Copying the plots from screen device to file device
dev.copy(png,"./figure/plot4.png",width=480,height=480)
dev.off()