library(dplyr)


human <- read.csv('data/human.csv')
str(human)
dim(human)

human <- mutate(human, gni = as.numeric(gni))

vars <- c('country', 'edu_ratio', 'lab_ratio', 'edu_exp','life_exp','gni', 'mat_mor','adol_birth','parl_perc')
hum_filtered <- select(human, one_of(vars))

hum_all <- hum_filtered[complete.cases(hum_filtered),]
#can be done also by lots of ORs, but it is obvious that the last 6 rows should be removed
hum_all <- hum_all %>% slice(1:155)