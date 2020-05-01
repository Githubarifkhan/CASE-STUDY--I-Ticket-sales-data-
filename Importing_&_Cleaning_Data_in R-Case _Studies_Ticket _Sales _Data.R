
###---------------  Importing & Cleaning Data in R: Case Studies  -----------------------

#Ticket Sales Data
#MBTA Ridership Data
#World Food Facts
#School Attendance Data
# -------------- Importing the data ----------

df <- read.csv("C:/Users/PRABHAT/Desktop/Data Science R- by Eckovation/Database for R/data uploaded in course/ticket_sales.csv", stringsAsFactors=F)


# -------------- Examining the data ----------

# View dimensions of sales
dim(df)


# Inspect first 6 rows of sales
head(df)


# View column names of sales
names(df)


# ------------- Summarizing the data ----------

# structure of data
str(df)

#  summary of data
summary(df)


library(dplyr)

# glimpse of data
glimpse(df)
View(df)


# ----------- Remove useless info -----------

# Remove the first column of sales because it contains just the row names

df1 <- df[,-1]

# verify

str(df[,1:5])

str(df1[,1:5])

## We don't want the first 4 coumns or the last 15
#first four columns contain internal codes and last fifteen columns - too many missing values.


store <- seq(5,ncol(df1)-15,1)
store


# Subset sales2 using store

df2 <- df1[ ,store]

glimpse(df2)


# ------------------ Separating columns -----------

# the date-time columns has to be split in to date and time

# Load tidyr
library(tidyr)

# ---- Split event_date_time

head(df2$event_date_time)



# seperate(df, colname, vector(new colnames), seperator character)
df3 <- separate(df2, event_date_time, c('event_dt', 'event_time'), sep = " ")



# check new columns
View(df3)


# similarly for "sales_ord_creat_dttm

# Split sales_ord_create_dttm: sales5


head(df3$sales_ord_create_dttm)


df4 <- separate(df3, sales_ord_create_dttm, c('ord_create_dt', 'ord_create_time'), sep = " ")

# check new columns
library(stringr)
col <- str_detect(names(df4),'ord_create')

glimpse(df4[,col])

# ------  we get warnings here, we have to deal with them ----- 


# Define an issues vector
issues <- c(2516, 3863, 4082, 4183)

# Print values of sales_ord_create_dttm
df2$sales_ord_create_dttm[issues]



# Print a well-behaved value of sales_ord_create_dttm
df2$sales_ord_create_dttm[2517]


library(stringr)


#str_detect(string, pattern, negate = FALSE)

# ----------------------------------------------------------------------------------------------

# detect some strings or character by str_detect

data<- c("bam", "damn", "am", "tam", "amma")
data

str_detect(data, "ba")

str_detect(data, "^a")

str_detect(data, "a$")

str_detect(data, "b")

str_detect(data, "[aeiou]")


# Also vectorised over pattern

letters

str_detect("aecfg", letters)



# Returns TRUE if the pattern do NOT match
str_detect(data, "^p", negate = TRUE)



# now we know why str_detect is used for and how to use it, we will apply it to our data


col <- str_detect(names(df3),'event')

glimpse(df3[,col])

# ----------------------------------------------------------------------------------------------

#Identifying dates

# Load stringr
library(stringr)   


# Find columns of df4 containing "dt": date_cols
date_cols <- str_detect(colnames(df4), "dt")


glimpse(df4[,date_cols])

library(lubridate)

# Coerce date columns into Date objects
df4[, date_cols] <- lapply(df4[, date_cols], ymd)


# Check column types
glimpse(df4[,date_cols])


# stringr is loaded so we don't need to load again


# Find date columns (don't change)
date_cols <- str_detect(names(df4), "dt")


# Create logical vectors indicating missing values (don't change)
missing <- lapply(df4[, date_cols], is.na)

missing
# Create a numerical vector that counts missing values: num_missing
num_missing <- sapply(missing, sum)


# Print num_missing
num_missing


# tidyr is loaded, no need to load again


# Combine the venue_city and venue_state columns
df5 <- unite(df4, venue_city_state, venue_city, venue_state, sep = ", ")


# View the head of sales6
head(df5)


head(df5$venue_city_state)


#---------------------------------------------------------------------------------------------


