############# chapter 5
#############


### what is the index?
### raw seconds since 1970-01-01 UTC
### tclass or indexClass
### tzone or indexTZ

### indexFormat(Z) <- "%b %d, %Y"
### Understanding TZ

### Discrete time offset from UTC (aka greenwich mean time)
### always set your time zone to avoid surprises!
### Sys.setenv(TZ = "America/Chicago")
### Sys.setenv(TZ = "UTC")

### help(OlsonNames) # great read!
### Time via index()
### 

# View the first three indexes of temps
index(temps)[1:3]

# Get the index class of temps
indexClass(temps)

# Get the timezone of temps
tzone(temps)

# Change the format of the time display
indexFormat(temps) <- "%b-%d-%Y"

# View the new format
head(temps)


# Construct times_xts with tzone set to America/Chicago
times_xts <- xts(1:10, order.by = times, tzone = "America/Chicago")

# Change the time zone of times_xts to Asia/Hong_Kong
tzone(times_xts) <- "Asia/Hong_Kong"

# Extract the current time zone of times_xts
tzone(times_xts)


############################################################
# Periods, periodicity, and timestamps
# final topics
# find the time an ojbect covers
# find periods within your object
# account for dupliates and false precision
# periodicity()
# answers what type of data is present
# less useful for irregular timestamps
# 
periodicity(edhec)

# 
periodicity(to.yearly(edhec))

# counting periods
# estimate number of periods
# irregular series equal irregular counting
# counts periods greater than periodicity
# counts periods greater than periodicity

# nseconds()
# nminutes()
# etc.

# modifyint timestamps
# align.time() to round time stamps to another period
# useful to remove observations of duplicate timestamps
# make.index.unique()

# 

# Calculate the periodicity of temps
periodicity(temps)

# Calculate the periodicity of edhec
periodicity(edhec)

# Convert edhec to yearly
edhec_yearly <- to.yearly(edhec)

# Calculate the periodicity of edhec_yearly
periodicity(edhec_yearly)

# Count the months
nmonths(edhec)

# Count the quarters
nquarters(edhec)

# Count the years
nyears(edhec)



# Explore underlying units of temps in two commands: .index() and .indexwday()
.index(temps)
.indexwday(temps)

# Create an index of weekend days using which()
index <- which(.indexwday(temps) == 0 | .indexwday(temps) == 6)

# Select the index
temps[index]


# Make z have unique timestamps
z_unique <- make.index.unique(z, eps = 1e-4)

# Remove duplicate times in z
z_dup <- make.index.unique(z, drop = TRUE)

# Round observations in z to the next hour
z_round <- align.time(z, n = 3600)


# Make z have unique timestamps
z_unique <- make.index.unique(z, eps = 1e-4)

# Remove duplicate times in z
z_dup <- make.index.unique(z, drop = TRUE)

# Round observations in z to the next hour
z_round <- align.time(z, n = 3600)