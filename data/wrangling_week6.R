# Antti Kääriälä
# 7 Dec 2018
# Data wrangling, week 6

setwd("~/GitHub/IODS-project/data")

library(tidyverse)

#####################
# Wrangling BPRS data
bprs <- as_tibble(read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T))

bprs # data set has 40 rows and 11 variables
str(bprs) 
summary(bprs) # there are 2 types of treatments provided and 
# 20 subjects who get treatments for 8 weeks

# converting categorical variables in to class factor
bprs <- bprs %>%
  mutate(treatment = factor(treatment),
         subject = factor(subject))

# converting to long form
bprs_l <- bprs %>%
  gather(key = week, value = bprs, -treatment, -subject) %>%
  mutate(week = as.integer(substr(week, 5, 5))) %>%
  arrange(treatment, subject) 

bprs_l
summary(bprs_l)

# serious look: there are now variables for treatments (2),
# subjects (20) and week and bprs. difference is that now 
# the data is in long format so that values of bprs are
# observations

# saving data
write_rds(bprs_l, "bprs.rds")

#####################
# Wrangling RATS data
rats <- as_tibble(read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = '\t', header = T))

rats # 16 rows and 13 variables
str(rats)
summary(rats) # 16 indivuduals in 3 groups with several WDs for each subject

# converting categorical variables in to class factor
rats <- rats %>%
  mutate(Group = factor(Group),
         ID = factor(ID))

# converting to long form
rats_l <- rats %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD, 3, 4))) %>%
  select(Group, ID, Time, Weight) %>%
  arrange(Group, ID)

rats_l # now we are down to 4 variables with weight as the observation
summary(rats_l)

# saving data
write_rds(rats_l, "rats.rds")
