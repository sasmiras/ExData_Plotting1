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
#Plot the data
plot(energydata$Global_active_power~energydata$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
#Copy the plot to png
dev.copy(png,"plot2.png", width=480, height=480)
# close the device
dev.off()