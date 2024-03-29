library(tidyverse)
library(data.table)

# Reading in CSV files
# You MUST set your working directory to .../wellbeing/Dashboard
# And you MUST have your HMS data csv files in the parent directory of wellbeing
hms17 <- read_csv("../../HMS17.csv")
hms18 <- read_csv("../../HMS18.csv")
hms19 <- read_csv("../../HMS19.csv")
hms20 <- read_csv("../../HMS20_better.csv")

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

# Moving some races to the other category because not all HMS years have the same race columns
hms17 <- hms17 %>% 
  mutate(race_other = ifelse(!is.na(race_ainaan) | !is.na(race_pi) | !is.na(race_mides), 1, NA)) %>% 
  select(-race_ainaan, -race_pi, -race_mides)

# Moving some drug use columns to the other category because not all HMS years have them
hms17 <- hms17 %>% 
  mutate(drug_other = ifelse(!is.na(drug_met) | !is.na(drug_ect) | !is.na(drug_opi), 1, NA)) %>% 
  select(-drug_met, -drug_ect, -drug_opi)

# Adding the vape, exercise, and mental health columns as just NA so that we can select by them for the merge of the data
hms17 <- hms17 %>% 
  mutate(smok_vape = NA,
         smok_vape_mist = NA,
         exerc = NA,
         gad7_1 = NA,
         gad7_2 = NA,
         gad7_3 = NA,
         gad7_4 = NA,
         gad7_5 = NA,
         gad7_6 = NA,
         gad7_7 = NA,
         gad7_impa = NA,
         phq9_1 = NA,
         phq9_2 = NA,
         phq9_3 = NA,
         phq9_4 = NA,
         phq9_5 = NA,
         phq9_6 = NA,
         phq9_7 = NA,
         phq9_8 = NA,
         phq9_9 = NA,
         dep_impa = NA,
         phq2_1 = NA,
         phq2_2 = NA,
         lone_lackcompanion = NA,
         lone_leftout = NA,
         lonesc = NA,
         lone_isolated = NA,
         binge_fr_f = NA,
         binge_fr_m = NA,
         binge_fr_o = NA
         )

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

# Moving some races to the other category because not all HMS years have the same race columns
hms18 <- hms18 %>% 
  mutate(race_other = ifelse(!is.na(race_pi), 1, NA)) %>% 
  select(-race_pi)

# Moving some drug use columns to the other category because not all HMS years have them
hms18 <- hms18 %>% 
  mutate(drug_other = ifelse(!is.na(drug_met), 1, NA)) %>% 
  select(-drug_met)

# Adding the exercise columns as just NA so that we can select by them for the merge of the data
hms18 <- hms18 %>% 
  mutate(exerc = NA,
         lone_lackcompanion = NA,
         lone_leftout = NA,
         lonesc = NA,
         lone_isolated = NA,
         sexual_g = NA,
         belong1 = NA
         )

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

# Moving some drug use columns to the other category because not all HMS years have them
hms19 <- hms19 %>% 
  mutate(drug_other = ifelse(!is.na(drug_met) | !is.na(drug_opi) | !is.na(drug_psilo) | !is.na(drug_ath) | !is.na(drug_keta), 1, NA)) %>% 
  select(-drug_met, -drug_opi, -drug_psilo, -drug_ath, -drug_keta)

# Adding the exercise columns as just NA so that we can select by them for the merge of the data
hms19 <- hms19 %>% 
  mutate(exerc = NA,
         lone_lackcompanion = NA,
         lone_leftout = NA,
         lonesc = NA,
         lone_isolated = NA,
         sexual_g = NA,
         sexual_l = NA
         )

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

# Moving some races to the other category because not all HMS years have the same race columns
hms20 <- hms20 %>% 
  mutate(race_other = ifelse(!is.na(race_ainaan) | !is.na(race_pi), 1, NA)) %>% 
  select(-race_ainaan, -race_pi)

# Moving some drug use columns to the other category because not all HMS years have them
hms20 <- hms20 %>% 
  mutate(drug_other = ifelse(!is.na(drug_ect) | !is.na(drug_psilo) | !is.na(drug_benzo) | !is.na(drug_ath), 1, NA)) %>% 
  select(-drug_ect, -drug_psilo, -drug_benzo, -drug_ath)

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

#############
# Gender ----
#############

# Include gender non binary in the gender queer column for hms20
hms20 <- hms20 %>% 
  mutate(gender_queernc = ifelse(gender_nonbin == 1 | gender_queernc == 1, 1,NA)) %>% 
  select(-gender_nonbin)

# Make one gender column for hms20 rather than a colum for each gender
gender20 <- hms20 %>% 
  select(responseid, gender_male:gender_selfID) %>% 
  pivot_longer(!responseid) %>% 
  drop_na(value) %>% 
  group_by(responseid) %>% 
  summarise(gender = paste0(name, collapse = ", "))

# Adding the gender column to the actual data set
hms20 <- hms20 %>% 
  left_join(gender20, by = "responseid")

# Renaming the gender column data to match with hms20
hms17$gender <- factor(hms17$gender, levels = c(1,2,3,4,5,6),
                       labels = c("gender_male", 
                                  "gender_female", 
                                  "gender_transm",
                                  "gender_transf",
                                  "gender_queernc",
                                  "gender_selfID"))

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

##########################
# Bipolar & OCD HMS18 ----
##########################

# Making one bipolar and one ocd column for hms18 rather than having multiple
hms18 <- hms18 %>% 
  mutate(dx_bip = ifelse(!is.na(dx_bip_1) | !is.na(dx_bip_2) | !is.na(dx_bip_3) 
                         | !is.na(dx_bip_4) , 1,NA)) %>% 
  mutate(dx_ocd = ifelse(!is.na(dx_ocd_1) | !is.na(dx_ocd_2) | !is.na(dx_ocd_3) 
                         | !is.na(dx_ocd_4) | !is.na(dx_ocd_5) | !is.na(dx_ocd_5)
                         , 1,NA)) 

###########################
# Filtering Categories ----
###########################

# Categories to select by:
cats <- c("responseid",
          "schoolYear",
          "classYear",
          "major",
          "age",
          "gender",
          "race_black",
          "race_white",
          "race_asian",
          "race_his",
          "race_other",
          "sexual_h",
          "sexual_g",
          "sexual_l",
          "sexual_bi",
          "sexual_queer",
          "sexual_quest",
          "sexual_other",
          "activ_ac",
          "activ_athv",
          "activ_athc",
          "activ_athi",
          "activ_cs",
          "activ_cu",
          "activ_da",
          "activ_fs",
          "activ_gs",
          "activ_gov",
          "activ_hw",
          "activ_mp",
          "activ_md",
          "activ_rel",
          "activ_soc",
          "activ_art",
          "activ_other",
          "activ_none",
          "sleep_np1",
          "sleep_np2",
          "sleep_wk1",
          "sleep_wk2",
          "sleep_wd1",
          "sleep_wd2",
          "drug_mar",
          "drug_coc",
          "drug_her",
          "drug_stim",
          "drug_other",
          "drug_none",
          "smok_freq",
          "smok_vape",
          "smok_vape_mist",
          "exerc",
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
          "phq2_2",
          "lone_lackcompanion",
          "lone_leftout",
          "lonesc",
          "lone_isolated",
          "fincur",
          "finpast",
          "knowwher",
          "ther_help",
          "ther_helped_me",
          "med_help",
          "meds_helped_me",
          "stig_pcv_1",
          "stig_per_1",
          "international",
          "alc_any",
          "binge_fr_f",
          "binge_fr_m",
          "binge_fr_o",
          "belong1"
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

# Getting just the response IDs for future use
ids <- combined %>% 
  select(responseid)

# Merging the field columns (losing data from those with no fields entered)
race <- combined %>% 
  select(responseid, race_black:race_other) %>%
  rename(White = race_white, Black = race_black, Asian = race_asian,
         Hispanic = race_his, Other = race_other) %>% 
  pivot_longer(!responseid) %>%
  drop_na(value) %>%
  group_by(responseid) %>%
  summarise(race = paste0(name, collapse = ', '))
sexuality <- combined %>% 
  select(responseid, sexual_h:sexual_other) %>% 
  pivot_longer(!responseid) %>% 
  drop_na(value) %>% 
  group_by(responseid) %>% 
  summarise(sexuality = paste0(name, collapse = ', '))

# Adding back the people with no field selected
race <- ids %>% left_join(race, by = "responseid")
sexuality <- ids %>% left_join(sexuality, by = 'responseid')

# Adding the race to the combined dataframe, filtering out NA response ids,
# removing the separate race columns, and making age consistent (22+ is the max)
combined <- combined %>%
  left_join(race, by = "responseid") %>%
  left_join(sexuality, by = 'responseid') %>% 
  filter(!is.na(responseid)) %>%
  select(-race_black,
         -race_asian,
         -race_white,
         -race_his,
         -race_other,
         -sexual_h,
         -sexual_g,
         -sexual_l,
         -sexual_bi,
         -sexual_queer,
         -sexual_quest,
         -sexual_other
         ) %>%
  mutate(age = ifelse(parse_number(age) >= 22, "22+", age))

combined %>% write_csv(file = "../../HMSAll.csv", append = FALSE)