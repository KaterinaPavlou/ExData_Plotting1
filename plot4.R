## Load data in data frame
#  assumption: the file is in the current working directory
print("Reading data from file...")
data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", quote ="", na.strings = "?", stringsAsFactors=F) 

## Get data only for the 2007-02-01 to 2007-02-02 interval
print("Preprocessing data...")
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007",names(data))

# convert dates from string to DateTime. 
# add new column and drop old ones
datetime <- paste(data$Date,data$Time)
data$Date_Time <- strptime(datetime, format="%d/%m/%Y %H:%M:%S")
data <- data[,!names(data) %in% c("Date","Time")]

print("Generating plot and saving to working directory...")

# create image/open device
png("plot4.png",width = 480, height = 480, units = "px")

# set canvas to accept 4 plots added per column
par(mfcol = c(2,2))
par(mar = c(4,4,2,2))

with(data,
{
        ## -- global active power plot (top left)
        print("- adding top left plot...")
        plot(Date_Time, Global_active_power, xlab="", ylab = "Global Active Power (kilowatts)", type="l")

        ## -- sub metering plot (bottom left)
        # create empty container plot
        print("- adding bottom left plot...")
        plot(Date_Time,Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
        
        # add the data on the plot        
        points(Date_Time, Sub_metering_1, type="l")
        points(Date_Time, Sub_metering_2, type="l", col = "red")
        points(Date_Time, Sub_metering_3, type="l", col = "blue")
        
        # add legend to sub metering plot
        legend("topright", lwd = 1, lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

        ## -- voltage plot (top right)
        print("- adding top right plot...")
        plot(Date_Time, Voltage, xlab="datetime", ylab = "Voltage", type="l")
        
        ## -- global reactive power plot (bottom right)
        print("- adding bottom right plot...")
        plot(Date_Time, Global_reactive_power, xlab="datetime", ylab = "Global reactive power", type="l")

})

# close device
dev.off()

print("Plot 4 is complete!")