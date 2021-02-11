#####################
########## chapter 4
#####################

# aggregate time series

### apply functions by time
### apply by period
### period.apply extends R's apply functions to time

### finding endpoints
### defined as the index of the last observation per interval
### 
endpoints(x, on = "years") # return the last index within each year
### always starts on zero and ends on the last observation
### 

### period.apply
### endpoints
### period.apply()

### apply.monthly()
### apply.yearly()
### apply.quarterly()

### split data into chunks by time
### split.xts()
### great control for discrete periods
### uses standard period names

### split(x, f = "months")
### edhec.qtrs <- split(edhec[,1], f = "quarters")
### edhec.qtrs[[3]]

### 

# Locate the weeks
endpoints(temps, on = "weeks")

# Locate every two weeks
endpoints(temps, on = "weeks", k = 2)


### 

# Calculate the weekly endpoints
ep <- endpoints(temps, on = "weeks")

# Now calculate the weekly mean and display the results
period.apply(temps[, "Temp.Mean"], INDEX = ep, FUN = mean)


# Split temps by week
temps_weekly <- split(temps, f = "weeks")

# Create a list of weekly means, temps_avg, and print this list
temps_avg <- lapply(X = temps_weekly, FUN = mean)
temps_avg


# Use the proper combination of split, lapply and rbind
temps_1 <- do.call(rbind, lapply(split(temps, "weeks"), function(w) last(w, n = "1 day")))

# Create last_day_of_weeks using endpoints()
last_day_of_weeks <- endpoints(temps, on = "weeks")

# Subset temps using last_day_of_weeks 
temps_2 <- temps[last_day_of_weeks]

###########################################################
###########################################################
# converting periodicity
# useful to convert a univariate series to range bars
# OHLC: Open, High, Low, and Close

# Summaty of a particular period
# starting, maximum, minimum, and ending value
# to.period(x, period = "months", k = 1, indexAt, name = NULL, OHLC = TRUE)


# period controls aggregation period
# name string renames column roots
# indexAt allows for index alignment

# Aggregates OHLC

# to.period(edhec["1997/2001",1], "years", name = "EDHEC", indexAt = "firstof")
# You can aggregate without range bars
# 

# Convert usd_eur to weekly and assign to usd_eur_weekly
usd_eur_weekly <-  to.period(usd_eur, period = "weeks")

# Convert usd_eur to monthly and assign to usd_eur_monthly
usd_eur_monthly <- to.period(usd_eur, period = "months")

# Convert usd_eur to yearly univariate and assign to usd_eur_yearly
usd_eur_yearly <- to.period(usd_eur, period = "years", OHLC = FALSE)

# Convert eq_mkt to quarterly OHLC
mkt_quarterly <- to.period(eq_mkt, period = "quarters")

# Convert eq_mkt to quarterly using shortcut function
mkt_quarterly2 <- to.quarterly(eq_mkt, name = "Equity Market Neutral", indexAt = "firstof")





# rolling functions
# rolling windows
# discrete, continuous
# "2016-01", "2016-02", ...
# split() break up by period
# lapply, cumulative functions
# cumsum(), cumprod(), cummin(), cummax()
# 

# 
x <- xts(c(1,2,3), as.Date("2016-01-01") + 0:2)
#
cbind(x, cumsum(x))

# discrete rolling windows

# each year's year-to-date 
# continuous rolling windows
# rollapply(data, width, FUN, ..., by = 1, by.column = TRUE, )
# rollapply(edhec["200701/08", 1], 3, mean)
#

# Split edhec into years
edhec_years <- split(edhec , f = "years")

# Use lapply to calculate the cumsum for each year in edhec_years
edhec_ytd <- lapply(edhec_years, FUN = cumsum)

# Use do.call to rbind the results
edhec_xts <- do.call(rbind, edhec_ytd)

# Use rollapply to calculate the rolling 3 period sd of eq_mkt
eq_sd <- rollapply(eq_mkt, 3, sd)