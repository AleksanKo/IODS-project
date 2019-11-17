#Aleksandra Konovalova, 17.11.19. This is new script for the chapter 3.
library(dplyr)
library(ggplot2)
stumat <- read.csv("data/student-mat.csv", sep=';')
stupor <- read.csv("data/student-por.csv", sep=';')

str(stumat)
dim(stumat)
str(stupor)
dim(stupor)

join_var <-c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")
math_por <- inner_join(stumat, stupor, by = join_var)
str(math_por)
dim(math_por)

colnames(math_por)
# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_var))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(stumat)[!colnames(stumat) %in% join_var]

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
glimpse(alc) 

alc$alc_use <-rowMeans(select(alc, ends_with('alc')))
alc <- mutate(alc, high_use = alc_use > 2) 

write.csv(alc,"data/alc.csv", row.names = FALSE)
write.csv(math_por,"data/math_por.csv", row.names = FALSE)
