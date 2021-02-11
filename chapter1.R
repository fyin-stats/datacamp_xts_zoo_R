#############
#############
## course: manipulating time series data in R
#############
# chapter 1
#############
#############
#############
ipak <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
        install.packages(new.pkg, dependencies = TRUE)
    sapply(pkg, require, character.only = TRUE)
}
packages <- c("dplyr", "tidyr","ggplot2","astsa","xts","lubridate","PerformanceAnalytics")
ipak(packages)

# what is xts?
# extensible time series, designed to make time series easy
# An extended zoo object
# matrix + index
# observations + times

# XTS = Matrix + index
# 
x <- matrix(1:4, nrow = 2, ncol = 2)
x
# 
idx <- as.Date(c("2015-01-01", "2015-02-01"))

# class
# Date, POSIX times, timeDate, chron, ...
# 

# xts constructor
X <- xts(x, order.by = idx)
X

# tzone: time zone
# unique: forces times to be unique
# index is in increasing order of time

# special xts behavior
# xts is a matrix with associated times for each observation
# subsets preserve matrix form

# attributes are preserved
# i.e., a time stamp that was acquired

# xts is a subclass of zoo, therefore you get the properties of zoo for free

# Deconstructing xts
# extract raw data, raw times
# coredata(x) is used to extract the data component
# index(x) to extract the index aka times


# xts: More than a matrix
# 

# Load xts
library(xts)

# View the structure of ex_matrix
str(ex_matrix)

# Extract the 3rd observation of the 2nd column of ex_matrix
ex_matrix[3, 2]

# Extract the 3rd observation of the 2nd column of core 
core[3, 2]

# Create the object data using 5 random numbers
data <- rnorm(5)

# Create dates as a Date class object starting from 2016-01-01
dates <- seq(as.Date("2016-01-01"), length = 5, by = "days")

# Use xts() to create smith
smith <- xts(x = data, order.by = dates)

# Create bday (1899-05-08) using a POSIXct date class object
bday <- as.POSIXct("1899-05-08")

# Create hayek and add a new attribute called born
hayek <- xts(x = data, order.by = dates, born = bday)

# Extract the core data of hayek
hayek_core <- coredata(hayek)

# View the class of hayek_core
class(hayek_core)

# Extract the index of hayek
hayek_index <- index(hayek)

# View the class of hayek_index
class(hayek_index)



#
# Create dates
dates <- as.Date("2016-01-01") + 0:4

# Create ts_a
ts_a <- xts(x = 1:5, order.by = dates)

# Create ts_b
ts_b <- xts(x = 1:5, order.by = as.POSIXct(dates))

# Extract the rows of ts_a using the index of ts_b
ts_a[index(ts_a)]

# Extract the rows of ts_b using the index of ts_a
ts_b[index(ts_b)]



# 
# Reality check
# data usually already exists and needs wrangling
# often data isn't your preferred class

# data needs to be imported into R and converted to xts
# you will convert, read and export xts objects
# 

# converting using as.xts()
# xts is designed to make working with multiple different time series objects easy
# 
data(sunspots)
class(sunspots) # ts object
# 
sunspots_xts <- as.xts(sunspots)
class(sunspots_xts)
# xts, zoo
# 
head(sunspots_xts)



# Read data into R using built-in functions
# read.table()
# read.csv()
# read.zoo()

# exporting xts from R
# write.zoo()
# write.zoo(x, "file")

# write.zoo for external use (i.e., text files)

# use saveRDS for R use, fast to read and write to the disk

# 
# Convert austres to an xts object called au
au <- as.xts(austres)

# Then convert your xts object (au) into a matrix am
am <- as.matrix(au)

# Inspect the head of am
head(am)

# Convert the original austres into a matrix am2
am2 <- as.matrix(austres)

# Inspect the head of am2
head(am2)


#
# Create dat by reading tmp_file
dat <- read.csv(tmp_file)

# Convert dat into xts
xts(dat, order.by = as.Date(rownames(dat), "%m/%d/%Y"))

# Read tmp_file using read.zoo
dat_zoo <- read.zoo(tmp_file, index.column = 0, sep = ",", format = "%m/%d/%Y")

# Convert dat_zoo to xts
dat_xts <- as.xts(dat_zoo)


# Convert sunspots to xts using as.xts().
sunspots_xts <- as.xts(sunspots)

# Get the temporary file name
tmp <- tempfile()

# Write the xts object using zoo to tmp 
write.zoo(sunspots_xts, sep = ",", file = tmp)

# Read the tmp file. FUN = as.yearmon converts strings such as Jan 1749 into a proper time class
sun <- read.zoo(tmp, sep = ",", FUN = as.yearmon)

# Convert sun into xts. Save this as sun_xts
sun_xts <- as.xts(sun)