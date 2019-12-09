#Aleksandra Konovalova, 09.12.19. This is a new script for the chapter 6.

library(dplyr)
library(tidyr)

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = T, sep = '\t')

write.csv(BPRS,'data/BPRS.csv',row.names = FALSE)
write.csv(RATS,'data/RATS.csv',row.names = FALSE)

#looking at BPRS data
names(BPRS)
str(BPRS)
summary(BPRS)

#looking at RATS data
names(RATS)
str(RATS)
summary(RATS)

#transforming categorical variables to factors: BPRS
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

#transforming categorical variables to factors: RATS
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#converting data to long form: BPRS
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

#converting data to long form: RATS
RATSL <- RATS %>%
  gather(key = "WD", value = "Weight", -ID, -Group)

#Add a week variable: BPRSL
BPRSL <- BPRSL %>% mutate(week = as.integer(substr(weeks, 5,7)))

#Add a Time variable: RATSL
RATSL <- RATS %>% mutate(Time = as.integer(substr(WD, 3,5))) 

glimpse(BPRSL)
glimpse(RATSL)

summary(BPRSL)
summary(RATSL)

write.csv(BPRSL,'data/BPRSL.csv',row.names = FALSE)
write.csv(RATSL,'data/RATSL.csv',row.names = FALSE)

#In the wide data, the subject's data is stored in the one row. In the long data, the subject's data is distributed between many rows. 
#For example, in BPRS there are only 40 observations that describe 2 types of treatment for each of 20 subjects. 
#In BPRSL, there are 360 observations: 180 for each type of treatment. 
#The long data makes it easier to analyze and to cluster longitudinal data, because the rows can be easily clustered by the value of the corresponding time variable and the overall result (changes etc) can be shown more easily.
