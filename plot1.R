# Install necessary package for dmy function
if(!require("lubridate"))
install.packages("lubridate")
library(lubridate)

#reading raw data
data<-read.delim("household_power_consumption.txt",sep=";",stringsAsFactors = F)

#Converting Date column in raw data from charater to Date format
data$Date<-dmy(data$Date)

#Extracting data for 2 days
data_subset<-subset(data,Date>="2007-02-01" & Date<="2007-02-02")
rm(data)

#Converting Global_active_power from character to numeric format
data_subset$Global_active_power<-as.numeric(data_subset$Global_active_power)

#Opening png graphiz device
png("./figure/plot1.png",width=480,height = 480)

#Plotting the required graph
par(mfrow=c(1,1))
hist(data_subset$Global_active_power/1000,col="red",xlab = "Global Active Power (kilowatts)",ylab = "Frequency",main ="Global Active Power")
dev.off()