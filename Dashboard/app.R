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


# getting combined data
# source("../merged.R")
HMS <- read_csv("../../HMSAll.csv")

# color-blind palette:

cbPalette <- c("#E69F00", "#56B4E9", "#009E73", "#CC79A7",
               "#F0E442", "#0072B2","#999999", "#D55E00", "#000000")

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
         Sleep = sleep_wd1)

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
                        labels = c('0 cigarettes', 'Less than 1 cigarette',
                                   '1 to 5 cigarettes', 'About one-half pack',
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
# creating a new binge column in HMS
binge <- HMS %>% 
  select(responseid, binge_fr_f:binge_fr_o) %>% 
  pivot_longer(!responseid) %>%  
  filter(!is.na(value)) %>% 
  group_by(responseid) %>% 
  mutate(binge = value) %>%  
  distinct(responseid, binge)

HMS <- HMS %>% 
  left_join(binge, by = "responseid")

# HMS$binge <- factor(HMS$binge, levels = C(1, 2, 3, 4, 5, 6, 7),
#                     labels = c('None', 'Once', 'Twice', '3 to 5 times',
#                                '6 to 9 times', '10 or more times', 
#                                "Don't know"))

# creating a drug use column in HMS
drug <- HMS %>% 
  select(responseid, drug_mar:drug_other) %>% 
  pivot_longer(!responseid) %>%  
  filter(!is.na(value)) %>% 
  group_by(responseid) %>% 
  mutate(drug = value) %>%  
  distinct(responseid, drug)

HMS <- HMS %>% 
  left_join(drug, by = "responseid") %>% 
  mutate(drug = ifelse(is.na(drug), 0, drug))

HMS$drug <- factor(HMS$drug, levels = c(0, 1),
                   labels = c('No', 'Yes'))

behaviors <- HMS %>% 
  select('Sleep', 'Exercise', `Alcohol Use`, `Therapy Use`, 
         `Varsity Athletics`, `Greek Life`, 'binge', 
         `Smoking Frequency`, 'Vaping', 'drug')

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
        icon = icon('brain')
      ),
      
      menuItem(
        "Student Well-being", tabName = "Well_being",
        icon = icon("leaf")
      ),
      
      menuItem(
        "About", tabName = 'About', icon = icon('question')
      )
      
    )
    
  ),
  
  ## Body content
  dashboardBody(
    
    shinyDashboardThemes(theme = "grey_dark"),
    
    tabItems(
      
      # First tab content
      tabItem(
        tabName = "Home",
        h2("Cracking the Code to Student Flourishing"),
        hr(),
        # the problem
        h4(
          "Sewanee has fostered some of the greatest academics and
                so many flourish and thrive! But how? What can we learn
                from those who are thriving? Over the past decade, the rate of
                depression, anxiety and serious mental health crises has 
                doubled among college students, according to Daniel Eisenberg,
                a principal investigator of the Healthy Minds Study: an annual
                survey of thousands of students across the country 
                (Hartocollis, New York Times 2021)."
        ),
        br(),
        
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
        ),
        br(),
        
        # project plan
        h4(
          "Our team of researchers at Sewanee DataLab have analyzed
                HMS survey data to answer pressing questions about
                flourishing at Sewanee. The four years of HMS data we
                have will allow us to find correlations between student
                health, habits, and flourishing. This project is in
                partnership with the Associate Dean of Student
                Flourishing at Sewanee Dr. Nicole Noffsinger-Frazier and
                under mentorship of Dr. Sylvia Gray, Title IX coordinator."
        ),
        br(),
        h4(
          "Click around to learn more about how we Cracked the Code
                 to Student Flourishing!!!"
        ),
        br(),
        
        # trigger warning
        h4(
          strong("WARNING"), ": Some of the graphs may contain potentially 
          triggering information. If you’re unfamiliar with Sewanee’s 
          Counseling and Psychological Services, call 931-598-1325."
        ),
        br(),
        
        # resources
        h3("Resources:"),
        h4("University Wellness Center Counseling and Psychological 
           Services: 931-598-1325",
           br(),
           "ProtoCall: 931-598-1700 (used after 5pm)",
           br(),
           "Title IX Coordinator at Sewanee, Dr. Sylvia Gray: 931-598-1420, 
           Woods 138,",
           a(href ="mailto:smgray@sewanee.edu", "Email"),
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
        )
      ),
      
      # Second tab content
      tabItem(tabName = "Mental_Health",
              h2('Trends on Mental Health'),
              hr(),
              
              # row for title of first graph
              fluidRow(
                column(12, 'Mental Illness Rates by Demographics')
              ),
              
              # row for first graph
              fluidRow(
                
                box(
                  width = 9, plotOutput("mentalIllness_1")
                ),
                
                # select demographics for first plot
                box(
                  width = 3,
                  varSelectInput(inputId = 'ment1_dem',
                                 label = 'Select a Demographic:',
                                 data = demographics,
                                 selected = 'School Year'
                  )
                )
              ),
              fluidRow(
                box(width = 12, "note explaining how to interpret the graph")
              ),
              fluidRow(
                column(12, 'Depression Question Rates by Demographic')
              ),
              fluidRow(
                box(width = 9,
                    plotOutput( "phqPlot")
                ),
                box(
                  width = 3,
                  varSelectInput(
                    inputId = "phqdem",
                    "Select a Demographic:",
                    demographics,
                    selected = 'School Year'
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
                box(
                  width = 12,
                  textOutput('phqDesc')
                )
              ),
              fluidRow(
                column(12, 'Anxiety Question Rates by Demographic')
              ),
              fluidRow(
                box(width = 9, plotOutput("gadPlot")),
                column(
                  3,
                  varSelectInput(
                    inputId = 'gaddem',
                    label = 'Select a Demographic:',
                    data = demographics,
                    selected = 'School Year'
                  ),
                  br(),
                  varSelectInput(
                    inputId = 'gadQ',
                    label = 'Select an Anxiety Question:',
                    data = gadQues
                  )
                )
              ),
              fluidRow(
                box(width = 12, "note explaining how to interpret the graph")
              ),
              hr(),
              h2('Correlations'),
              fluidRow(
                column(12, 'Academic Impairment Rates of Students with 
                       Anxiety, Depression, and Loneliness')
              ),
              fluidRow(
                box(width = 9, plotOutput("mentalIllness_4")),
                column(
                  3,
                  varSelectInput(
                    inputId = 'ment4_vars',
                    label = 'Select a Variable:',
                    data = ment4_variables
                  )
                )
              ),
              fluidRow(
                box(width = 12, "note explaining how to interpret the graph")
              ),
              br(),
              fluidRow(
                column(12, 'Graph on Overall ever % illness')
              ),
              fluidRow(
                box(width = 9, plotOutput("plot5")),
                column(
                  3, varSelectInput(
                    inputId = 'behaviors',
                    label = 'Select a Behavior:',
                    data = behaviors
                  )
                )
              ),
              fluidRow(box(width = 12, 
                           "note explaining how to interpret the graph"))
      ),
      
      # Third tab content
      tabItem(
        tabName = 'Well_being',
        h2('Trends on Well-being'),
        hr(),
        fluidRow(
          column(12, 'Graph on Overall % of flourishing')
        ),
        fluidRow(
          box(
            width = 9, plotOutput("Fplot1")
          ),
          column(
            3,
            varSelectInput(
              inputId = 'Fdem1',
              label = 'Select a Demographic:',
              data = demographics,
              selected = 'School Year'
            )
          )
        ),
        fluidRow(
          box(width = 12, "note explaining how to interpret the graph")
        ),
        fluidRow(
          box(
            width = 9, plotOutput('dienerplot')
          ),
          column(
            3,
            varSelectInput(inputId = "flourdem",
                           label="Select a Demographic:",
                           data=demographics,
                           selected = 'School Year'
            ),
            br(),
            varSelectInput(
              inputId = 'flourq',
              label = 'Select a Flourishing Question:',
              data = flourQues
            )
          ),
        fluidRow(
          column(12, 'Graph on Overall % of those who are flourishing')
        ),
        fluidRow(
          box(
            width = 9, plotOutput("Fplot2")
          ),
          column(
            3,
            varSelectInput(
              inputId = 'Fplot2_dem',
              label = 'Select a Demographic:',
              data = demographics
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
          box(width = 12, "note explaining how to interpret the graph")
        )
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
  
  ######################
  # phq depression plot#
  ######################
  
  output$phqPlot <- renderPlot({
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
    ggplot(data = phq,
           aes(
             x = value,
             y = percent,
             fill = !!input$phqdem
           )
    ) +
      geom_col(position = 'dodge') +
      ylim(c(0,100)) +
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
      labs(title = phq$name,
           x = 'Response',
           y = 'Percent of Students') +
      scale_fill_manual(values = cbPalette)
  }, width = 'auto')
  
  
  ####################
  ### anxiety plot ###
  ####################
  
  output$gadPlot <- renderPlot({
    
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
    
    ggplot(data = gad,
           aes(x = value,
               y = percent,
               fill = !!input$gaddem
           )
    ) +
      geom_col(position = 'dodge') +
      ylim(c(0,100)) +
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
      labs(title = gad$name,
           x = 'Response',
           y = 'Percent of Students') +
      scale_fill_manual(values = cbPalette)
  }, width = 'auto')
  
  
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
  output$mentalIllness_1 <- renderPlot({
    ment <- HMS %>% 
      group_by(`School Year`) %>% 
      tally(name = "totalYear")
    
    
    # filter for those who have at least one mental illness and count them
    ment2 <- HMS %>% 
      filter(`Diagnosed Depression` ==1 | dx_bip ==1 | `Diagnosed Anxiety` ==1|
               dx_ocd ==1| dx_trauma ==1|dx_neurodev ==1 | dx_ea==1) %>% 
      group_by(`School Year`, Gender, `Class Year`, 
               Race, International, `LGBTQ+`) %>% 
      tally(name = "totalDep")
    
    
    # join both datasets
    mental_illness <- left_join(ment, ment2, by = 'School Year')
    
    
    # let's find the percent of people who have a mental illness each year
    mental_illness <- mental_illness %>% 
      mutate(percent = ( (totalDep)/(totalYear) * 100 ))
    
    
    # lets plot!
    ggplot(mental_illness, aes(x = `School Year`, 
                               y = percent, 
                               fill = !!input$ment1_dem))+
      geom_col()+
      ylim(c(0,100))+
      labs(title = 
             paste("Percentage of Students Diagnosed with a Mental Illness by", input$ment1_dem),
           subtitle = "2017 - 2021") +
      scale_fill_manual(values = cbPalette)
  }, width = 'auto')
  
  #########################
  # mental Illness plot 4 #
  #########################
  output$mentalIllness_4 <- renderPlot({
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
    ggplot(data = impairment, aes(x = aca_impa, y = percent, 
                                  fill = as.character(aca_impa)))+
      geom_col()+
      ylim(0,100)+
      labs(title = paste("Academic Impairment and", input$ment4_vars),
           y = 'Percent of Students',
           x = 'Academic Impairment') +
      scale_fill_manual(values = cbPalette) +
      theme(legend.position = 'none')
  }, width = 'auto')
  
  
  ########################################
  ########Mental Illness Plot 5###########
  ########################################
  
  output$plot5 <- renderPlot({
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
                                labels = c('No', 'Yes'))
    
    MIPercent <- HMS %>% 
      select(!!input$behaviors, mentalIllness) %>%
      filter(!is.na(!!input$behaviors)) %>% 
      group_by(!!input$behaviors, mentalIllness) %>% 
      mutate(numerator = n()) %>%
      ungroup() %>%  
      mutate(denominator = n()) %>% 
      mutate(percent = (numerator/denominator)*100)
    
    ggplot(data = MIPercent, 
           aes(x = !!input$behaviors, 
               y = percent, 
               fill = mentalIllness)) +
      geom_col(position = 'dodge')+
      ylim(c(0,100))+
      labs(title = 'Percent of Student Behaviors by Mental Illness Status') +
      scale_fill_manual(values = cbPalette)
    
  }, width = 'auto')
  
  
  ###########################################################################
  ########################### Well-being Plot 1 #############################
  ###########################################################################
  
  output$Fplot1 <- renderPlot({
    #Create an object with the percentage of students that were highly satisfied 
    dienerpercent<- HMS%>% 
      filter(!is.na(diener_status)) %>% 
      group_by(!!input$Fdem1, diener_status) %>% 
      tally() %>% 
      ungroup() %>% 
      mutate( total = sum(n)) %>% 
      mutate(percent = (n/total)*100)
    
    ###PLOT 1:the students'flourishing score#####
    ggplot(data = dienerpercent)+
      geom_col(aes(x = diener_status, y = percent,
                   fill = !!input$Fdem1))+
      ylim(c(0, 100)) +
      coord_flip()+
      labs(title = 'Overall Life Satisfaction for Students',
           y='Percentage of Students',
           x='Status') +
      scale_fill_manual(values = cbPalette)
  }, width = 'auto')
  
  ###########################################################################
  ########################### diener plot by ? ##############################
  ###########################################################################  
  output$dienerplot <- renderPlot({
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
    ggplot(data = flourishing,
           aes(x = value,
               y = percent/100,
               fill = !!input$flourdem
           )
    ) +
      geom_col(position = 'dodge') +
      ylim(c(0,100)) +
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
      labs(title = flourishing$name ,
           x = 'Response',
           y = 'Percent of Students') +
      scale_fill_manual(values = cbPalette)
  }, width = 'auto')
  
  ###########################################################################
  ########################### Well-being Plot 2 #############################
  ###########################################################################
  
  output$Fplot2 <- renderPlot({
    
    # what can we learn more about people who are considered 'flourishing' vs not
    
    # select variables 
    action_flourish <- HMS %>% 
      select( `School Year`, Race, Gender,`Class Year`, diener_score,
              Exercise, `Therapy Use`, ther_help, ther_helped_me, `Smoking Frequency`, 
              Vaping, binge, `Greek Life`, `Varsity Athletics`, sleep_wk1, 
              sleep_wk2, Sleep, sleep_wd2,International, `LGBTQ+`, 
              drug, `Alcohol Use`)
    
    # create a new 'hours of sleep column'
    # account for extraneous sleep outliers by making them NA
    action_flourish <- action_flourish %>%
      mutate(hrs_sleep_wkday = 
               (as.numeric(sleep_wk2) - as.numeric(sleep_wk1)))%>%
      mutate(hrs_sleep_wkend = 
               (as.numeric(sleep_wd2) - as.numeric(Sleep)))%>%
      mutate(hours_of_sleep = 
               ((hrs_sleep_wkend + hrs_sleep_wkday) / 2))%>%
      mutate(hours_of_sleep = 
               ifelse(hours_of_sleep< 4 | hours_of_sleep > 13,NA,hours_of_sleep)
      ) %>% filter(!is.na(hours_of_sleep))
    
    # define flourishing and mark respondents
    # 8 questions, scale of 1-7. 90th percentile: >= 49
    # note: we can subset flourishing by more ranges
    action_flourish <- action_flourish %>% 
      mutate(flourish_status = case_when(diener_score >= 49 ~ "Flourishing",
                                         TRUE ~ "Not flourishing"))
    
    # find percent of people who flourish vs not, grouped by selected variables
    action_flourish <- action_flourish %>% 
      filter(!is.na(!!input$Fplot2_var)) %>% 
      group_by(flourish_status, !!input$Fplot2_var) %>% 
      tally() %>% 
      ungroup() %>% 
      mutate(total = sum(n),
             percent = (n)/(total) * 100) 
    
    ggplot(data = action_flourish)+
      geom_col(aes(x = !!input$Fplot2_var,
                   y = percent,
                   fill = flourish_status), 
               position = 'dodge')+
      ylim(c(0, 100)) +
      labs(fill = 'Flourishing Status',
           y = 'Percent of Students',
           title = 'Percent of Student Behaviors by Flourishing Status')+
      scale_fill_manual(values = cbPalette)
    }, width = 'auto')
  
}
shinyApp(ui, server)