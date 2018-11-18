# Antti KÃ¤Ã¤riÃ¤lÃ¤
# 16 Nov 2018
#
# Data wrangling, week 3
# Preparing student performance data for analysis.
#
# The data can be obatained from here: 
# https://archive.ics.uci.edu/ml/datasets/Student+Performance

setwd("~/GitHub/IODS-project/data")

library(tidyverse)



# reading data
student_mat <- as_tibble(read.csv2("student-mat.csv"))
student_por <- as_tibble(read.csv2("student-por.csv"))

# dimensions and structure of the data
student_mat # the data has 395 rows and 33 variables
student_por # the data has 649 rows and 33 variables

str(student_mat)
str(student_por)



# joining the two data sets
join_by  <- c("school", "sex", "age",
              "address", "famsize", "Pstatus",
              "Medu", "Fedu", "Mjob", "Fjob",
              "reason", "nursery","internet")

math_por <- inner_join(student_mat, student_por,
                      by = join_by)

# selecting only columns joined by
joined_cols <- select(math_por, one_of(join_by))

# names of not joined columns
notjoined_colnames <- 
  names(student_mat)[!names(student_mat) %in% join_by]



# for loop for combining the data from the two data sets
for(column_name in notjoined_colnames) {
  
  two_columns <- select(math_por, starts_with(column_name))
  
  first_column <- select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)) {
    
    joined_cols[column_name] <- round(rowMeans(two_columns))
    
  } else {
    
    joined_cols[column_name] <- first_column
  }
}

glimpse(joined_cols)



# computing variables of alcohol consumption
alc <- joined_cols %>%
  mutate(alc_use = (Dalc + Walc) / 2,
         high_use = alc_use > 2)

alc
glimpse(alc)



# saving the data
write.csv2(alc, "alc.csv")


