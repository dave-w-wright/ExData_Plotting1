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
png("plot1.png", height=480, width=480)

# Build histogram
hist(spdata$Global_active_power, col='red', 
     xlab = 'Global Active Power (kilowatts)',
     main = 'Global Active Power')

# Close PNG file
dev.off()