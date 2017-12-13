# project to read data from .txt file and create a histogram

#Read powerconsumption data 
pwr_cons <- read.table("./exploratory/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
#Format Date to Date Type
pwr_cons$Date <- as.Date(pwr_cons$Date, "%d/%m/%Y")
# Extract data frm 1-Feb'2007 to 2-Feb'2007
energydata <- subset(pwr_cons,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
#Create the Histogram
hist(energydata$Global_active_power,main="Global Active Power",xlab="Global Active Power(kilowatts)",col="red")
#Save the file
dev.copy(png,"plot1.png", width=480, height=480)
#Close the device
dev.off()