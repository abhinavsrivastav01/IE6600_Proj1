# Load libraries 
library(dplyr)
library(magrittr)
library(tidyr)

# Please follow these steps to complete this data wrangling provess

## 1: load the time series (ts) data and filter the required columns

data <- read.csv("./Bertha_Proj1_Data/Park_Crime_Merge (1).csv", sep=",", header=T, check.names = FALSE)

data <- data[,(names(data) %in% c("CITY", "PARK_NAME" ,"CENTER_LAT","CENTER_LON"))]

## 2: use the following piece of code to group-by all states data and summarize by counts (sum)

answer1<- data %>%
  group_by(CITY)  %>%
  summarize(LAT=mean(CENTER_LAT), LON=mean(CENTER_LON), count_crimes=n()) %>%
  drop_na()

data <- read.csv("./Bertha_Proj1_Data/park_data_2016_with_census (1).csv", sep=",", header=T, check.names = FALSE)
data <- data[,(names(data) %in% c("CITY", "PARK_NAME", "RPT_ACRES"))]

answer2 <- data %>%
  group_by(CITY)  %>%
  summarize(count_parks=n(), Total_green_area_Acres=sum(RPT_ACRES)) %>%
  drop_na()


answer <- merge(answer1 ,answer2,by="CITY")

## 3: check your results
head(answer)

## 3: save the new data summary into a new *.csv file
write.csv(answer,"clean_1.csv")
