# Antti Kääriälä
# 24 Nov 2018
#
# Data wrangling, week 4
# Preparing week 5 data.
#
# The data can be obatained from here: 
# https://archive.ics.uci.edu/ml/datasets/Student+Performance

setwd("~/GitHub/IODS-project/data")

library(tidyverse)

# reading data
hd <- as_tibble(read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", 
               stringsAsFactors = F))

gii <- as_tibble(read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", 
                stringsAsFactors = F, na.strings = ".."))

# dimensions and structure of the data
hd # the data has 195 rows and 8 variables
gii # the data has 195 rows and 10 variables

str(hd)
str(gii)



# renaming variabels
names(hd)
hd <- hd %>%
  rename(hdi_rank = HDI.Rank,
         country = Country,
         hdi = Human.Development.Index..HDI.,
         life_expectancy = Life.Expectancy.at.Birth,
         exp_education = Expected.Years.of.Education,
         mean_education = Mean.Years.of.Education,
         gni = Gross.National.Income..GNI..per.Capita,
         gni_minus_hdi = GNI.per.Capita.Rank.Minus.HDI.Rank)

names(gii)
gii <- gii %>%
  rename(gii_rank = GII.Rank,
         country = Country,
         gii = Gender.Inequality.Index..GII.,
         maternal_mortality = Maternal.Mortality.Ratio,
         teen_births = Adolescent.Birth.Rate,
         repr_w = Percent.Representation.in.Parliament,
         sec_edu_w = Population.with.Secondary.Education..Female.,
         sec_edu_m  = Population.with.Secondary.Education..Male.,
         labor_w = Labour.Force.Participation.Rate..Female.,
         labor_m  = Labour.Force.Participation.Rate..Male.)



# mutating
# sex ratio with secondary education and 
# labor force participation
gii <- gii %>%
  mutate(edu_sex_ratio = sec_edu_w / sec_edu_m,
         labor_sex_ratio = labor_w / labor_m)



# joihing the two data
human <- hd %>%
  inner_join(gii, by = "country")



# saving the data
write.csv2(human, "human.rds")
