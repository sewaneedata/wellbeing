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

# changing the international column from 0 and 1 to 'No' and 'Yes" respectively
HMS$international <- factor(HMS$international, levels = c(0,1),
                            labels = c('No', 'Yes'))


# making every race that has less than 6 people grouped into 'race_other'
HMS <- HMS %>%
  group_by(race) %>%
  filter(!is.na(race)) %>%
  mutate(total = n()) %>%
  ungroup() %>%
  mutate(race = ifelse(total <= 5, 'race_other', race))

# Created new lgbtq+ column from gender and sexuality, then moved trans into
# respective gender category
HMS <- HMS %>%
  filter(!is.na(gender), !is.na(sexuality)) %>%
  mutate( LGBTQ = ifelse(!(((gender == 'gender_male' |
                               gender == 'gender_female')) &
                             (sexuality == 'sexual_h')), 1, 0)) %>%
  mutate(gender = ifelse(gender == 'gender_transm', 'gender_male', gender),
         gender = ifelse(gender == 'gender_transf', 'gender_female', gender),
         gender = ifelse(grepl(", ", gender), "gender_selfID", gender))

# changing the LGBTQ column from 0 and 1 to 'No' and 'Yes" respectively
HMS$LGBTQ <- factor(HMS$LGBTQ, levels = c(0,1),
                    labels = c('No', 'Yes'))


# changing class year from a range of numbers, to their respective values
HMS$classYear <- factor(HMS$classYear, 
                        levels = c(1, 2, 3, 4, 5),
                        labels = c('1st Year', "2nd Year",
                                   '3rd Year', '4th Year',
                                   '5th Year'))

phqQuestions <- c('Little interest or pleasure in doing things' = 'phq9_1',
                  'Feeling down, depressed or hopeless' = "phq9_2",
                  'Trouble falling or staying asleep, 
                  or sleeping too much' = 'phq9_3',
                  'Feeling tired or having little energy' = 'phq9_4',
                  'Poor appetite or overeating' = 'phq9_5',
                  'Feeling bad about yourself—or that you are a failure 
                  or have let yourself or your family down' = 'phq9_6',
                  'Trouble concentrating on things, such as reading the 
                  newspaper or watching television' = 'phq9_7',
                  'Moving or speaking so slowly that other people could have 
                  noticed; or the opposite—being so fidgety or restless that 
                  you have been moving around a lot more than usual' = 'phq9_8',
                  'Thoughts that you would be better off dead or of hurting 
                  yourself in some way' = 'phq9_9')

phqQues <- HMS %>% 
  select(phq9_1:phq9_9)

gadQues <- HMS %>% 
  select(gad7_1:gad7_7)

demographics <- HMS %>%
  select('race', 'gender', 'international', 'classYear', 'schoolYear', 'LGBTQ')

################################################################################
####################################### ui #####################################
################################################################################
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
                depression, anxiety and serious mental health crises has doubled
                among college students, according to Daniel Eisenberg, a principal
                investigator of the Healthy Minds Study: an annual survey of
                thousands of students across the country (Hartocollis, New York
                Times 2021)."
        ),
        br(),
        
        # about healthy minds
        h4(
          "For the past four years, Sewanee undergrad students have
                been filling out the Healthy Minds Survey (HMS), a survey that
                asks questions about mental health outcomes, knowledge and
                attitudes about mental health and service utilization. The HMS is
                used by a network of colleges and emphasizes understanding
                help-seeking behavior, examining stigma, knowledge, and other
                potential barriers to mental health service utilization."
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
                column(12, 'Graph on Overall % of mentall illness diagnoses')
              ),
              
              # row for first graph
              fluidRow(
                
                box(
                  width = 9, plotOutput("plot1")
                ),
                
                # select demographics for first plot
                box(
                  width = 3,
                  selectInput(inputId = 'dem1',
                              label = 'Select a demographic:',
                              c('Race', 'Gender', 'Class Year')
                  )
                )
              ),
              fluidRow(
                box(width = 12, "note explaining how to interpret the graph")
              ),
              fluidRow(
                column(12, 'Graph on Overall % dep (phq) by question')
              ),
              fluidRow(
                box(width = 9,
                    plotOutput( "phqPlot", width=250 )
                ),
                box(
                  width = 3,
                  varSelectInput(
                    inputId = "phqdem",
                    "Variable:",
                    demographics
                  ),
                  br(),
                  varSelectInput(
                    inputId = 'phqQ',
                    label = 'Select a depression question:',
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
                column(12, 'Graph on Overall % anx (gad) by question')
              ),
              fluidRow(
                box(width = 9, plotOutput("gadPlot")),
                column(
                  3,
                  varSelectInput(
                    inputId = 'gaddem',
                    label = 'Select a demographic:',
                    data = demographics
                  ),
                  br(),
                  varSelectInput(
                    inputId = 'gadQ',
                    label = 'Select a anxiety question:',
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
                column(12, 'Graph on Overall % illness (anx,dep,lone)')
              ),
              fluidRow(
                box(width = 9, plotOutput("plot4")),
                column(
                  3,
                  selectInput(
                    inputId = 'illness',
                    label = 'Select an illness:',
                    c('Anx', 'Dep', 'Loneliness')
                  ),
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
                  3, selectInput(
                    inputId = 'problem',
                    label = 'Select a variable:',
                    c('sleep', 'Exercise', 'therapy'
                    )
                  ),
                )
              ),
              fluidRow(box(width = 12, "note explaining how to interpret the graph"))
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
            selectInput(
              inputId = 'Fdem1',
              label = 'Select a demographic:',
              c('Race', 'Gender', 'Class Year')
            ),
            br(),
            selectInput(
              inputId = 'dienerQ',
              label = 'select a diener question',
              choices = c(1, 2, 3)
            )
          )
        ),
        fluidRow(
          box(width = 12, "note explaining how to interpret the graph")
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
            selectInput(
              inputId = 'Fplot2',
              label = 'Select a demographic:',
              c('Race', 'Gender', 'Class Year')
              
            ),
            br(),
            selectInput(
              inputId = 'variable',
              label = 'Select a Variable:',
              choices = c('sleep', 'exercise', 'counseling')
            )
          )
        ),
        fluidRow(
          box(width = 12, "note explaining how to interpret the graph")
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
  
  # phq depression plot
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
    phq$name <- factor(phq$name, levels = c('phq9_1', 'phq9_2','phq9_3', 
                                            'phq9_4', 'phq9_5', 'phq9_6', 
                                            'phq9_7', 'phq9_8', 'phq9_9'), 
                       labels = c(
                         "Little interest or pleasure in doing things", 
                         "Feeling down, depressed or hopeless",
                         'Troubles with Sleep',
                         'Feeling tired or having little energy',
                         'Poor appetite or overeating',
                         'Feeling bad about yourself',
                         'Trouble concentrating on things',
                         'Moving or speaking so slowly; or the opposite',
                         'Thoughts about being dead or 
                                hurting yourself'))
    
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
           y = 'Percent of Students')
  }, width = 670)
  
  
  
  # demographics plot
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
    gad$name <- factor(gad$name, levels = c('gad7_1', 'gad7_2','gad7_3',
                                            'gad7_4', 'gad7_5', 'gad7_6',
                                            'gad7_7'), 
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
           y = 'Percent of Students')
  }, width = 670)
  
  
  # output$phqDesc <- renderText({
  #   text <- switch(as.character(input$phqdem),
  #                  race = 'interpetation',
  #                  gender = 'interpetation',
  #                  international = 'interpretation',
  #                  LGBTQ = 'interpretation',
  #                  classYear = 'interpretation',
  #                  schoolYear = 'interpretation')
  # })
  
}

shinyApp(ui, server)
