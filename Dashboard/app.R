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
              h2('About the Well-being Dream Team'),
              h3('DataLab 2022 Contributors'),
              fluidRow(column(3, 'Jarely Soriano'),
                       column(3, 'Sam Dean'),
                       column(3, 'Michael Komnick'),
                       column(3, 'Temi Adejumobi')),
              fluidRow(column(3, imageOutput("jarely")),
                       column(3, imageOutput("sam")),
                       column(3, imageOutput("michael")),
                       column(3, imageOutput("temi"))))
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
  
  
  
  # all the outputs for our images on the about page  
  output$jarely <- renderImage({
    return(list(src = "./jarely.jpg", width = "100%", contentType = "image/jpg", alt = "Jarely"))
  }, deleteFile = FALSE)
  
  output$sam <- renderImage({
    return(list(src = "./sam.jpg", width = "100%", contentType = "image/jpg", alt = "Sam"))
  }, deleteFile = FALSE)
  
  output$michael <- renderImage({
    return(list(src = "./michael.jpg",  width = "100%", contentType = "image/jpg", alt = "Michael"))
  }, deleteFile = FALSE)
  
  output$temi <- renderImage({
    return(list(src = "./temi.jpg",  width = "100%", contentType = "image/jpg", alt = "Temi"))
  }, deleteFile = FALSE)
  
}



shinyApp(ui, server)
