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
              h1("Header: Healthy Minds Survey"),
              br(),
              hr(),
              br(),
              fluidRow('Overall info about HMS'),
              fluidRow('Caps info/links, learn more about the datalab team')
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
              h3(strong("What is DataLab?")),
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
                                em("this is why I joined datalab")))),
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
                                "this is why ..."))))
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
