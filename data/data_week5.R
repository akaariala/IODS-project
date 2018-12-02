# Antti Kääriälä
# 24 Nov 2018
# Data wrangling, week 5

setwd("~/GitHub/IODS-project/data")

library(tidyverse)

# reading data
human <- readRDS("human.rds")

# keep these variables
keep <- c("country", "edu_sex_ratio", "labor_sex_ratio",
          "exp_education", "life_expectancy", "gni",
          "maternal_mortality", "teen_births", "repr_w")

# keep these rows
last <- nrow(human) - 7

# data manipulation
human_ <- human %>%
  mutate(gni = str_replace(gni, pattern=",", replacement =""),
         gni = as.numeric(gni)) %>%
  select(one_of(keep)) %>%
  filter(between(row_number(), 1, last)) %>%
  drop_na() %>% 
  as.data.frame() %>%
  column_to_rownames(var = "country") 

# saving data
write_rds(human_, "human.rds")


