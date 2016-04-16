plot1 <- function()
{
# --------------------------------------------------------------------
# Assumption: that your working directory contains household_power_consumption.txt
# --------------------------------------------------------------------
# SECTION 1
# note  - the subsetting code appears redundantly in all four functions
# for plot1, plot2, etc.  It takes a few moments to reduce the file.
# So at the end of this initial block, the subset is saved as electricity_feb_only.csv
# Once you have gone through the subsetting once, you can then run ONLY THIS:
# feb <- read.csv("electricity_feb_only.csv",header=1,sep=",")
# instead of having the delay four times

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
cbind(sorted_feb,as.matrix(seq(1:2880)))
sfs <- cbind(sorted_feb,as.matrix(seq(1:2880)))
seq <- as.matrix(seq(1:2880))
sfs <- cbind(sorted_feb,seq)

hist(sfs$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()




}
