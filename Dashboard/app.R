## app.R ##

# loading libraries
library(shinydashboard)
library(dashboardthemes)
library(ggplot2)
library(ggthemes)

# getting combined data
source("../merged.R")


ui <- dashboardPage(
  
  # title of dashboard
  dashboardHeader(title = "Cracking the Code to Student Flourishing",
                  titleWidth = 400),
  
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "Home", icon = icon("home")),
      
      menuItem("Student Mental Health", tabName = 'Mental_Health',
               icon = icon('brain')),
      
      menuItem("Student Well-being", tabName = "Well_being",
               icon = icon("leaf")),
      
      menuItem("About", tabName = 'About', icon = icon('question'))
    )
  ),
  
  ## Body content
  dashboardBody(
    shinyDashboardThemes(theme = "grey_dark"),
    
    tabItems(
      # First tab content
      tabItem(tabName = "Home",
              h1("Cracking the Code to Student Flourishing"),
              br(),
              hr(),
              h3("Sewanee has fostered some of the greatest academics and
              so many are flourishing and thrive! But how? What can we learn 
              from those who are thriving? Over the past decade, the rate of 
              depression, anxiety and serious mental health crises has doubled 
              among college students, according to Daniel Eisenberg, a principal
              investigator of the Healthy Minds Study: an annual survey of 
              thousands of students across the country (Hartocollis, New York 
              Times 2021).
                       "),
              br(),
              br(),
              h3("For the past four years, Sewanee undergrad students have
              been filling out the Healthy Minds Survey (HMS), a survey that 
              asks questions about mental health outcomes, knowledge and 
              attitudes about mental health and service utilization. The HMS is 
              used by a network of colleges and emphasizes understanding 
              help-seeking behavior, examining stigma, knowledge, and other 
              potential barriers to mental health service utilization. 
                       "),
              br(),
              br(),
              h3("Our team of researchers at Sewanee DataLab have analyzed
                       HMS survey data to answer pressing questions about 
                       flourishing at Sewanee. The four years of HMS data we 
                       have will allow us to find correlations between student 
                       health, habits, and flourishing. This project is in 
                       partnership with the Associate Dean of Student 
                       Flourishing at Sewanee Dr. Nicole Noffsinger-Frazier and 
                       under mentorship of Dr. Sylvia Gray, Title IX coordinator.
                       "),
              br(),
              h3("Click around to learn more about how we Cracked the Code
              to Student Flourishing!!! 
                       "),
              br(),
              br(),
              h3("WARNING : Some of the graphs may contain potentially 
              triggering information. If you’re unfamiliar with Sewanee’s 
              Counseling and Psychological Services, call 931-598-1325.
                       "),
              br(),
              br(),
              h3("University Wellness Center Counseling and Psychological Services: 931-598-1325",
                 br(),
                 "ProtoCall: 931-598-1700 (used after 5pm)",
                 br(),
                 "Title IX Coordinator at Sewanee, Dr. Sylvia Gray: 931-598-1420, Woods 138, smgray@sewanee.edu",
                 br(),
                 "Chattanooga Rape Crisis Center: 423-755-2700",
                 br(),
                 "24-Hour Sexual Assault Violence Response Team (Nashville): 1-800-879-1999",
                 br(),
                 "RAINN (Rape, Abuse & Incest National Network): 1-800-656-4673",
                 br(),
                 "Southern Tennessee Regional Hospital - Sewanee: 931-598-5691",
                 br()
              )
      ),
      
      # Third tab content
      tabItem(tabName = "Mental_Health",
              br(),
              hr(),
              br(),
              fluidRow("Trends on Mental Health"),
              fluidRow("answer prioritized questions")
      ),
      
      
      # Second tab content
      tabItem(tabName = 'Well_being',
              br(),
              hr(),
              br(),
              fluidRow("Trends on flourishing over time"),
              fluidRow("subset by select demographics"),
              fluidRow("")
              
      ),
      
      # Fifth tab content
      tabItem(tabName = 'About',
              h2('About the Well-being Project'),
              hr(),
              h3(strong("What is DataLab </>?")),
              br(),
              h4("DataLab is a summer internship program at Sewanee: the University of the South that partners with DSSG, Data Science for Social Good, to develop data science skills in students by analyzing data sets related to pressing social and environmental problems."),
              br(),
              h3(strong('Well-being Dream Team:')),
              br(),
              br(),
              fluidRow(column(4, 
                              tags$img(src = "jarely.jpg", 
                                       width = "100%", 
                                       alt = "Picture of Jarely")),
                       column(8, 
                              h3("Jarely Soriano | ",
                                 a(href = 'mailto:soriaja0@sewanee.edu',
                                   'Email Me')),
                              h4(em("C'23 IGS: Latin American and Caribbean Studies and Global Politics")),
                              tags$blockquote(
                                em("I joined DataLab because I wanted to learn something new and do something impactful. If i’ve learned one thing during this experience, it’s that information can be beautiful and powerful.")))),
              br(),
              fluidRow(column(4,
                              tags$img(src = "sam.jpg",
                                       width = "100%",
                                       alt = "Picture of Sam")),
                       column(8, h3('Sam Dean | ', 
                                    a(href = 'mailto:deansn0@sewanee.edu',
                                      'Email Me')),
                              h4(em("C'23 Psychology")),
                              tags$blockquote(
                                em("Being invited to be a part of DataLab 2022 has been one of the most enriching opportunities I have experienced. Not only did my coding skills improve, I was shown how to incorporate two fields I am most passionate about: data science and mental health.")))),
              br(),
              fluidRow(column(4,
                              tags$img(src = "michael.jpg",
                                       width = "100%",
                                       alt = "Picture of Michael")),
                       column(8, h3('Michael Komnick | ', 
                                    a(href = "mailto:komnimj0@sewanee.edu",
                                      'Email Me')),
                              h4(em("C'24 Computer Science")),
                              tags$blockquote(em(
                                "I heard that DataLab was a great opportunity to use my computer science skills for social good. I also wanted to increase my network and connections with professionals in the field I am most passionate about.")))),
              br(),
              fluidRow(column(4,
                              tags$img(src = "temi.jpg",
                                       width = "100%",
                                       alt = "Picture of Temi")),
                       column(8, h3('Temi Adejumobi | ', 
                                    a(href ="mailto:adejuoj0@sewanee.edu", 
                                      "Email Me")),
                              h4(em("C'24 Computer Science")),
                              tags$blockquote(em(
                                "DataLab 2022 has been a wonderful experience! I am grateful for the opportunity to embrace a purpose beyond oneself while creating sustainable impact in the lives of others. This summer has allowed me to learn and develop important technical and transferable skills; working with and learning from interesting people."))))
      )
    )
  )
)

################################################################################
# server
################################################################################

server <- function(input, output){
  
  # creating reactive values for dynamic variables in plots
  rv <- reactiveValues()
  observe({
    
  })
  
  ###############################################################################
  # plots  
  ###############################################################################
  
  # flourishing plot
  output$plot1 <- renderPlot({
    
  })
  
  
  # demographics plot
  output$demplot <- renderPlot({
    
  })
  
}



shinyApp(ui, server)
