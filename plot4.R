# Read in all the data and grab the 2 days in February 2007 we need
pdata <- read.table('./household_power_consumption.txt', sep=';', header=T, 
                    colClasses = c('character', 'character', 'numeric',
                                   'numeric', 'numeric', 'numeric',
                                   'numeric', 'numeric', 'numeric'),
                    na.strings='?')
pdata$DateTime <- strptime(paste(pdata$Date, pdata$Time), 
                           "%d/%m/%Y %H:%M:%S")
spdata <- subset(pdata, 
                 as.Date(DateTime) >= as.Date("2007-02-01") & 
                         as.Date(DateTime) <= as.Date("2007-02-02"))

# Create the .png output file
png("plot4.png", height=480, width=480)

# set up for multi-plot
par(mfrow=c(2,2))

# Plot the Global Active Power
plot(spdata$DateTime, 
     spdata$Global_active_power, 
     pch=NA, 
     xlab="", 
     ylab="Global Active Power (kilowatts)")
lines(spdata$DateTime, spdata$Global_active_power)

# Plot the Voltage
plot(spdata$DateTime, spdata$Voltage, ylab="Voltage", xlab="datetime", pch=NA)
lines(spdata$DateTime, spdata$Voltage)

# Plot Sub-metering
plot(spdata$DateTime, 
     spdata$Sub_metering_1, 
     pch=NA, 
     xlab="", 
     ylab="Energy sub metering")
lines(spdata$DateTime, spdata$Sub_metering_1)
lines(spdata$DateTime, spdata$Sub_metering_2, col='red')
lines(spdata$DateTime, spdata$Sub_metering_3, col='blue')
legend('topright', 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c('black', 'red', 'blue'),
       bty = 'n')

# Plot Global reactive power
with(spdata, plot(DateTime, Global_reactive_power, xlab='datetime', pch=NA))
with(spdata, lines(DateTime, Global_reactive_power))

# Close PNG file
dev.off()