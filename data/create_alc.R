# Anastasiia Sorokina 13.11.2019
# Student Performance Dataset (https://archive.ics.uci.edu/ml/datasets/Student+Performance)
# The data are from two identical questionaires related to secondary school student alcohol comsumption in Portugal.
# Data wrangling
library(dplyr)
library(ggplot2)
student.mat <- read.csv("~/IODS-project/data/student-mat.csv", sep=";")
str(student.mat)
dim(student.mat)

student.por <- read.csv("~/IODS-project/data/student-por.csv", sep=";")
str(student.por)
dim(student.por)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(student.mat, student.por, by = join_by, suffix=c( ".math", ".por"))

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(student.mat)[!colnames(student.mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

dim(alc)
glimpse(alc)

write.csv(alc, "/Users/anastasia/IODS-project/data/alc.csv", row.names = FALSE)


