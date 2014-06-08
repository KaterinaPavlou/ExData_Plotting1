## Load data in data frame
#  assumption: the file is in the current working directory
print("Reading data from file...")
data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", quote ="", na.strings = "?", stringsAsFactors=F) 

## Get data only for the 2007-02-01 to 2007-02-02 interval
print("Preprocessing data...")
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007",names(data))

## Plot global active power histogram
print("Generating plot and saving to working directory...")

# create image/open device
png("plot1.png",width = 480, height = 480, units = "px")

hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")

# close device
dev.off()

print("Plot 1 is complete!")
