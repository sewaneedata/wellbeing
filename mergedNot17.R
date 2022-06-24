# lets make a new df of 18- 20 data that includes depression and anxiety data


library(tidyverse)
library(data.table)

# Reading in CSV files
hms18 <- read_csv("C:/Users/temi/Desktop/wellness data/HMS18.csv")
hms19 <- read_csv("C:/Users/temi/Desktop/wellness data/HMS19.csv")
hms20 <- read_csv("C:/Users/temi/Desktop/wellness data/HMS20_better.csv")

############################
# FILTERING HMS 2018/19 ----
############################

# Getting just the response IDs for future use
ids18 <- hms18 %>% 
  select(responseid)

# Merging the field columns (losing data from those with no fields entered)
major18 <- hms18 %>% 
  select(responseid, field_hum:field_other) %>%
  pivot_longer(!responseid) %>%
  drop_na(value) %>%
  group_by(responseid) %>%
  summarise(major = paste0(name, collapse = ', '))

# Adding back the people with no field selected
major18 <- ids18 %>% left_join(major18, by = "responseid")

###########################
# FILTERING HMS 2019/20----
###########################

# Getting just the response IDs for future use
ids19 <- hms19 %>% 
  select(responseid)

# Merging the field columns (losing data from those with no fields entered)
major19 <- hms19 %>% 
  select(responseid, field_hum:field_other) %>%
  pivot_longer(!responseid) %>%
  drop_na(value) %>%
  group_by(responseid) %>%
  summarise(major = paste0(name, collapse = ', '))

# Adding back the people with no field selected
major19 <- ids19 %>% left_join(major19, by = "responseid")

############################
# FILTERING HMS 2020/21 ----
############################

# Getting just the response IDs for future use
ids20 <- hms20 %>% 
  select(responseid)

# Merging the field columns (losing data from those with no fields entered)
major20 <- hms20 %>% 
  select(responseid, field_hum:field_other) %>%
  pivot_longer(!responseid) %>%
  drop_na(value) %>%
  group_by(responseid) %>%
  summarise(major = paste0(name, collapse = ', '))

# Adding back the people with no field selected
major20 <- ids20 %>% left_join(major20, by = "responseid")



##########
# Gender #
##########


# include gender non binary into gender queer for hms20
hms20 <- hms20 %>% 
  mutate(gender_queernc = ifelse(gender_nonbin == 1 | gender_queernc == 1, 1,NA)) %>% 
  select(-gender_nonbin)


# make one gender column for hms20
gender20 <- hms20 %>% 
  select(responseid, gender_male:gender_selfID) %>% 
  pivot_longer(!responseid) %>% 
  drop_na(value) %>% 
  group_by(responseid) %>% 
  summarise(gender = paste0(name, collapse = ", "))


hms20 <- hms20 %>% 
  left_join(gender20, by = "responseid")



hms18$gender <- factor(hms18$gender, levels = c(1,2,3,4,5,6),
                       labels = c("gender_male", 
                                  "gender_female", 
                                  "gender_transm",
                                  "gender_transf",
                                  "gender_queernc",
                                  "gender_selfID"))

hms19$gender <- factor(hms19$gender, levels = c(1,2),
                       labels = c("gender_male", 
                                  "gender_female"))


# work with bipolar and ocd data for hms18
hms18 <- hms18 %>% 
  mutate(dx_bip = ifelse(!is.na(dx_bip_1) | !is.na(dx_bip_2) | !is.na(dx_bip_3) 
                         | !is.na(dx_bip_4) , 1,NA)) %>% 
  mutate(dx_ocd = ifelse(!is.na(dx_ocd_1) | !is.na(dx_ocd_2) | !is.na(dx_ocd_3) 
                         | !is.na(dx_ocd_4) | !is.na(dx_ocd_5) | !is.na(dx_ocd_5)
                         , 1,NA)) 

################################################################################
################################################################################



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


hms18 <- hms18 %>% 
  left_join(major18, by = "responseid") %>% 
  mutate(schoolYear = "18/19") %>% 
  rename(classYear = yr_sch) %>%
  select(cats) %>% 
  mutate(age = as.character(age))

hms19 <- hms19 %>% 
  left_join(major19, by = "responseid") %>% 
  mutate(schoolYear = "19/20") %>% 
  rename(classYear = yr_sch) %>%
  select(cats) %>% 
  mutate(age = as.character(age))

hms20 <- hms20 %>% 
  left_join(major20, by = "responseid") %>% 
  distinct(responseid, .keep_all = TRUE) %>% 
  mutate(schoolYear = "20/21") %>% 
  rename(classYear = yr_sch) %>%
  select(cats) %>% 
  mutate(age = as.character(age))

# Merging the data by the columns
combinedNot17 <- bind_rows(hms18, hms19, hms20)

