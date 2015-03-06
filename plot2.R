#setwd() to the directory where the household_power_consumption.txt file resides
require(sqldf)
file<-c("./household_power_consumption.txt")

#reading rows for dates 1/2/2007 and 2/2/2007 only
data_subset <- read.csv.sql(file, header = T, sep=";", 
                            sql = "select * from file 
                            where (Date == '1/2/2007' OR Date == '2/2/2007')" )
sqldf()#close sql connection

#joining Date and Time columns
dateTime<-paste(data_subset$Date,data_subset$Time)

#subsetting data_sub excluding Date and Time columns
dat_nodatetime<-data_subset[c(-1,-2)]
#joining the dateTime column to the data (without Date and Time)
dat<-cbind(dateTime,dat_nodatetime)

#converting dat$dateTime to Date type POSIXlt
dat$dateTime<-strptime(dat$dateTime,format = "%d/%m/%Y %H:%M:%S")

#drawing the plot in png device
png(filename ="plot2.png",width = 480,height = 480,units = "px")
plot(dat$dateTime,dat$Global_active_power,type = "l",
     ylab = "Global Active Power (kilowatts)",xlab = "")
dev.off()
