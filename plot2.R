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

## Plot global active power line graph
print("Generating plot and saving to working directory...")

# create image/open device
png("plot2.png",width = 480, height = 480, units = "px")

plot(data$Date_Time, data$Global_active_power, xlab="", ylab = "Global Active Power (kilowatts)", type="l")

# close device
dev.off()

print("Plot 2 is complete!")