hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
str(hd)
dim(hd)
str(gii)
dim(gii)
summary(hd)
summary(gii)

# renaming cols
library(tidyverse)
hd <- hd %>% rename(
    hdi_rank = HDI.Rank,
    country = Country,
    hdi = Human.Development.Index..HDI.,
    life_exp = Life.Expectancy.at.Birth,
    exp_edu = Expected.Years.of.Education, 
    mean_edu = Mean.Years.of.Education, 
    gni = Gross.National.Income..GNI..per.Capita, 
    gni_hdi = GNI.per.Capita.Rank.Minus.HDI.Rank
    )

gii <- gii %>% rename(
    gii_rank = GII.Rank,
    country = Country,
    gii = Gender.Inequality.Index..GII.,
    mm_ratio = Maternal.Mortality.Ratio,
    adol_birth = Adolescent.Birth.Rate, 
    parliament = Percent.Representation.in.Parliament, 
    edu_fem = Population.with.Secondary.Education..Female., 
    edu_m = Population.with.Secondary.Education..Male.,
    labour_fem = Labour.Force.Participation.Rate..Female.,
    labour_m = Labour.Force.Participation.Rate..Male.,
    )
# adding new variables
gii <- mutate(gii, edu_ratio = edu_fem / edu_m, labour_ratio = labour_fem / labour_m)

# joining two datasets
human <- inner_join(hd, gii, by = 'country')
dim(human)
write.csv(human, "/Users/anastasia/IODS-project/data/human.csv", row.names = FALSE)





