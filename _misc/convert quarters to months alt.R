
setwd("~/Dropbox/Work and research/Port Authority/pathforecast/_misc")
library(zoo) 

jobs = read.csv("./county_employment_202008.csv") 
jobs1 = jobs#[complete.cases(jobs),] 

# IF QUARTERS ARE 'AVERAGE' OF RELEVANT THREE MONTHS (define 'average' later) 
jobs1$X = NULL 
jobs1$X.1 = NULL 

jobs1$Month = as.Date(jobs1$Month, "%m/%d/%y") 
jobs2 = jobs1 

jobs2 = read.zoo(jobs2) # Converts the data frame to a time series matrix 

tt = as.yearmon(seq(start(jobs2), end(jobs2), "month")) # Makes months, different format (unsure why needed) 
zm = as.data.frame(na.spline(jobs2, as.yearmon, xout = tt)) 
zm$month_ = seq(as.Date("1996/1/1"), as.Date("2035/10/01"), by="month") # Add date 


# zm$imports = zm$importTEUs/3 # if it's the sum of three relevant months, not the average 
# zm$exports = zm$exportTEUs/3 # if it's the sum of three relevant months, not the average 
zm2 = subset(zm,zm$month_=="2035-10-01") 
zm3 = subset(zm,zm$month_=="2035-10-01") 
zm2$month_="2035-11-01" 
zm3$month_="2035-12-01" 
zm=rbind(zm,zm2) 
zm=rbind(zm,zm3) 
zm = zm[order(as.Date(zm$month_, format="%Y-%m-%d")),] 

write.csv(zm,"~/Dropbox/Work and research/Port Authority/pathforecast/_misc/county_monthly_202008.csv") 
jobs = zm 
names(jobs) = tolower(names(jobs)) 

