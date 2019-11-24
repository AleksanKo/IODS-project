##Aleksandra Konovalova, 24.11.19. This is  a new script for Chapter 4.
#Data wrangling exercises for Chapter 5

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
str(hd)
str(gii)
dim(hd)
dim(gii)
summary(hd)
summary(gii)
hd <- hd %>%
  rename(hdi=Human.Development.Index..HDI.) %>%
  rename(life_exp=Life.Expectancy.at.Birth) %>%
  rename(edu_exp=Expected.Years.of.Education) %>%
  rename(edu_mean=Mean.Years.of.Education) %>%
  rename(gni=Gross.National.Income..GNI..per.Capita) %>%
  rename(gni_minus_hdi=GNI.per.Capita.Rank.Minus.HDI.Rank) %>%
  rename(hdi.rank=HDI.Rank) %>%
  rename(country=Country)
str(hd)

gii <- gii %>% 
  rename(gii=Gender.Inequality.Index..GII.) %>%
  rename(mat_mor=Maternal.Mortality.Ratio) %>%
  rename(adol_birth=Adolescent.Birth.Rate) %>%
  rename(parl_perc=Percent.Representation.in.Parliament) %>%
  rename(edu2F=Population.with.Secondary.Education..Female.) %>%
  rename(edu2M=Population.with.Secondary.Education..Male.) %>%
  rename(labF=Labour.Force.Participation.Rate..Female.) %>%
  rename(labM=Labour.Force.Participation.Rate..Male.) %>%
  rename(gii.rank=GII.Rank) %>%
  rename(country=Country)
str(gii)

gii <- mutate(gii, edu_ratio = edu2F/edu2M)
gii <- mutate(gii, lab_ratio = labF/labM)

human <- inner_join(hd,gii,by="country")
write.csv(human,'data/human.csv', row.names = FALSE)