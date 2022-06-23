library(tidyverse)
library(data.table)

# Reading in CSV files
hms17 <- read_csv("./HMS17.csv")
hms18 <- read_csv("./HMS18.csv")
hms19 <- read_csv("./HMS19.csv")
hms20 <- read_csv("./HMS20_better.csv")

#################################################
# ROWS THAT DON'T HAVE A RESPONSE ID 2017/18 ----
#################################################

# Filter by NA responseid
# toMelt17 <- as.data.table(hms17 %>% filter(is.na(responseid)))
# Combine every column into three
# melted17 <- data.table::melt(toMelt17, id.vars = "responseid", measure.vars = 2:523)
# Filter by only non-NA values
# melted17 %>% filter(!is.na(value))

#################################################
# ROWS THAT DON'T HAVE A RESPONSE ID 2018/19 ----
#################################################

# Filter by NA responseid
# toMelt18 <- as.data.table(hms18 %>% filter(is.na(responseid)))
# Combine every column into three
# melted18 <- data.table::melt(toMelt18, id.vars = "responseid", measure.vars = 2:659)
# Filter by only non-NA values
# melted18 %>% filter(!is.na(value))

#################################################
# ROWS THAT DON'T HAVE A RESPONSE ID 2019/20 ----
#################################################

# Filter by NA responseid
# toMelt19 <- as.data.table(hms19 %>% filter(is.na(responseid)))
# Combine every column into three
# melted19 <- data.table::melt(toMelt19, id.vars = "responseid", measure.vars = 2:643)
# Filter by only non-NA values
# melted19 %>% filter(!is.na(value))

#################################################
# ROWS THAT DON'T HAVE A RESPONSE ID 2020/21 ----
#################################################

# Filter by NA responseid
# toMelt20 <- as.data.table(hms20 %>% filter(is.na(responseid)))
# Combine every column into three
# melted20 <- data.table::melt(toMelt20, id.vars = "responseid", measure.vars = 2:1068)
# Filter by only non-NA values
# melted20 %>% filter(!is.na(value))

############################
# FILTERING HMS 2017/18 ----
############################

# Getting just the response IDs for future use
ids17 <- hms17 %>% 
  select(responseid)

# Merging the field columns (losing data from those with no fields entered)
major17 <- hms17 %>% 
  select(responseid, field_hum:field_other) %>%
  pivot_longer(!responseid) %>%
  drop_na(value) %>%
  group_by(responseid) %>%
  summarise(major = paste0(name, collapse = ', '))

# Adding back the people with no field selected
major17 <- ids17 %>% left_join(major17, by = "responseid")

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

# Categories to select by:
cats <- c("schoolYear",
          "classYear",
          "age",
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
          # "dx_bip",
          "dx_anx",
          # "dx_ocd",
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
          "ther_ever"
          # "gad7_1",
          # "gad7_2",
          # "gad7_3",
          # "gad7_4",
          # "gad7_5",
          # "gad7_6",
          # "gad7_7",
          # "gad7_impa"
          # "phq9_1",
          # "phq9_2",
          # "phq9_3",
          # "phq9_4",
          # "phq9_5",
          # "phq9_6",
          # "phq9_7",
          # "phq9_8",
          # "phq9_9",
          # "phq9_impa",
          # "phq2_1",
          # "phq2_2"
          )

# Selecting only the columns we want
hms17 <- hms17 %>% 
  left_join(major17, by = "responseid") %>% 
  mutate(schoolYear = "17/18") %>% 
  rename(classYear = yr_sch) %>%
  select(cats) %>% 
  mutate(age = as.character(age))

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
combined <- bind_rows(hms17, hms18, hms19, hms20)