################
################
### chapter 3
################
################

# merging time series
# merge()

# combine series by column
# cbind()
# merge()
# database style joins on index 
# inner, outer, left and right joins

# merge(..., fill = NA, join = "outer")

# default join = "outer"
# merge(x, y)

# merge(x, y, join = "inner")

# merge(x, y, join = "right", fill = na.locf)

# 
merge(x, c(2,3,4))

# 
merge(x, 3)

# 
merge(x, as.Date(c("2016-08-14")))

# introducing rbind()

# combine series by row

# rows are inserted in time order

# all rows in rbind() must have a time

# the number of columns must match

# rbind() example

# rbind(x, as.integer(y)) # rbind only accepts time series

# 

# Perform an inner join of a and b
merge(a, b, join = "inner")

# Perform a left-join of a and b, fill missing values with 0
merge(a, b, join = "left", fill = 0)

# 

# Row bind temps_june30 to temps, assign this to temps2
temps2 <- rbind(temps, temps_june30)

# Row bind temps_july17 and temps_july18 to temps2, call this temps3
temps3 <- rbind(temps_july17, temps_july18, temps2)


################################################
########################## handling missingness
################################################

# fill NAs with last observations: last observation carried forward (locf)
# na.locf(object, na.rm = TRUE, fromLast = FALSE, maxgap = Inf)
# cbind(z, na.locf(z), na.locf(z, fromLast = TRUE))


# other NA options
# replace NAs
# na.fill(object, fill, ...)

# remove NAs
# na.trim
# na.omit

# interpolate NAs
# zoo provides a function to interpolate NAs
# na.approx()

# na.fill(z, fill = -999)
# na.trim(z)

# na.omit(z)

# NA interpolation
# na.approx() # linearly approximate the missing values
# 

# Fill missing values in temps using the last observation
temps_last <- na.locf(temps)

# Fill missing values in temps using the next observation
temps_next <- na.locf(temps, fromLast = TRUE)

# Seasonality and stationarity
# Seasonality is a repeating pattern
# Stationarity refers to some bounds of the series

# these patterns are often compared

# Lagging a time series
# used to align time series for comparisons
# lag() will shift observations in time

# k controls number of lags
# lag(x, k=1, na.pad = TRUE) # na.pad controls NA introduction
# with xts, positive k shifts values forward

# differencing series
# convert levels to changes (i.e., deltas)
# diff(x, lag = 1, differences = 1, arithmetic = TRUE, log = FALSE, na.pad = TRUE)
# lag controls which observations
# arithmetric vs log calculations
# 

# Create a leading object called lead_x
lead_x <- lag(x, k = -1)

# Create a lagging object called lag_x
lag_x <- lag(x, k = 1)

# Merge your three series together and assign to z
z <- merge(lead_x, x, lag_x)


# 
# Calculate the first difference of AirPass using lag and subtraction
diff_by_hand <- AirPass - lag(AirPass)

# Use merge to compare the first parts of diff_by_hand and diff(AirPass)
merge(head(diff_by_hand), head(diff(AirPass)))

# Calculate the first order 12 month difference of AirPass
diff(AirPass, lag = 12, differences = 1)

# Exactly! xts follows the literature, while zoo continues with the norms of base-R. 
# The k argument in zoo uses positive values for shifting past observations forward.