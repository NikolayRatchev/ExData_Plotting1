# ------------ preliminary activities -------------

# download & unzip file, if it doesn't exist already
if(!file.exists("household_power_consumption.txt")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "Project1_data.zip")
        unzip("Project1_data.zip")
}

# read & check data
data <- read.table("household_power_consumption.txt", header = T, sep = ";",
                   na.strings = "?")

# subset the data needed for the project
data2 <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

# write the project data to file
write.table(data2, file = "ProjectData.txt", 
            sep = ";", row.names = F, quote = F)

# remove the large original data
rm(data)

# concatenate date & time 
data2$datetime <- paste(data2$Date, data2$Time)

# convert datetime to POSIXlt
data2$datetime <- strptime(data2$datetime, format = "%d/%m/%Y%H:%M:%S")


# -------------- plot 4 ------------------

# set locale to English
Sys.setlocale("LC_ALL", "English")



# open device
png(file = "plot4.png")


# set plotting parameters
par(mfrow = c(2, 2), mar = c(4, 4, 3, 2)) 

# plot[1,1]
with(data2, plot(datetime, Global_active_power, type = "l", 
                 xlab = "", ylab = "Global Active Power (kilowatts)"))

# plot[1,2]
with(data2, plot(datetime, Voltage, type = "l"))

# plot[2,1]
with(data2, {
        plot(datetime, Sub_metering_1, type = "l", 
             xlab = "", ylab = "Energy sub metering")
        lines(datetime, Sub_metering_2, type = "l", col = "red")
        lines(datetime, Sub_metering_3, type = "l", col = "blue")
        legend("topright", cex = .8, bty = "n", legend = names(data2)[7:9], 
               col = c("black", "red", "blue"), lty = "solid", border = NULL)
})

# plot[2,2]
with(data2, plot(datetime, Global_reactive_power, type = "l"))

# close device
dev.off()

# show file
file.show("plot4.png")
