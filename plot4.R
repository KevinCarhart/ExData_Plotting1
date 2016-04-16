plot4 <- function()
{
# --------------------------------------------------------------------
# Assumption: that your working directory contains household_power_consumption.txt
# --------------------------------------------------------------------
# SECTION 1
# note  - the subsetting code appears redundantly in all four functions
# for plot1, plot2, etc.  It is a bit slow.
# So at the end of this initial block, the subset is saved as electricity_feb_only.csv
# Once you have gone through the subsetting once, you can avoid it for the other three
# by commenting out everything in SECTION 1 except for:
# feb <- read.csv("electricity_feb_only.csv",header=1,sep=",")

a1 <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
SUBSETTABLE_DATE <- as.Date(strptime(a1$Date,"%d/%m/%Y"))
a2 <- cbind(a1,SUBSETTABLE_DATE)
FEBRUARY_ONLY <- subset(a2,(a2$SUBSETTABLE_DATE <= '2007-02-02'))
FEBRUARY_ONLY_2 <- subset(FEBRUARY_ONLY,(FEBRUARY_ONLY$SUBSETTABLE_DATE >= '2007-02-01'))
write.csv(FEBRUARY_ONLY_2,file="electricity_feb_only.csv",row.names=TRUE)
feb <- read.csv("electricity_feb_only.csv",header=1,sep=",")
# --------------------------------------------------------------------

library("dplyr");library("tidyr");library(stringr);library("plyr")
sorted_feb <- (arrange(feb,(SUBSETTABLE_DATE),Time))
sfs <- cbind(sorted_feb,as.matrix(seq(1:2880)))
seq <- as.matrix(seq(1:2880))
sfs <- cbind(sorted_feb,seq)

# the preparation of the data will be useable by all four plots in the panel

par(mfrow=c(2,2))
# Now working on 1/4 which is the same as plot2.png

plot(sfs$seq,sfs$Global_active_power,axes=FALSE,type="l",xlab="",ylab="Global Active Power")
box(which="plot")
axis(1, c(0,1440,2880),c("Thu","Fri","Sat"))
axis(2, c(0,2,4,6),c("0","2","4","6"))

# Now working on 2/4 which is new but similar to 1/4, just with different data over time
plot(sfs$seq,sfs$Voltage,axes=FALSE,type="l",xlab="datetime",ylab="Voltage")
box(which="plot")
axis(1, c(0,1440,2880),c("Thu","Fri","Sat"))
axis(2, c(234,238,242,246),c("234","238","242","246"))

# Now working on 3/4 which is the same as plot3.png

plot(sfs$seq,sfs$Sub_metering_1,axes=FALSE,type="l",xlab="",ylab="Energy sub metering")
points(sfs$seq,sfs$Sub_metering_2,type="l",col="red")
points(sfs$seq,sfs$Sub_metering_3,type="l",col="blue")
box(which="plot")
axis(1, c(0,1440,2880),c("Thu","Fri","Sat"))
axis(2, c(0,10,20,30),c("0","10","20","30"))

# Note: same as in the plot3 code, the legend was cutting off so I padded the strings.  Adjust as necessary.
legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1          ","Sub_metering_2          ","Sub_metering_3          "))

# Now working on 4/4 which is new but similar to 1/4 and 2/4 just with different data over time

plot(sfs$seq,sfs$Global_reactive_power,axes=FALSE,type="l",xlab="datetime",ylab="Global reactive power")
box(which="plot")
axis(1, c(0,1440,2880),c("Thu","Fri","Sat"))
axis(2, c(0.0,0.1,0.2,0.3,0.4,0.5),c("0.0","0.1","0.2","0.3","0.4","0.5"))

dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()





}
