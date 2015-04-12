# Exploratory Data Analysis - Course Project 1 - Notes
# 
# In the initial txt file I ran a reg expression search on 1/2/2007 to find the starting row number for the dates for this inquiry. Then counted the number of instances of this regex and counted the instances of the regex 2/2/2007. Adding them together and adding to the starting row number gave the final row of data that I needed to read in. 
# 
# Also, I'll need the Date column in character format to convert it into Date format once I read in the desired rows of data. I did this by using colClasses="character" for the first two columns and "numeric" for the rest. 
# 
# The beginning of the dataset I want starts at row 66637 and goes to 69516.

        power<-read.csv2("household_power_consumption.txt",dec=".",
                         colClasses=c("character","character","numeric",
                                      "numeric","numeric","numeric","numeric",
                                      "numeric","numeric"),na.strings="?",
                                        nrows=69516)

# Use negative subsetting to to select out the first 66636 rows:

        power2 <- power[-(1:66636),]

# Convert to a dplyr dataframe:

        power2<-tbl_df(power2)

# Combine Date and Time into one column:

        power3<-mutate(power2, DateTime=paste(Date,Time))

# Convert datetime into Date class:

        power3$DateTime<-as.POSIXct(power3$DateTime,format="%d/%m/%Y %H:%M:%S")

# Third Plot
        with(power3,plot(DateTime,Sub_metering_1,type="n",ylab="Energy sub metering",xlab=""))
        with(power3,lines(DateTime,Sub_metering_1))
        with(power3,lines(DateTime,Sub_metering_2,col="red"))
        with(power3,lines(DateTime,Sub_metering_3,col="blue"))
        legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub metering 1","Sub metering 2","Sub metering 3"))

        dev.copy(png, file="plot3.png")
        dev.off()