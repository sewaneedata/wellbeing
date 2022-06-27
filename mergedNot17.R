# Lets make a new data frame for 2018 to 2020 data that includes depression and anxiety data
# HMS17 doesn't include in depth depression and anxiety questions

library(tidyverse)
library(data.table)

# Reading in CSV files
hms18_2 <- read_csv("./HMS18.csv")
hms19_2 <- read_csv("./HMS19.csv")
hms20_2 <- read_csv("./HMS20_better.csv")

############################
# FILTERING HMS 2018/19 ----
############################

# Getting just the response IDs for future use
ids18_2 <- hms18_2 %>% 
  select(responseid)

# Merging the field columns (losing data from those with no fields entered)
major18_2 <- hms18_2 %>% 
  select(responseid, field_hum:field_other) %>%
  pivot_longer(!responseid) %>%
  drop_na(value) %>%
  group_by(responseid) %>%
  summarise(major = paste0(name, collapse = ', '))

# Adding back the people with no field selected
major18_2 <- ids18_2 %>% left_join(major18_2, by = "responseid")

###########################
# FILTERING HMS 2019/20----
###########################

# Getting just the response IDs for future use
ids19_2 <- hms19_2 %>% 
  select(responseid)

# Merging the field columns (losing data from those with no fields entered)
major19_2 <- hms19_2 %>% 
  select(responseid, field_hum:field_other) %>%
  pivot_longer(!responseid) %>%
  drop_na(value) %>%
  group_by(responseid) %>%
  summarise(major = paste0(name, collapse = ', '))

# Adding back the people with no field selected
major19_2 <- ids19_2 %>% left_join(major19_2, by = "responseid")

############################
# FILTERING HMS 2020/21 ----
############################

# Getting just the response IDs for future use
ids20_2 <- hms20_2 %>% 
  select(responseid)

# Merging the field columns (losing data from those with no fields entered)
major20_2 <- hms20_2 %>% 
  select(responseid, field_hum:field_other) %>%
  pivot_longer(!responseid) %>%
  drop_na(value) %>%
  group_by(responseid) %>%
  summarise(major = paste0(name, collapse = ', '))

# Adding back the people with no field selected
major20_2 <- ids20_2 %>% left_join(major20_2, by = "responseid")

#############
# Gender ----
#############

# Include gender non binary in the gender queer column for hms20
hms20_2 <- hms20_2 %>% 
  mutate(gender_queernc = ifelse(gender_nonbin == 1 | gender_queernc == 1, 1,NA)) %>% 
  select(-gender_nonbin)

# Make one gender column for hms20 rather than a colum for each gender
gender20_2 <- hms20_2 %>% 
  select(responseid, gender_male:gender_selfID) %>% 
  pivot_longer(!responseid) %>% 
  drop_na(value) %>% 
  group_by(responseid) %>% 
  summarise(gender = paste0(name, collapse = ", "))

# Adding the gender column to the actual data set
hms20_2 <- hms20_2 %>% 
  left_join(gender20_2, by = "responseid")

# Renaming the gender column data to match with hms20
hms18_2$gender <- factor(hms18_2$gender, levels = c(1,2,3,4,5,6),
                       labels = c("gender_male", 
                                  "gender_female", 
                                  "gender_transm",
                                  "gender_transf",
                                  "gender_queernc",
                                  "gender_selfID"))

hms19_2$gender <- factor(hms19_2$gender, levels = c(1,2),
                       labels = c("gender_male", 
                                  "gender_female"))

##########################
# Bipolar & OCD HMS18 ----
##########################

# Making one bipolar and one ocd column for hms18 rather than having multiple
hms18_2 <- hms18_2 %>% 
  mutate(dx_bip = ifelse(!is.na(dx_bip_1) | !is.na(dx_bip_2) | !is.na(dx_bip_3) 
                         | !is.na(dx_bip_4) , 1,NA)) %>% 
  mutate(dx_ocd = ifelse(!is.na(dx_ocd_1) | !is.na(dx_ocd_2) | !is.na(dx_ocd_3) 
                         | !is.na(dx_ocd_4) | !is.na(dx_ocd_5) | !is.na(dx_ocd_5)
                         , 1,NA)) 

###########################
# Filtering Categories ----
###########################

# Categories to select by:
cats <- c("schoolYear",
          "classYear",
          "age",
          "gender",
          "diener1",
          "diener2",
          "diener3",
          "diener4",
          "diener5",
          "diener6",
          "diener7",
          "diener8",
          "diener_score",
          "dx_dep",
          "dx_bip",
          "dx_anx",
          "dx_ocd",
          "dx_trauma",
          "dx_neurodev",
          "dx_ea",
          # "dx_other",
          "dx_none",
          "dx_dk",
          "aca_impa",
          "talk1_1",
          "talk1_2",
          "talk1_3",
          "talk1_4",
          "talk1_5",
          "talk1_6",
          "talk1_7",
          "talk1_8",
          "talk1_8_text",
          "talk1_9",
          "ther_ever",
          "gad7_1",
          "gad7_2",
          "gad7_3",
          "gad7_4",
          "gad7_5",
          "gad7_6",
          "gad7_7",
          "gad7_impa",
          "phq9_1",
          "phq9_2",
          "phq9_3",
          "phq9_4",
          "phq9_5",
          "phq9_6",
          "phq9_7",
          "phq9_8",
          "phq9_9",
          "dep_impa",
          "phq2_1",
          "phq2_2"
)

# Selecting only the columns we want
hms18_2 <- hms18_2 %>% 
  left_join(major18_2, by = "responseid") %>% 
  mutate(schoolYear = "18/19") %>% 
  rename(classYear = yr_sch) %>%
  select(cats) %>% 
  mutate(age = as.character(age))

hms19_2 <- hms19_2 %>% 
  left_join(major19_2, by = "responseid") %>% 
  mutate(schoolYear = "19/20") %>% 
  rename(classYear = yr_sch) %>%
  select(cats) %>% 
  mutate(age = as.character(age))

hms20_2 <- hms20_2 %>% 
  left_join(major20_2, by = "responseid") %>% 
  distinct(responseid, .keep_all = TRUE) %>% 
  mutate(schoolYear = "20/21") %>% 
  rename(classYear = yr_sch) %>%
  select(cats) %>% 
  mutate(age = as.character(age))

# Merging the data by the columns
combined_2 <- bind_rows(hms18_2, hms19_2, hms20_2)