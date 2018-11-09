# Antti Kääriälä
# 9 Nov 2018
# Data wrangling, week 2

library(tidyverse)

wrangling <- as.tibble(read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
                                  sep="\t", header=TRUE))

wrangling
str(wrangling)
# Dataset has 183 observations and 60 variables.
# Variables 1-56 have are measured on a Likert scale from 1 to 5.
# Last four variables are respondents age, attitude, points, and gender.

# Computing the variables, 
# filtering those with 0 from Points, and 
# selecting variables
d_analysis <- wrangling %>%
  mutate(deep = (D03 + D11 + D19 + D27 + D07 + 
           D14 + D22 + D30 + D06 + D15 + D23 + D31) / 12,
         stra = (ST01 + ST09 + ST17 + ST25 + 
           ST04 + ST12 + ST20 + ST28) / 8,
         surf = (SU02 + SU10 + SU18 + SU26 + 
           SU05 + SU13 + SU21 + SU29 + SU08 + 
           SU16 + SU24 + SU32) / 12) %>% 
  filter(Points != 0) %>%
  select(gender, Age, Attitude, deep, stra, surf, Points)
d_analysis

# Saving the data
write.table(d_analysis, file = "learning2014.txt")

# Reading the data to see it works
read.table("learning2014.txt")
