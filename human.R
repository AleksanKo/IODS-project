##Aleksandra Konovalova, 02.12.19. This is a new script for Chapter 5.
##Link to the original data: https://github.com/AleksanKo/IODS-project/blob/master/data/human.csv

library(dplyr)
library(stringr)

human <- read.csv('data/human.csv')
str(human)
dim(human)

##The data consists of 19 variables and represents human development and gender inequality in different countries.
##country and gni variables are factors, other variables are either numeric or integer. 
##The variables stand for:
# mat_mor - Maternal mortality ratio
# adol_birth - Adolescent birth rate
# parl_perc - Percetange of female representatives in parliament
# edu2F - Proportion of females with at least secondary education
# edu2M - Proportion of males with at least secondary education
# labF - Proportion of females in the labour force
# labM - Proportion of males in the labour force
# edu_ratio = edu2F / edu2M
# lab_ratio = labF / labM

human <- human %>% mutate(gni = str_replace(human$gni, pattern=",", replace ="") %>% as.numeric)

vars <- c('country', 'edu_ratio', 'lab_ratio', 'edu_exp','life_exp','gni', 'mat_mor','adol_birth','parl_perc')
hum_filtered <- select(human, one_of(vars))

hum_all <- filter(hum_filtered,complete.cases(human)==TRUE)

hum_all <- hum_all %>% slice(1:155)
rownames(hum_all) <- hum_all$country
hum_all <- hum_all %>% select(-country)

write.csv(hum_all,'data/human1.csv', row.names = TRUE)