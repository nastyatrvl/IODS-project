# Anastasiia Sorokina 03.12.2019

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", 
                   sep  =" ", header = T)

names(BPRS)
str(BPRS)
summary(BPRS)

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", 
                   sep  ="", header = T)

names(RATS)
str(RATS)
summary(RATS)

library(dplyr)
library(tidyr)
# convert to factor
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
RATSL <-  RATS %>% gather(key = times, value = rats, -ID, -Group)

# extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5, 5)))
RATSL <-  RATSL %>% mutate(time = as.integer(substr(times,3, 4)))
glimpse(BPRSL)
glimpse(RATSL)

names(BPRSL)
str(BPRSL)
summary(BPRSL)

names(RATSL)
str(RATSL)
summary(RATSL)

write.csv(BPRSL, "/Users/anastasia/IODS-project/data/BPRSL.csv", row.names = FALSE)
write.csv(RATSL, "/Users/anastasia/IODS-project/data/RATSL.csv", row.names = FALSE)

# The long dataset separates the unit of analysis (treatment-subject-week) into seven separate variables:
# treatment-subject FOR EACH week separately
# The wide dataset combines one of the keys (week) with the value variable (treatment-subject).

