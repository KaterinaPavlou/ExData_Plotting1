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

## Plot sub metering 
print("Generating plot and saving to working directory...")

# create image/open device
png("plot3.png",width = 480, height = 480, units = "px")

with(data,
{
        # create empty container plot
        plot(Date_Time,Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
        
        # add the data on the plot        
        points(Date_Time, Sub_metering_1, type="l")
        points(Date_Time, Sub_metering_2, type="l", col = "red")
        points(Date_Time, Sub_metering_3, type="l", col = "blue")
        
        # add legend to sub metering plot
        legend("topright", lwd = 1, lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

# close device
dev.off()

print("Plot 3 is complete!")