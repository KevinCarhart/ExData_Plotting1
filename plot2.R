plot2 <- function()
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
 
plot(sfs$seq,sfs$Global_active_power,axes=FALSE,type="l",xlab="",ylab="Global Active Power (kilowatts)")
box(which="plot")
axis(1, c(0,1440,2880),c("Thu","Fri","Sat"))
axis(2, c(0,2,4,6),c("0","2","4","6"))
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()



}
