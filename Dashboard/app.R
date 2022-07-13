## app.R ##

# loading libraries
library(shiny)
library(shinydashboard)
library(dashboardthemes)
library(ggplot2)
library(ggthemes)
library(rlang)
library(readr)
library(tidyverse)
library(RColorBrewer)
library(plotly)
library(shinyalert)

# getting combined data
# source("../merged.R")
HMS <- read_csv("../../HMSAll.csv")

# color-blind palette:

cbPalette <- c("#009E73", "#CC79A7", "#E69F00", "#56B4E9",
               "#999999","#F0E442", "#0072B2", "#D55E00", "#000000")

# Renaming column names so they look more official on the dashboard :)
HMS <- HMS %>% 
  rename(Race = race, Gender = gender, International = international,
         `Class Year` = classYear, `School Year` = schoolYear,
         `Depression Question 1` = phq9_1, `Depression Question 2` = phq9_2,
         `Depression Question 3` = phq9_3, `Depression Question 4` = phq9_4,
         `Depression Question 5` = phq9_5, `Depression Question 6` = phq9_6,
         `Depression Question 7` = phq9_7, `Depression Question 8` = phq9_8,
         `Depression Question 9` = phq9_9, `Anxiety Question 1` = gad7_1,
         `Anxiety Question 2` = gad7_2, `Anxiety Question 3` = gad7_3,
         `Anxiety Question 4` = gad7_4, `Anxiety Question 5` = gad7_5,
         `Anxiety Question 6` = gad7_6, `Anxiety Question 7` = gad7_7,
         `Diagnosed Depression` = dx_dep, `Diagnosed Anxiety` = dx_anx,
         `Feeling Isolated` = lone_isolated, 
         `Lacking Companionship` = lone_lackcompanion, 
         `Feeling Leftout` = lone_leftout, Exercise = exerc, 
         `Alcohol Use` = alc_any, `Therapy Use` = ther_ever, 
         `Varsity Athletics` = activ_athv, `Greek Life` = activ_fs,
         `Smoking Frequency` = smok_freq, Vaping = smok_vape,
         `Well-being Question 1` = diener1, `Well-being Question 2` = diener2,
         `Well-being Question 3` = diener3, `Well-being Question 4` = diener4,
         `Well-being Question 5` = diener5, `Well-being Question 6` = diener6,
         `Well-being Question 7` = diener7, `Well-being Question 8` = diener8,
         `Knowledge of Services` = knowwher)

# changing the international column from 0 and 1 to 'No' and 'Yes" respectively
HMS$International <- factor(HMS$International, levels = c(0,1),
                            labels = c('No', 'Yes'))


# changing the values of the activ columns from 'NA' and 1 to 0 and 1
HMS <- HMS %>% 
  mutate(`Varsity Athletics` = ifelse(is.na(`Varsity Athletics`), 0, `Varsity Athletics`)) %>% 
  mutate(`Greek Life` = ifelse(is.na(`Greek Life`), 0, `Greek Life`)) 

# changing the following column values from numerical values to their 
# character respective values
HMS$`Varsity Athletics` <- factor(HMS$`Varsity Athletics`, levels = c(0, 1),
                                  labels = c('No', 'Yes'))

HMS$`Greek Life` <- factor(HMS$`Greek Life`, levels = c(0, 1),
                           labels = c('No', 'Yes'))

HMS$`Alcohol Use` <- factor(HMS$`Alcohol Use`, levels = c(0, 1),
                            labels = c('Yes', 'No'))

HMS$`Smoking Frequency` <- factor(HMS$`Smoking Frequency`, 
                                  levels = c(1, 2, 3, 4, 5),
                                  labels = c('0 cigarettes', 
                                             'Less than 1 cigarette',
                                             '1 to 5 cigarettes', 
                                             'About one-half pack',
                                             '1 or more packs'))

HMS$Vaping <- factor(HMS$Vaping, levels = c(1, 2),
                     labels = c('Yes', 'No'))


# changing the academic impairment values from numerical to characters
HMS$aca_impa <- factor(HMS$aca_impa, levels = c(1, 2, 3, 4),
                       labels = c('None', '1 to 2 Days', 
                                  '3 to 5 Days', '6 or more Days'))


# making every race that has less than 6 people grouped into 'race_other'
HMS <- HMS %>%
  group_by(Race) %>%
  filter(!is.na(Race)) %>%
  mutate(total = n()) %>%
  ungroup() %>%
  mutate(Race = ifelse(total <= 5, 'race_other', Race))

# Created new lgbtq+ column from gender and sexuality, then moved trans into
# respective gender category
HMS <- HMS %>%
  filter(!is.na(Gender), !is.na(sexuality)) %>%
  mutate( `LGBTQ+` = ifelse(!(((Gender == 'gender_male' |
                                  Gender == 'gender_female')) &
                                (sexuality == 'sexual_h')), 1, 0)) %>%
  mutate(Gender = ifelse(Gender == 'gender_transm', 'gender_male', Gender),
         Gender = ifelse(Gender == 'gender_transf', 'gender_female', Gender),
         Gender = ifelse(grepl(", ", Gender), "gender_selfID", Gender))

HMS <- HMS %>% 
  mutate(Gender = ifelse(Gender == 'gender_female', 'Woman Identified',
                         ifelse(Gender == 'gender_male', 'Man Identified',
                                ifelse(Gender == 'gender_queernc', 
                                       'Queer/Nonconforming',
                                       'Self Identified'))))

# creating a mental Illness column in HMS using left_join

MI <- HMS %>% 
  select(responseid, `Diagnosed Depression`:dx_ea) %>% 
  pivot_longer(!responseid) %>% 
  drop_na(value) %>% 
  filter(value == 1) %>% 
  group_by(responseid) %>% 
  mutate(mentalIllness = 1) %>% 
  select(responseid, mentalIllness) %>% 
  distinct(responseid, mentalIllness)

HMS <- HMS %>% 
  left_join(MI, by = "responseid") %>% 
  mutate(mentalIllness = ifelse(is.na(mentalIllness), 0, mentalIllness))

HMS$mentalIllness <- factor(HMS$mentalIllness, levels = c(0, 1),
                            labels = c('No Mental Illness', 
                                       'Has Mental Illness'))

# changing the LGBTQ column from 0 and 1 to 'No' and 'Yes" respectively
HMS$`LGBTQ+` <- factor(HMS$`LGBTQ+`, levels = c(0,1),
                       labels = c('No', 'Yes'))


# changing class year from a range of numbers, to their respective values
HMS$`Class Year` <- factor(HMS$`Class Year`, 
                           levels = c(1, 2, 3, 4, 5),
                           labels = c('1st Year', "2nd Year",
                                      '3rd Year', '4th Year',
                                      '5th Year'))
HMS$Exercise <- factor(HMS$Exercise, levels = c(1, 2, 3, 4, 5, 6),
                       labels = c('Strongly Agree', 'Agree', 'Somewhat Agree',
                                  'Somewhat Disagree', 'Disagree', '
                                  Strongly Disagree'))
HMS$`Therapy Use` <- factor(HMS$`Therapy Use`, levels = c(1, 2, 3, 4),
                            labels = c('No, never',
                                       'Yes,\n prior to starting college',
                                       'Yes,\n since starting college', 
                                       'Yes,\n prior to college\n and since starting college)'))

HMS$`Knowledge of Services` <- factor(HMS$`Knowledge of Services`,
                                      levels = c(1, 2, 3, 4, 5, 6),
                                      labels = c('Strongly agree',
                                                 'Agree',
                                                 'Somewhat agree',
                                                 'Somewhat disagree',
                                                 'Disagree',
                                                 'Strongly disagree'))


# create a column of diener scores         
HMS <- HMS %>% 
  mutate(diener_status= 
           case_when(diener_score>49~'Highly Satisfied',
                     diener_score>42~'Satisfied',
                     diener_score>35~'Generally Satisfied',
                     diener_score>28~'Slightly Dissatisfied',
                     diener_score>21~'Dissatisfied',
                     diener_score>7~'Extremely Dissatisfied',
           )) %>%
  mutate( diener_status = factor( diener_status, levels = 
                                    c('Extremely Dissatisfied',
                                      'Dissatisfied',
                                      'Slightly Dissatisfied',
                                      'Generally Satisfied',
                                      'Satisfied',
                                      'Highly Satisfied'
                                    )))

# creating a new Sleep column:

Sleep <- HMS %>%
  select(responseid, sleep_wk1, sleep_wk2, sleep_wd2, sleep_wd1) %>%
  mutate(hrs_sleep_wkday =
           abs(as.numeric(sleep_wk1) - as.numeric(sleep_wd1)))%>%
  mutate(hrs_sleep_wkend =
           abs(as.numeric(sleep_wk2) - as.numeric(sleep_wd2)))%>%
  mutate(Sleep =
           ((hrs_sleep_wkend + hrs_sleep_wkday) / 2))%>%
  mutate(Sleep = ifelse(Sleep > 10, 'More than 10 hours', 
                        ifelse(Sleep < 6, 'Less than 6 hours', 
                               '6 to 10 hours'))) %>% 
  select(responseid, Sleep)

HMS <- HMS %>%
  left_join(Sleep, by = 'responseid')

# creating a new binge column in HMS
binge <- HMS %>% 
  select(responseid, binge_fr_f:binge_fr_o) %>% 
  pivot_longer(!responseid) %>%  
  filter(!is.na(value)) %>% 
  group_by(responseid) %>% 
  mutate(`Binge Drinking` = value) %>%  
  distinct(responseid, `Binge Drinking`)

HMS <- HMS %>% 
  left_join(binge, by = "responseid")

HMS$`Binge Drinking` <- factor(HMS$`Binge Drinking`, levels = c(1, 2, 3, 4, 5, 6, 7),
                               labels = c('None', 'Once', 'Twice', '3 to 5 times',
                                          '6 to 9 times', '10 or more times',
                                          "Don't know"))

# creating a drug use column in HMS
drug <- HMS %>% 
  select(responseid, drug_mar:drug_other) %>% 
  pivot_longer(!responseid) %>%  
  filter(!is.na(value)) %>% 
  group_by(responseid) %>% 
  mutate(`Drug Use` = value) %>%  
  distinct(responseid, `Drug Use`)

HMS <- HMS %>% 
  left_join(drug, by = "responseid") %>% 
  mutate(`Drug Use` = ifelse(is.na(`Drug Use`), 0, `Drug Use`))

HMS$`Drug Use` <- factor(HMS$`Drug Use`, levels = c(0, 1),
                         labels = c('No', 'Yes'))

behaviors <- HMS %>% 
  select('Sleep', 'Exercise', `Therapy Use`,`Varsity Athletics`, 
         `Greek Life`, `Knowledge of Services`)

substance_behaviors <- HMS %>% 
  select(`Alcohol Use`, `Binge Drinking`, `Smoking Frequency`, 
         'Vaping', `Drug Use`)

phqQuestions <- c('Little interest or pleasure in doing things' = 
                    '`Depression Question 1`',
                  'Feeling down, depressed or hopeless' = 
                    "`Depression Question 2`",
                  'Trouble falling or staying asleep, or sleeping too much' =
                    '`Depression Question 3`',
                  'Feeling tired or having little energy' = 
                    '`Depression Question 4`',
                  'Poor appetite or overeating' = 
                    '`Depression Question 5`',
                  'Feeling bad about yourself—or that you are a failure 
                  or have let yourself or your family down' = 
                    '`Depression Question 6`',
                  'Trouble concentrating on things, such as reading the 
                  newspaper or watching television' = 
                    '`Depression Question 7`',
                  'Moving or speaking so slowly that other people could have 
                  noticed; or the opposite—being so fidgety or restless that 
                  you have been moving around a lot more than usual' = 
                    '`Depression Question 8`',
                  'Thoughts that you would be better off dead or of hurting 
                  yourself in some way' = 
                    '`Depression Question 9`')
flourQues <- HMS %>% 
  select(`Well-being Question 1`: `Well-being Question 8`)

phqQues <- HMS %>% 
  select(`Depression Question 1`:`Depression Question 9`)

gadQues <- HMS %>% 
  select(`Anxiety Question 1`:`Anxiety Question 7`)

ment4_variables <- HMS %>% 
  select(`Diagnosed Depression`, `Diagnosed Anxiety`,
         `Feeling Isolated`, `Lacking Companionship`, `Feeling Leftout`)

flourishing_varibales <- HMS %>% 
  select(  diener_score, Exercise, `Therapy Use`, 
           ther_help, ther_helped_me, `Smoking Frequency`,
           Vaping,binge_fr_f, binge_fr_m,binge_fr_o, `Greek Life`, activ_athc, 
           activ_athi,sleep_wk1, sleep_wk2, Sleep, sleep_wd2,activ_cu,
           activ_art,drug_mar, drug_coc, drug_stim, drug_other,drug_none, 
           drug_her)

demographics <- HMS %>%
  select('Race', 'Gender', 'International', 
         `Class Year`, `School Year`, `LGBTQ+`)

demographics1 <- HMS %>%
  select('Race', 'Gender', 'International', 
         `Class Year`, `LGBTQ+`)

###############################################################################
###################################### ui #####################################
###############################################################################
ui <- dashboardPage(
  
  # title of dashboard
  dashboardHeader(
    title = "Cracking the Code to Student Flourishing",
    titleWidth = 400
    
  ),
  
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      
      # titles and icons of sidebar 'tabs'
      menuItem(
        "Home", tabName = "Home", icon = icon("home")
      ),
      
      
      menuItem(
        "Student Mental Health", tabName = 'Mental_Health',
        icon = icon('brain'),
        menuItem('Mental Health Trends', tabName = 'section1'),
        menuItem('Mental Health Correlations', tabName = 'section2')
      ),
      
      menuItem(
        "Student Flourishing", tabName = "Well_being",
        icon = icon("leaf"),
        menuItem('Flourishing Trends', tabName = 'section3'),
        menuItem('Flourishing Correlations', tabName = 'section4')
      ),
      
      menuItem("Key Findings", tabName = 'key', icon = icon('key', 
                                                            class = NULL,
                                                            lib = 'font-awesome')),
      menuItem(
        "About", tabName = 'About', icon = icon('question')
      )
      
    )
    
  ),
  
  ## Body content
  dashboardBody(
    
    shinyDashboardThemes(theme = "poor_mans_flatly"),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
    ),
    
    tabItems( 
      
      # First tab content
      tabItem(
        tabName = "Home",
        h2("Cracking the Code to Student Flourishing"),
        hr(),
        # the problem
        fluidRow(
          column(4,
                 tags$img(
                   src = "HMN-logo.png",
                   width = "100%",
                   alt = "Picture of Healthy Minds Network Logo"
                 )
          ),
          column(8, h3(em(
            "Over the past decade, the rate of depression, anxiety and serious
          mental health crises has doubled among college students, according 
          to Daniel Eisenberg, a principal investigator of the Healthy Minds
          Study: an annual survey of thousands of students across the country
          (Hartocollis, New York Times 2021)."
          )
          )
          )
        ),
        br(),
        fluidRow(
          box(width = 12,
              # about healthy minds
              h4(
                "For the past four years, Sewanee undergrad students have
                been filling out the Healthy Minds Survey (HMS), a survey that
                asks questions about mental health outcomes, knowledge and
                attitudes about mental health and service utilization. 
                The HMS is used by a network of colleges and emphasizes
                understanding help-seeking behavior, examining stigma, 
                knowledge, and other potential barriers to mental 
                health service utilization."
              ))),
        h3("Our Method"),
        fluidRow(
          box(width = 12,
              # project plan
              h4(
                "Our team of researchers at Sewanee DataLab have analyzed
                HMS survey data to answer pressing questions about
                flourishing at Sewanee. The four years of HMS data we
                have will allow us to find correlations between student
                health, habits, and flourishing. This project is in
                partnership with the Associate Dean of Student
                Flourishing at Sewanee, Dr. Nicole Noffsinger-Frazier, and
                under mentorship of Dr. Sylvia Gray, Title IX coordinator."
              ),
              br(),
              h4(
                "These graphs show the percentage of students that fit the selected 
          criteria. This is a dataset of 1,375 survey respondents over 4 school
          years. Some demographics are grouped in “other” to protect the 
          identities of survey respondents."
              ))),
        hr(),
        # trigger warning
        h3(
          strong("WARNING"), ": Some content may include references to
          potentially triggering topics such as mental illness."
        ),
        # resources
        h3(strong("Resources:")),
        fluidRow(
          box(width = 12,
              h4("University Wellness Center Counseling and Psychological 
           Services: 931-598-1325",
                 br(),
                 "24/7 Wellness Crisis Line: 931-598-1700",
                 br(),
                 "Nationwide Mental Health Emergency and Suicide Prevention Hotline: 988",
                 br(),
                 "Director of Equity, Equal Opportunity, and Title IX, Dr. Sylvia Gray: 931-598-1420, 
           Woods 138,",
                 a(href ="mailto:smgray@sewanee.edu", "smgray@sewanee.edu"),
                 br(),
                 "CARE Team: https://new.sewanee.edu/care-team/",
                 br(),
                 "Chattanooga Rape Crisis Center: 423-755-2700",
                 br(),
                 "24-Hour Sexual Assault Violence Response Team (Nashville): 
           1-800-879-1999",
                 br(),
                 "RAINN (Rape, Abuse & Incest National Network): 1-800-656-4673",
                 br(),
                 "Southern Tennessee Regional Hospital - Sewanee: 931-598-5691",
                 br()
              ))),
        h4("*If you have any issues with accessibility, please contact Dr. Nicole Noffsinger-Frazier at", 
           a(href = "mailto:nanoffsi@sewanee.edu" , "nanoffsi@sewanee.edu"), 
           "or Matthew Brown from Student Accessibility Services", 
           a(href = "mailto:mabrown@sewanee.edu" , "mabrown@sewanee.edu")),
        
        fluidRow(
          column(12, h3('Who filled out the survey?') )
        ),
        
        fluidRow(
          box(width = 9, plotlyOutput("homePlot", width = 'auto')),
          
          column(3,
                 varSelectInput(inputId = 'homePlot_dem',
                                label = 'Select a Demographic:',
                                data = demographics1,
                                selected = 'Gender'
                 ),
                 h4('Gender: Man Identified includes transgender males. Woman
            identified includes transgender females.'),
                 h4('Race: POC includes races other than white (Black, Asian, 
            Hispanic, Multiracial, etc.)'),
                 h4('LGBTQ+: includes sexual identities other than heterosexual
            as well as genders that are not cisgender.')
          )
        )
      ),
      
      # Second tab content
      tabItem(tabName = "section1",
              actionButton('tutorial', 'Click for User Information'),
              h2('Trends on Mental Health'),
              hr(),
              
              # row for title of first graph
              fluidRow(
                column(12, h4('Percentage of Respondents with a Clinically Diagnosed
                Mental Illness since 2017') )
              ),
              
              # row for first graph
              fluidRow(
                
                box(
                  width = 9, plotlyOutput("mentalIllness_1", width = 'auto'),
                  "Fig 1. Clinically diagnosed mental illness rates among
                students have relatively remained the same since 2017 - around 
                35%. We hypothesize that factors such as Covid-19 might account
                for the increase from 2019 onwards."),
                
                # select demographics for first plot
                column(3,
                       varSelectInput(inputId = 'ment1_dem',
                                      label = 'Select a Demographic:',
                                      data = demographics1,
                                      selected = 'Class Year'
                       )
                )),
              
              fluidRow(
                column(12, h4('Percentage of respondents’ answers to corresponding 
                depression survey questions'))
              ),
              fluidRow(
                box(width = 9,
                    plotlyOutput( "phqPlot", width = 'auto'),
                    "Fig 2. This graph shows how many days students 
                  experienced depressive feelings in the last two weeks.",
                    textOutput('phqDesc')
                ),
                column(3,
                       varSelectInput(
                         inputId = "phqdem",
                         "Select a Demographic:",
                         demographics,
                         selected = 'Class Year'
                       ),
                       br(),
                       varSelectInput(
                         inputId = 'phqQ',
                         label = 'Select a Depression Question:',
                         data = phqQues
                       )
                )
              ),
              
              fluidRow(
                column(12, h4("Percentage of respondents’ answers to corresponding
                anxiety survey questions"))
              ),
              fluidRow(
                box(width = 9, plotlyOutput("gadPlot", width = 'auto'),
                    "Fig 3. This graph shows how many days students 
                experienced anxious feelings in the last two weeks."),
                column(
                  3,
                  varSelectInput(
                    inputId = 'gaddem',
                    label = 'Select a Demographic:',
                    data = demographics,
                    selected = 'Class Year'
                  ),
                  br(),
                  varSelectInput(
                    inputId = 'gadQ',
                    label = 'Select an Anxiety Question:',
                    data = gadQues
                  )
                )
              )
      ),
      tabItem(tabName = 'section2',
              h2('Correlations'),
              hr(),
              fluidRow(
                column(12, h4("Percentage of respondents who reported having 
                days in which emotional or mental difficulties have affect 
                academic performance"))
              ),
              fluidRow(
                box(width = 9, plotlyOutput("mentalIllness_4", 
                                            width = 'auto'),
                    "Fig 1. Academic Impairment is measured by
                how many days per month the respondents felt that emotional or 
                mental difficulties hurt their academic performance.",
                    textOutput('description')
                ),
                column(
                  3,
                  varSelectInput(
                    inputId = 'ment4_vars',
                    label = 'Select a Variable:',
                    data = ment4_variables
                  )
                )
              ),
              
              br(),
              fluidRow(
                column(12, h4("Percentage of respondents with a clinically
                              diagnosed mental illness and their activity 
                              compared to others."))
              ),
              fluidRow(
                box(width = 9, plotlyOutput("plot5", width = 'auto'),
                    "Fig 2. Students with one or more 
              diagnosed mental illnesses and their activities compared to 
              students without any diagnosed mental illness or illnesses.",
                    textOutput('MIdesc')),
                column(
                  3, varSelectInput(
                    inputId = 'behaviors',
                    label = 'Select an Activity:',
                    data = behaviors
                  ),
                  varSelectInput(
                    inputId = 'MIdem',
                    label = 'Select a Demographic:',
                    data = demographics,
                    selected = 'Class Year'
                  )
                )
              ),
              
              br(),
              fluidRow(
                column(12, h4("Percentage of respondents with a clinically
                              diagnosed mental illness and subtance use
                              behavior compared to others."))
              ),
              fluidRow(
                box(width = 9, plotlyOutput("plot6", width = 'auto'),
                    "Fig 3. Students with one or more 
                           diagnosed mental illnesses and their behaviors 
                           compared to students without any diagnosed mental 
                           illness or illnesses.",
                    textOutput('MIdesc2')),
                column(
                  3, varSelectInput(
                    inputId = 'substance_behaviors',
                    label = 'Select a Behavior:',
                    data = substance_behaviors
                  ),
                  varSelectInput(
                    inputId = 'MIdem2',
                    label = 'Select a Demographic:',
                    data = demographics,
                    selected = 'Class Year'
                  )
                )
              )
      ),
      
      # Third tab content
      tabItem(
        tabName = 'section3',
        h2('Trends on Flourishing'),
        hr(),
        fluidRow(
          column(12,h4("Percentage of students flourishing "))
        ),
        fluidRow(
          box(
            width = 9, plotlyOutput("Fplot1", width = 'auto'),
            "Fig 1. 60% of respondents describe themselves as either satisfied
            or highly satisfied. Their lives are not perfect, but they love
            their lives and feel that things are going very well",
            br(),
            br(),
            em("Categories are derived from The Satisfaction With Life Scale
            (SWLS). The scale was developed as a way to assess an individual’s
            cognitive judgment of their satisfaction with their life as a 
               whole."
            )),
          column(
            3,
            varSelectInput(
              inputId = 'Fdem1',
              label = 'Select a Demographic:',
              data = demographics,
              selected = 'Class Year'
            )
          )
        ),
        
        fluidRow(
          column(12, h4("Percentage of respondents’ answers to corresponding 
          positive mental health survey questions"))
        ),
        fluidRow(
          box(
            width = 9, plotlyOutput('dienerplot', width = 'auto'), 
            "Fig 2. How much students that are flourishing agree with the
            selected 
            wellbeing statement. Flourishing individuals are identified as
            respondents with a flourishing status of ‘Satisfied’ or 
            ‘Highly Satisfied’ on the Satisfaction With Life Scale (SWLS).
            Flourishing individuals are in the 90th percentile of the SWLS."
          ),
          column(
            3,
            varSelectInput(inputId = "flourdem",
                           label="Select a Demographic:",
                           data=demographics,
                           selected = 'Class Year'
            ),
            br(),
            varSelectInput(
              inputId = 'flourq',
              label = 'Select a Flourishing Question:',
              data = flourQues)
          )
        )),
      tabItem(
        tabName = 'section4',
        h2('Flourishing Correlations'), 
        hr(),
        fluidRow(
          column(12, h4("Percentage of respondents considered flourishing and
                        their behavior compared to others."))
        ),
        fluidRow(
          box(
            width = 9, plotlyOutput("Fplot2", width = 'auto'),
            "Fig 1. Flourishing individuals are identified as
                respondents with a flourishing status of ‘Satisfied’ or 
                ‘Highly Satisfied’ on the Satisfaction With Life Scale (SWLS).
                Flourishing individuals are in the 90th percentile of the SWLS.",
            textOutput('fldesc1')
          ),
          column(
            3,
            varSelectInput(
              inputId = 'Fplot2_dem',
              label = 'Select a Demographic:',
              data = demographics,
              selected = 'Class Year'
            ),
            br(),
            varSelectInput(
              inputId = 'Fplot2_var',
              label = 'Select a Behavior:',
              data = behaviors
            )
          )
        ),
        
        fluidRow(
          column(12, h4("Percentage of respondents considered flourishing and 
                        substance use behavior compared to others."))
        ),
        fluidRow(
          box(
            width = 9, plotlyOutput("Fplot3", width = 'auto'),
            "Fig 2. Flourishing individuals are identified as
                respondents with a flourishing status of ‘Satisfied’ or 
                ‘Highly Satisfied’ on the Satisfaction With Life Scale (SWLS).
                Flourishing individuals are in the 90th percentile of the 
            SWLS.",
            textOutput('fldesc2')
          ),
          column(
            3,
            varSelectInput(
              inputId = 'Fplot3_dem',
              label = 'Select a Demographic:',
              data = demographics
            ),
            br(),
            varSelectInput(
              inputId = 'Fplot3_var',
              label = 'Select a Behavior:',
              data = substance_behaviors
            )
          )
        )
      ),
      tabItem(tabName = 'key',
              h2("Important Takeaways"),
              hr(),
              fluidRow(column(12,
                              h3('Mental Health',
                                 style = 'text-align: center;'))),
              fluidRow(
                box(width = 4,
                           h4(strong('Trends')),
                           'Generally, from 2017 to 2021, mental illness
                           rates have increased across races.',
                           br(),
                    br(),
                           ' Mental illness is more common among gender queer/
                           nonconforming (56% in 2021) and self-identified
                           (100% in 2021) students than in man (21% in 2021)
                           and woman (45% in 2021) identified students.',
                           br(),
                    br(),
                           'Anxiety and depression are the two most prevalent
                           mental illnesses on campus. Among students with
                           mental illnesses, 53% have both
                           depression and anxiety.',
                           br(),
                    br(),
                           'As class year increases, mental illness
                           percentages
                           increase. Seniors (53% in 2019) tend to have more
                           mental illnesses than freshman (42% in 2019).',
                           br(),
                    br(),
                           'Mental Illnesses are more common among LGBTQ+
                           students than non-LGBTQ+ students. For example, in
                           2021, mental illness percent among LGBTQ+ students
                           was 56% whereas for non-LGBTQ+ students was 35%.'),
                box(width = 4,
                           h4(strong('Student Activities')),
                           'Diagnosed depression and anxiety have a large
                    impact on academic impairment. 46% and 40% of students with
                    depression and anxiety, respectively,
                    report experiencing academic impairment 
                    for 6 or more days',
                    br(),
                    br(),
                    'Feelings of loneliness do not have as large of an impact
                    on academic impairment. Around 30-35%, depedning on the
                    loneliness variable, experience academic impairment only
                    one or two days.',
                    br(),
                    br(),
                    'Generally, students sleep less than an average of 6 hours,
                    regardless of mental illness status and demographic.',
                    br(),
                    br(),
                    'Students with mental illnesses use therapy more. In 2021,
                    around 42% of students with a mental illness reported using
                    therapy, whereas 35% of students without a mental illness
                    report not using therapy.',
                    br(),
                    br(),
                    'Knowledge of mental health services on campus is similar
                    (about 32% agree or strongly agree in 2021)
                    amongst students with and without mental illnesses' 
                    ),
                box(width = 4,
                    h4(strong('Substance Use')),
                           'Most students have not had any alcohol in the past
                    2 weeks regardless of mental illness status 
                    (around 36% in 2021).',
                    br(),
                    br(),
                    'Binge drinking three to five times or less is more common
                    (47% in 2021) amongst students without mental illness than
                    those with(43% in 2021).',
                    br(),
                    br(),
                    'Smoking frequency is mainly zero days for students with 
                    (33% in 2021) or without (45% in 2021) mental illness.',
                    br(),
                    br(),
                    'Not vaping (68% in 2021) in the past 30 days is more
                    common than vaping (34% in 2021) across both mental
                    statuses.',
                    br(),
                    br(),
                    'Drug use is more common in those with mental illnesses
                    (16% in 2021) compared to those without (13% in 2021).')
              ),
              fluidRow(column(12,
                              h3('Flourishing',
                                 style = 'text-align: center;'))),
              fluidRow(
                    box(width = 4,
                           h4(strong('Trends')),
                           'Overall, most students are satisfied (around 40%)
                           or highly
                           satisfied (around 27%) with their lives',
                           br(),
                           br(),
                           'Zero percent of gender queer/nonconforming students
                        report being highly satisfied with their lives.',
                           br(),
                           br(),
                           'Non LGBTQ+ report being more satisfied (41%) and
                        highly satisfied (31%) than LGBTQ+ students (35% and
                        11% respectively).',
                        br(),
                        br(),
                        'Life satisfaction generally increases with class year.
                        36% of first year students report being satisfied
                        compared to 41% of fourth year students.'),
                    box(width = 4,
                        h4(strong('Student Activities')),
                           'Generally, students sleep less than an average of 6
                           hours,
                    regardless of flourishing status and demographic.',
                        br(),
                        br(),
                        'Students who are not flourishing use therapy (46% in
                        2021) more than not (23% in 2021).' ,
                        br(),
                        br(),
                        'Regardless of flourishing status, most students agree
                        they have knowledge of mental health services on
                        campus.'),
                    box(width = 4,
                        h4(strong('Substance Use')),
                           'Most students have not had any alcohol in the past
                        two weeks whether they are flourishing or not.',
                        br(),
                        br(),
                        'Students who are not flourishing seem to binge drink 3
                        to 5 times more often than students who are 
                        flourishing.',
                        br(),
                        br(),
                        'Smoking frequency is mainly zero days for flourishing 
                        students (25% in 2021) and non-flourishing students
                        (53% in 2021).',
                        br(),
                        br(),
                        'Not vaping (67% in 2021) in the past 30 days is more
                        common than vaping (47% in 2021) across both 
                        flourishing statuses.',
                        br(),
                        br(),
                        'Drug use is generally not common amongst both
                        flourishing statuses; 51% in 2021 for non-flourishing
                        students and 20% in 2021 for flourishing students.')
              )
              
      ),
      
      # Fifth tab content
      tabItem(
        
        tabName = 'About',
        h2('About the Well-being Project'),
        hr(),
        h3(strong("What is DataLab </>?")),
        br(),
        h4("DataLab is a summer internship program at Sewanee: the University 
        of the South that partners with DSSG, Data Science for Social Good, 
        to develop data science skills in students by analyzing data sets 
           related to pressing social and environmental problems."
        ),
        br(),
        h3(strong('Well-being Dream Team:')),
        br(),
        br(),
        fluidRow(
          column(
            4,
            tags$img(
              src = "jarely.jpg",
              width = "100%",
              alt = "Picture of Jarely"
            )
          ),
          column(
            8,
            h3(
              "Jarely Soriano | ",
              a(href = 'mailto:soriaja0@sewanee.edu', 'Email Me')
            ),
            h4(em("C'23 IGS: Latin American and 
                  Caribbean Studies and Global Politics")),
            tags$blockquote(
              em("I joined DataLab because I wanted to learn something new and 
              do something impactful. If i’ve learned one thing during this 
              experience, it’s that information can be beautiful and powerful."
              )
            )
          )
        ),
        br(),
        fluidRow(
          column(
            4,
            tags$img(
              src = "sam.jpg",
              width = "100%",
              alt = "Picture of Sam"
            )
          ),
          column(
            8,
            h3('Sam Dean | ', a(href = 'mailto:deansn0@sewanee.edu', 
                                'Email Me')),
            h4(em("C'23 Psychology")),
            tags$blockquote(
              em("Being invited to be a part of DataLab 2022 has been one of 
              the most enriching opportunities I have experienced. Not only did 
              my coding skills improve, I was shown how to incorporate two fields 
                 I am most passionate about: data science and mental health.")
            )
          )
        ),
        br(),
        fluidRow(
          column(
            4,
            tags$img(src = "michael.jpg", width = "100%", 
                     alt = "Picture of Michael")
          ),
          column(
            8,
            h3('Michael Komnick | ', a(href = "mailto:komnimj0@sewanee.edu", 
                                       'Email Me')),
            h4(em("C'24 Computer Science")),
            tags$blockquote(
              em("I heard that DataLab was a great opportunity to use my 
              computer science skills for social good. I also wanted to 
              increase my network and connections with professionals in the 
                 field I am most passionate about.")
            )
          )
        ),
        br(),
        fluidRow(
          column(
            4,
            tags$img(
              src = "temi.jpg",
              width = "100%",
              alt = "Picture of Temi")
          ),
          column(
            8,
            h3('Temi Adejumobi | ', a(href ="mailto:adejuoj0@sewanee.edu", 
                                      "Email Me")),
            h4(em("C'24 Computer Science")),
            tags$blockquote(
              em(
                "DataLab 2022 has been a wonderful experience! I am grateful 
                for the opportunity to embrace a purpose beyond oneself 
                while creating sustainable impact in the lives of others. 
                This summer has allowed me to learn and develop important 
                technical and transferable skills; working with and learning 
                from interesting people."
              )
            )
          )
        )
      )
    )
  )
)


################################################################################
# server
################################################################################

server <- function(input, output){
  
  ###############################################################################
  ################################### plots ##################################### 
  ###############################################################################
  
  output$homePlot <- renderPlotly({
    
    n_graph <- HMS %>% 
      filter(!is.na(!!input$homePlot_dem)) %>% 
      group_by(`School Year`, !!input$homePlot_dem) %>% 
      tally() %>% 
      ungroup() %>% 
      mutate(total = sum(n),
             percent = (n)/(total) * 100,
             percent_text = paste0( round(100*percent,2), "%" )) 
    
    ggplotly(
      ggplot(n_graph)+
        geom_col(aes(x=`School Year` ,y = percent, fill=!!input$homePlot_dem))+
        labs(x='School Year', 
             y='Percentage',
             title='Number of Survey Respondents')+
        theme_gdocs()+
        scale_fill_manual(values = cbPalette)
    ) %>% layout(annotations = list(x=1,
                                    y=1,
                                    xref="paper",
                                    yref="paper",
                                    text= paste("responses =", 
                                                as.character(unique
                                                             (n_graph$total))),
                                    showarrow=F)
    )
    
  })  
  
  
  ######################
  # phq depression plot#
  ######################
  
  output$phqPlot <- renderPlotly({
    phq <- HMS %>%
      select(!!input$phqdem, !!input$phqQ) %>%
      pivot_longer(!(!!input$phqdem)) %>%
      drop_na(value) %>%
      group_by(!!input$phqdem, name, value) %>%
      tally() %>%
      ungroup() %>%
      group_by(!!input$phqdem, name) %>%
      mutate(total = sum(n)) %>%
      mutate(percent = (n/total)*100)
    
    # Changing the names of the questions to the actual questions
    phq$name <- factor(phq$name, levels = c('Depression Question 1', 
                                            'Depression Question 2',
                                            'Depression Question 3', 
                                            'Depression Question 4', 
                                            'Depression Question 5', 
                                            'Depression Question 6', 
                                            'Depression Question 7', 
                                            'Depression Question 8', 
                                            'Depression Question 9'), 
                       labels = c(
                         "Little interest or pleasure in doing things (academics, social, etc.)", 
                         "Feeling down, depressed or hopeless",
                         'Trouble falling or staying asleep,
                         or sleeping too much',
                         'Feeling tired or having little energy',
                         'Poor appetite or overeating',
                         'Feeling bad about yourself—or that you are a failure or have letyourself or your family down',
                         'Trouble concentrating on things, such as reading the newspaper or watching television',
                         'Moving or speaking so slowly that other people could have noticed; or the opposite',
                         'Thoughts that you would be better off dead or of hurting yourself in some way'))
    
    # Changing the numbers of the values to the actual values
    phq$value <- factor(phq$value, levels = c(1, 2, 3, 4),
                        labels = c('Not at all',
                                   'Several days',
                                   'More than\n half the days',
                                   'Nearly every day'))
    
    ggplotly(
      ggplot(data = phq,
             aes(
               x = value,
               y = percent,
               fill = !!input$phqdem
             )
      ) +
        geom_col(position = 'dodge') +
        ylim(c(0,100)) +
        theme_gdocs()+
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
        labs(title = as.character(unique(phq$name)),
             x = 'Response',
             y = 'Percent of Students') +
        scale_fill_manual(values = cbPalette)
    ) %>% 
      layout(annotations = list(x=1,
                                y=1,
                                xref="paper",
                                yref="paper",
                                text= paste("responses =", 
                                            as.character(sum( unique(phq$total)))),
                                showarrow=F)
      )
    
  })
  
  
  ####################
  ### anxiety plot ###
  ####################
  
  output$gadPlot <- renderPlotly({
    
    gad <- HMS %>%
      select(!!input$gaddem, !!input$gadQ) %>%
      pivot_longer(!(!!input$gaddem)) %>%
      drop_na(value) %>%
      group_by(!!input$gaddem, name, value) %>%
      tally() %>%
      ungroup() %>%
      group_by(!!input$gaddem, name) %>%
      mutate(total = sum(n)) %>%
      mutate(percent = (n/total)*100)
    
    # Changing the names of the questions to the actual questions
    gad$name <- factor(gad$name, levels = c('Anxiety Question 1', 
                                            'Anxiety Question 2',
                                            'Anxiety Question 3',
                                            'Anxiety Question 4', 
                                            'Anxiety Question 5', 
                                            'Anxiety Question 6',
                                            'Anxiety Question 7'), 
                       labels = c(
                         "Feeling nervous, anxious or on edge", 
                         "Not being able to stop or control worrying",
                         'Worrying too much about different things',
                         'Trouble relaxing',
                         'Being so restless that it’s hard to sit still',
                         'Becoming easily annoyed or irritable',
                         'Feeling afraid as if something awful 
                               might happen'
                       )
    )
    
    # Changing the numbers of the values to the actual values
    gad$value <- factor(gad$value, levels = c(1, 2, 3, 4),
                        labels = c('Not at all',
                                   'Several days',
                                   'Over half\n the days',
                                   'Nearly every day'))
    ggplotly(
      ggplot(data = gad,
             aes(x = value,
                 y = percent,
                 fill = !!input$gaddem
             )
      ) +
        geom_col(position = 'dodge') +
        ylim(c(0,100)) +
        theme_gdocs()+
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
        labs(title = as.character(unique(gad$name)),
             x = 'Response',
             y = 'Percent of Students') +
        scale_fill_manual(values = cbPalette)
    ) %>% 
      layout(annotations = list(x=1,
                                y=1,
                                xref="paper",
                                yref="paper",
                                text= paste("responses =", 
                                            as.character(sum( unique(gad$total)))),
                                showarrow=F)
      )
  })
  
  
  # output$phqDesc <- renderText({
  #   text <- switch(as.character(input$phqdem),
  #                  race = 'interpetation',
  #                  gender = 'interpetation',
  #                  international = 'interpretation',
  #                  LGBTQ = 'interpretation',
  #                  classYear = 'interpretation',
  #                  schoolYear = 'interpretation')
  # })
  
  
  #########################
  # mental Illness plot 1 #
  #########################
  output$mentalIllness_1 <- renderPlotly({
    
    mental_illness <- HMS %>% 
      group_by(`School Year`, !!input$ment1_dem) %>%
      summarize(withMI = sum(ifelse(mentalIllness == "Has Mental Illness", 
                                    1, 0)), 
                total = n(), percent = (withMI/total)*100)
    
    
    # lets plot!
    ggplotly(
      ggplot(mental_illness, aes(x = `School Year`, 
                                 y = percent, 
                                 fill = !!input$ment1_dem))+
        geom_col(position = 'dodge')+
        ylim(c(0,100))+
        labs(title = 
               paste("Percentage of Students Diagnosed with a Mental Illness by",
                     input$ment1_dem),
             subtitle = "2017 - 2021") +
        scale_fill_manual(values = cbPalette) +
        theme_gdocs()+
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    ) %>% 
      layout(annotations = list(x=1,
                                y=1,
                                xref="paper",
                                yref="paper",
                                text= paste("responses =", 
                                            as.character(sum( unique(
                                              mental_illness$total)))),
                                showarrow=F)
      )
  })
  
  #########################
  # mental Illness plot 4 #
  #########################
  output$mentalIllness_4 <- renderPlotly({
    impairment <- HMS %>%
      filter(!!input$ment4_vars == 1 | is.na(!!input$ment4_vars)) %>%
      group_by(!!input$ment4_vars, aca_impa) %>%
      tally(name = 'totalIll') %>% 
      mutate(total = sum(totalIll),
             percent = ( (totalIll)/(total) * 100 ) )
    
    
    # clean our new df, remove NA's and 'the whole' of percentage
    impairment <- impairment %>% 
      filter(!!input$ment4_vars ==1 & !is.na(aca_impa))
    
    
    # lets plot
    ggplotly(
      ggplot(data = impairment, aes(x = aca_impa, y = percent, 
                                    fill = as.character(aca_impa)))+
        geom_col()+
        ylim(0,100)+
        labs(title = paste("Academic Impairment and", input$ment4_vars),
             y = 'Percent of Students',
             x = 'Academic Impairment') +
        scale_fill_manual(values = cbPalette) +
        theme_gdocs()+
        theme(legend.position = 'none') +
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    ) %>% 
      layout(annotations = list(x=1,
                                y=1,
                                xref="paper",
                                yref="paper",
                                text= paste("responses =", 
                                            as.character(sum( unique(
                                              impairment$total)))),
                                showarrow=F)
      )
  })
  
  
  ########################################
  ####### Mental Illness Plot 5 ##########
  ########################################
  
  output$plot5 <- renderPlotly({
    
    MIPercent <- HMS %>% 
      select(!!input$behaviors, !!input$MIdem, mentalIllness) %>%
      filter(!is.na(!!input$behaviors)) %>% 
      group_by(!!input$behaviors, !!input$MIdem, mentalIllness) %>% 
      mutate(numerator = n()) %>%
      ungroup() %>%  
      group_by(!!input$MIdem) %>% 
      mutate(denominator = n()) %>% 
      mutate(percent = (numerator/denominator)*100)
    
    ggplotly(
      ggplot(data = MIPercent, 
             aes(x = !!input$behaviors, 
                 y = percent, 
                 fill = !!input$MIdem)) +
        geom_col(position = 'dodge')+
        labs(title = 'Percent of Student Behaviors by Mental Illness Status') +
        scale_fill_manual(values = cbPalette)+
        facet_wrap(~mentalIllness) +
        theme_gdocs()+
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    ) %>% 
      layout(annotations = list(x=1,
                                y=1,
                                xref="paper",
                                yref="paper",
                                text= paste("responses =", 
                                            as.character(sum( unique(
                                              MIPercent$denominator)))),
                                showarrow=F)
      )
  })
  
  ########################################
  ####### Mental Illness Plot 6 ##########
  ########################################
  
  output$plot6 <- renderPlotly({
    
    MIPercent2 <- HMS %>% 
      select(!!input$substance_behaviors, !!input$MIdem2, mentalIllness) %>%
      filter(!is.na(!!input$substance_behaviors)) %>% 
      group_by(!!input$substance_behaviors, !!input$MIdem2, mentalIllness) %>% 
      mutate(numerator = n()) %>%
      ungroup() %>% 
      group_by(!!input$MIdem2) %>% 
      mutate(denominator = n()) %>% 
      mutate(percent = (numerator/denominator)*100)
    
    ggplotly(
      ggplot(data = MIPercent2, 
             aes(x = !!input$substance_behaviors, 
                 y = percent, 
                 fill = !!input$MIdem2)) +
        geom_col(position = 'dodge')+
        labs(title = 'Percent of Student Behaviors by Mental Illness Status') +
        scale_fill_manual(values = cbPalette)+
        facet_wrap(~mentalIllness) +
        theme_gdocs()+
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    ) %>%
      layout(annotations = list(x=1,
                                y=1,
                                xref="paper",
                                yref="paper",
                                text= paste("responses =", 
                                            as.character(sum(unique(
                                              MIPercent2$denominator)))),
                                showarrow=F)
      )
    
  })
  
  
  ###########################################################################
  ########################### Well-being Plot 1 #############################
  ###########################################################################
  
  output$Fplot1 <- renderPlotly({
    #Create an object with the percentage of students that were highly satisfied 
    # browser()
    dienerpercent<- HMS%>% 
      filter(!is.na(diener_status)) %>% 
      filter(!is.na(!!input$Fdem1)) %>% 
      group_by(!!input$Fdem1, diener_status) %>% 
      summarise(n = n()) %>% 
      ungroup() %>% 
      group_by(!!input$Fdem1) %>% 
      mutate( total = sum(n)) %>% 
      mutate(percent = (n/total)*100)
    
    ###PLOT 1:the students'flourishing score#####
    ggplotly(
      ggplot(data = dienerpercent)+
        geom_col(aes(x = diener_status, y = percent,
                     fill = !!input$Fdem1),
                 position = 'dodge')+
        # ylim(c(0, 100)) +
        coord_flip()+
        labs(title = 'Overall Life Satisfaction for Students',
             y='Percentage of Students',
             x='Status') +
        scale_fill_manual(values = cbPalette) +
        theme_gdocs()+
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    ) %>% 
      layout(annotations = list(x=1,
                                y=1,
                                xref="paper",
                                yref="paper",
                                text= paste("responses =", 
                                            as.character(sum( unique(
                                              dienerpercent$total)))),
                                showarrow=F)
      )
  })
  
  ###########################################################################
  ########################### diener plot by ? ##############################
  ###########################################################################  
  output$dienerplot <- renderPlotly({
    #data frame
    flourishing <- HMS %>%
      select(!!input$flourdem, !!input$flourq) %>%
      pivot_longer(!(!!input$flourdem)) %>%
      drop_na(value) %>%
      group_by(!!input$flourdem, name, value) %>%
      tally() %>%
      ungroup() %>%
      group_by(!!input$flourdem, name) %>%
      mutate(total = sum(n)) %>%
      mutate(percent = (n/total)*100)
    
    # Changing the names of the questions to the actual questions
    flourishing$name <- factor(flourishing$name, 
                               levels = c('Well-being Question 1', 
                                          'Well-being Question 2',
                                          'Well-being Question 3', 
                                          'Well-being Question 4', 
                                          'Well-being Question 5', 
                                          'Well-being Question 6', 
                                          'Well-being Question 7', 
                                          'Well-being Question 8'), 
                               labels = c(
                                 "I lead a purposeful and meaningful life", 
                                 "My social relationships are supportive and rewarding",
                                 'I am engaged and interested in my daily activities',
                                 'I actively contribute to the happiness and well-being
of others',
                                 'I am competent and capable in the activities that are
importantto me',
                                 'I am a good person and live a good life',
                                 'I am optimistic about my future',
                                 'People respect me'))
    
    #plot
    ggplotly(
      ggplot(data = flourishing,
             aes(x = value,
                 y = percent/100,
                 fill = !!input$flourdem
             )
      ) +
        geom_col(position = 'dodge') +
        # ylim(c(0,100)) +
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
        scale_x_continuous(breaks=seq(1,7,1),
                           labels = c("Strongly Disagree",
                                      "Disagree",
                                      "Slightly Disagree",
                                      "Mixed",
                                      "Slightly Agree",
                                      "Agree",
                                      "Strongly Agree"))+
        scale_y_continuous(labels = scales::percent)+
        labs(title = as.character(unique(flourishing$name)) ,
             x = 'Response',
             y = 'Percent of Students') +
        scale_fill_manual(values = cbPalette) +
        theme_gdocs()+
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    ) %>% 
      layout(annotations = list(x=1,
                                y=1,
                                xref="paper",
                                yref="paper",
                                text= paste("responses =", 
                                            as.character(sum( unique(
                                              flourishing$total)))),
                                showarrow=F)
      )
  })
  
  ###########################################################################
  ########################### Well-being Plot 2 #############################
  ###########################################################################
  
  output$Fplot2 <- renderPlotly({
    
    # what can we learn more about people who are considered 'flourishing' vs not
    
    # select variables 
    action_flourish <- HMS %>% 
      select( `School Year`, Race, Gender,`Class Year`, diener_score,
              Exercise, `Therapy Use`, ther_help, ther_helped_me, 
              `Smoking Frequency`, Vaping, `Binge Drinking`, `Greek Life`, 
              `Varsity Athletics`, Sleep, International, `LGBTQ+`, 
              `Drug Use`, `Alcohol Use`, `Knowledge of Services`)
    
    # define flourishing and mark respondents
    # 8 questions, scale of 1-7. 90th percentile: >= 49
    # note: we can subset flourishing by more ranges
    action_flourish <- action_flourish %>% 
      mutate(flourish_status = case_when(diener_score >= 49 ~ "Flourishing",
                                         TRUE ~ "Not flourishing"))
    
    # find percent of people who flourish vs not, grouped by selected variables
    action_flourish <- action_flourish %>% 
      select(!!input$Fplot2_var, !!input$Fplot2_dem, flourish_status) %>% 
      filter(!is.na(!!input$Fplot2_var)) %>% 
      group_by(flourish_status, !!input$Fplot2_var, 
               !!input$Fplot2_dem) %>% 
      summarise(numerator = n()) %>% 
      ungroup() %>% 
      group_by(!!input$Fplot2_dem) %>% 
      mutate(total = sum(numerator),
             percent = ((numerator)/(total)) * 100) 
    
    ggplotly(
      ggplot(data = action_flourish)+
        geom_col(aes(x = !!input$Fplot2_var,
                     y = percent,
                     fill = !!input$Fplot2_dem), 
                 position = 'dodge')+
        facet_wrap(~flourish_status) +
        labs(y = 'Percent of Students',
             title = 'Percent of Student Behaviors by Flourishing Status')+
        scale_fill_manual(values = cbPalette) +
        theme_gdocs()+
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    ) %>% 
      layout(annotations = list(x=1,
                                y=1,
                                xref="paper",
                                yref="paper",
                                text= paste("responses =", 
                                            as.character(sum( unique(
                                              action_flourish$total)))),
                                showarrow=F)
      )
  })
  
  
  ###########################################################################
  ########################### Well-being Plot 3 #############################
  ###########################################################################
  
  output$Fplot3 <- renderPlotly({
    
    # what can we learn more about people who are considered 'flourishing' vs not
    
    # select variables 
    action_flourish2 <- HMS %>% 
      select( `School Year`, Race, Gender,`Class Year`, diener_score,
              Exercise, `Therapy Use`, ther_help, ther_helped_me, 
              `Smoking Frequency`, Vaping, `Binge Drinking`, `Greek Life`, 
              `Varsity Athletics`, Sleep ,International, `LGBTQ+`, 
              `Drug Use`, `Alcohol Use`)
    
    # define flourishing and mark respondents
    # 8 questions, scale of 1-7. 90th percentile: >= 49
    # note: we can subset flourishing by more ranges
    action_flourish2 <- action_flourish2 %>% 
      mutate(flourish_status = case_when(diener_score >= 49 ~ "Flourishing",
                                         TRUE ~ "Not flourishing"))
    
    # find percent of people who flourish vs not, grouped by selected variables
    
    action_flourish2 <- action_flourish2 %>% 
      filter(!is.na(!!input$Fplot3_var)) %>% 
      group_by(flourish_status, !!input$Fplot3_var, 
               !!input$Fplot3_dem) %>% 
      summarise(n = n()) %>% 
      ungroup() %>% 
      group_by(!!input$Fplot3_dem) %>% 
      mutate(total = sum(n),
             percent = (n)/(total) * 100) 
    
    ggplotly(
      ggplot(data = action_flourish2)+
        geom_col(aes(x = !!input$Fplot3_var,
                     y = percent,
                     fill = !!input$Fplot3_dem), 
                 position = 'dodge')+
        facet_wrap(~flourish_status) +
        labs(y = 'Percent of Students',
             title = 'Percent of Student Behaviors by Flourishing Status')+
        scale_fill_manual(values = cbPalette) +
        theme_gdocs()+
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    ) %>% 
      layout(annotations = list(x=1,
                                y=1,
                                xref="paper",
                                yref="paper",
                                text= paste("responses =", 
                                            as.character(sum( unique(
                                              action_flourish2$total)))),
                                showarrow=F)
      )
  })
  
  output$description <- renderText({
    text <- switch(as.character(input$ment4_vars),
                   'Diagnosed Depression' = "Self-reported clinically diagnosed depression.",
                   'Diagnosed Anxiety' = "Self-reported clinically diagnosed anxiety.",
                   "Feeling Isolated" = "A measurment of loneliness that asks: How often do you feel isolated from others?",
                   'Lacking Companionship' =  "A measurment of loneliness that asks: How often do you feel that you lack companionship?",
                   'Feeling Leftout' = "A measurment of loneliness that asks: How often do you feel left out?"
    )
  })
  
  output$MIdesc <- renderText({
    text1 <- switch(as.character(input$behaviors),
                    Sleep= 'Average hours of sleep per day',
                    Exercise = 'How much do you agree with the following
statement? : My exercise habits have changed a lot since I began as a student at my school.',
                    'Therapy Use' = 'Have you ever received counseling or therapy for mental health concerns?',
                    'Varsity Athletics' ='Are you currently involved in varsity athletics?',
                    'Greek Life' = 'Are you currently involved in a fraternity or sorority?',
                    'Knowledge of Services' = 'How much do you agree with the following statement? : If I needed to seek professional help for my mental or emotional health, I would know where to go on my campus.')
  })
  
  output$MIdesc2 <- renderText({
    text1 <- switch(as.character(input$substance_behaviors),
                    'Alcohol Use' = 'Over the past 2 weeks, did you drink any alcohol?',
                    'Binge Drinking' = 'Over the past 2 weeks, about how many times did you have 4 [female]/5 [male]/4 or 5 [not female or male] or more alcoholic drinks in a row?',
                    'Smoking Frequency' ='Over the past 30 days, about how many cigarettes did you smoke per day?',
                    'Vaping' = 'Over the past 30 days, have you used an electronic cigarette or vape pen?',
                    'Drug Use' = 'Over the past 30 days have you used any drugs' )
  })
  output$description <- renderText({
    text <- switch(as.character(input$ment4_vars),
                   'Diagnosed Depression' = "Self-reported clinically diagnosed depression.",
                   'Diagnosed Anxiety' = "Self-reported clinically diagnosed anxiety.",
                   "Feeling Isolated" = "A measurment of loneliness that asks: How often do you feel isolated from others?",
                   'Lacking Companionship' =  "A measurment of loneliness that asks 'How often do you feel that you lack companionship?'",
                   'Feeling Leftout' = "A measurment of loneliness that asks 'How often do you feel left out?'"
    )
  })
  
  output$fldesc1 <- renderText({
    text1 <- switch(as.character(input$Fplot2_var),
                    Sleep= 'Average hours of sleep per day',
                    Exercise = 'How much do you agree with the following
statement? : My exercise habits have changed a lot since I began as a student at my school.',
                    'Therapy Use' = 'Have you ever received counseling or therapy for mental health concerns?',
                    'Varsity Athletics' ='Are you currently involved in varsity athletics?',
                    'Greek Life' = 'Are you currently involved in a fraternity or sorority?',
                    
                    'Greek Life' = 'Are you currently involved in a fraternity or sorority?',
                    'Knowledge of Services' = 'How much do you agree with the following statement? : If I needed to seek professional help for my mental or emotional health, I would know where to go on my campus.')
  })
  
  output$fldesc2 <- renderText({
    text1 <- switch(as.character(input$Fplot3_var),
                    'Alcohol Use' = 'Over the past 2 weeks, did you drink any alcohol?',
                    'Binge Drinking' = 'Over the past 2 weeks, about how many times did you have 4 [female]/5 [male]/4 or 5 [not female or male] or more alcoholic drinks in a row?',
                    'Smoking Frequency' ='Over the past 30 days, about how many cigarettes did you smoke per day?',
                    'Vaping' = 'Over the past 30 days, have you used an electronic cigarette or vape pen?',
                    'Drug Use' = 'Over the past 30 days have you used any drugs' )
  })
  
  observeEvent(input$tutorial,
               {shinyalert("How to Use:",
                           "Dropdown menus are located on the right of each graph, which changes the variable(s) shown. Some graphs are also interactive: hover over to see more information or zoom in on bars! Additionally, underneath each graph there is information about the graphs and the variables within the graph.",
                           html = TRUE)
               }) 
}
shinyApp(ui, server)