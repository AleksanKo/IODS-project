#Aleksandra Konovalova, 11.11.19. This is a new script for the chapter 2.
library(dplyr)
library(ggplot2)
learning2014 <- read.csv("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
                         sep='\t')
str(learning2014)
#Almost all of the variables are of type 'int'. The only exception is 'gender' column.
dim(learning2014)
#The data consists of 183 rows and 60 columns

deep <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(learning2014, one_of(deep))
learning2014$deep <- rowMeans(deep_columns)

surface_columns <- select(learning2014, one_of(surface))
learning2014$surf <- rowMeans(surface_columns)

strategic_columns <- select(learning2014, one_of(strategic))
learning2014$stra <- rowMeans(strategic_columns)

vars <- c("gender", "Age", "Attitude","Points", "deep", "surf", "stra")
lrn14 <- select(learning2014,one_of(vars))

lrn14 <- lrn14 %>%
  rename(age=Age) %>%
  rename(attitude=Attitude) %>%
  rename(points=Points)

lrn14 <- filter(lrn14,points!=0)

write.csv(lrn14,'data/lrn2014.csv',row.names = FALSE)

summary(lrn14)
g1 <- ggplot(lrn14, aes(x = age, y = points, col = gender)) + geom_point()
show(g1)
