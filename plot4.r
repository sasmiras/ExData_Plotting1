#Project to extract power consumption data and create a plot

#Read powerconsumption data 
pwr_cons <- read.table("./exploratory/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
#Format Date to Date Type
pwr_cons$Date <- as.Date(pwr_cons$Date, "%d/%m/%Y")
# Extract data frm 1-Feb'2007 to 2-Feb'2007
energydata <- subset(pwr_cons,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
# Combine Date and Time and bind it with main dataset
dateTime <- paste(energydata$Date, energydata$Time)
dateTime <- setNames(dateTime, "DateTime")
energydata <- cbind(dateTime, energydata)
energydata$dateTime <- as.POSIXct(dateTime)
#create the plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(energydata, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="datetime")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="datetime")
})
## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()