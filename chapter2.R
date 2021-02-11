##################
##################
# chapter 2
##################
##################

# introducing time based queries using xts
# xts suppots international standard for date and time
# ISO 8601:2004
# dates, times, etc. represented in an imambiguous way
# left to right from most to least significant digit
# "YYYY-MM-DDTHH:MM:SS" format
# "2014" OK
# "02" not Ok
# xts support of ISO 8601:2004
# one and two sided intervals "2004" & "2001/2015"
# truncated representation "201402/03"
# time support "2014-02-22 08:30:00"
# repeating intervals "T08:00/T09:00"
# one and two sided intervals

# load fund data
# 
data(edhec, package = "PerformanceAnalytics")

# 
head(edhec["2007-01", 1])

# 
head(edhec["2007-01/2007-03", 1])

# January 2007 to March
# 
head(edhec["200701/03", 1])

# time support
formatiday["20160808T2213"]

# repeating intraday intervals
iday["T05:30/T06:30"] # only examine time intervals

# 
# "2005-01-02"
# "200501"
# Exactly! ISO-8601 may seem like a complex format, but it is very flexible as long as you follow the rules. 


# Select all of 2016 from x
x_2016 <- x["2016-01/2016-12"]

# Select January 1, 2016 to March 22, 2016
jan_march <- x["2016-01-01/2016-03-22"]

# Verify that jan_march contains 82 rows
82 == length(x["2016-01-01/2016-03-22"])


# 
# Extract all data from irreg between 8AM and 10AM
morn_2010 <- irreg["T08:00/T10:00"] # morn_2010 is an object of class xts, zoo

# Extract the observations in morn_2010 for January 13th, 2010
morn_2010["2010-01-13"]


# Alternative extraction techniques
# integer indexing
x[c(1,2,3), ]

# logical vectors
x[index(x) > "2016-08-20"]

# Date objects (Date, POSIXct, etc.)
dates <- as.POSIXct(c("2016-06-25", "2016-06-27"))

#
x[dates]


# modifying time series
# same flexibility as subsetting
# ISO 8601, integers, logicals, and date objects
# which.i = TRUE creates an integer vector corresponding to times
# 
index <- x["2007-06-26/2007-06-28", which.i=TRUE]
# all subsets preserve matrix (drop = FALSE)
# order is preserved


# binary search and memcpy are faster than base R
# index and xts attributes are preserved

# 
# Subset x using the vector dates
x[dates]

# Subset x using dates as POSIXct
x[as.POSIXct(dates)]


# Replace the values in x contained in the dates vector with NA
x[dates] <- NA

# Replace all values in x for dates starting June 9, 2016 with 0
x["2016-06-09/"] <- 0

# Verify that the value in x for June 11, 2016 is now indeed 0
x["2016-06-11"]


# methods to find periods in your data
# head and tail
# xts implements 2 similar functions with respect to time 
# uses a flexible notion of time
# last 3 days or first 6 weeks
# first() and last()
# n can also be an integer
# n=10, n=2, etc.

# first and last can be nested for internal intervals
# used to find start or end periods within others
# 
first(last(edhec[,"Merger Arbitrage"], "2 years"), "5 months")

# 
# Create lastweek using the last 1 week of temps
lastweek <- last(temps, "1 week")

# Print the last 2 observations in lastweek
last(lastweek, n=2)

# Extract all but the first two days of lastweek
first(lastweek, "-2 days")

# Extract the first three days of the second week of temps
first(last(first(temps, "2 weeks"), "1 week"), "3 days")



# math operations using xts
# key features: xts is naturally a matrix
# xts is naturally a matrix
# math operations are on the intersection of times
# only these intersections will be used
# sometimes it is necessry to drop the xts class
# argument: drop = TRUE, coredata(), as.numeric()

# special handling required for union of dates
# x, y
# out of the box ops (+, -, *, /)
# 

# operations on the union
# may be neccessary to use all observations
# 
x_union <- merge(x, index(y), fill = 0)
y_union <- merge(y, index(x), fill = 0)
x_union + y_union

# 
# Add a and b
a + b

# Add a with the numeric value of b
a + as.numeric(b)


# Add a to b, and fill all missing rows of b with 0
a + merge(b, index(a), fill = 0)

# Add a to b and fill NAs with the last observation
a + merge(b, index(a), fill = na.locf)