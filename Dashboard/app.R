## app.R ##

# loading libraries
library(shinydashboard)
library(dashboardthemes)
library(ggplot2)
library(ggthemes)

# getting combined data
source("../merged.R")

# creating an options vector so we can label our x-axis

options <- c("Academic Impairment" = "aca_impa",
             "Therapy Use" = "ther_ever")

ui <- dashboardPage(
  # title of dashboard
  dashboardHeader(title = "Cracking the Code to Student Flourishing",
                  titleWidth = 400),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Demographics", tabName = 'info', icon = icon("user")),
      menuItem("Flourishing", tabName = "flourishing", 
               icon = icon("leaf")),
      menuItem("Mental Illness", tabName = 'mental_illness', 
               icon = icon('brain')),
      menuItem("About", tabName = 'about', icon = icon('question'))
    )
  ),
  ## Body content
  dashboardBody(
    shinyDashboardThemes(theme = "poor_mans_flatly"),
    tabItems(
      
      # First tab content
      tabItem(tabName = "home",
              h2("Healthy Minds Survey"),
              fluidRow('This is about the survey:'),
              br(),
              hr(),
              br(),
              fluidRow('Here are some services if you find this information distressing: trigger warning, caps info')
      ),
      # Second tab content
      tabItem(tabName = 'info',
              fluidRow(
                box(
                  title = "Count of students (by variable selected)",
                  selectInput(inputId = 'demvar',
                              label = "Select a demographic variable:",
                              choices = c("Class Year" = 'classYear',
                                          "Age" = 'age',
                                          "Gender" = 'gender'))
                )
              ),
              fluidRow(
                box(plotOutput('demplot'), width =12))
      ),
      # Third tab content
      tabItem(tabName = "flourishing",
              fluidRow(
                box(
                  title = "Positive Mental Health vs. (Variable)",
                  selectInput(inputId = "variable",
                              label = "Select a Variable:",
                              choices = options),
                  width = 12
                )
              ),
              fluidRow(
                # need boxes for putting plots in dashboard
                box(plotOutput("plot1"), width = 12)),
              
      ),
      # Fourth tab content
      tabItem(tabName = 'mental_illness',
              h2('mental illness graphs'),
              fluidRow('hopefully similar to the flourishing graph(s)')),
      # Fifth tab content
      tabItem(tabName = 'about',
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

server <- function(input, output) {
  # creating reactive values for dynamic variables in plots
  rv <- reactiveValues()
  observe({
    
    # 'copying' combined into a different dataframe 
    # so we are not changing our combined data
    data <- combined
    
    # changing the labels of aca_impa from numeric to characters
    data$aca_impa <- factor(data$aca_impa, levels = c(1, 2, 3, 4), 
                            labels = c("None", "1-2 Days", 
                                       "3-5 Days", "6 or more Days"))
    
    # changing the labels of ther_ever from numeric to characters
    data$ther_ever <- factor(data$ther_ever, levels = c(1, 2, 3, 4),
                             labels = c("No, never", 
                                        "Yes, prior \n to starting \n college", 
                                        "Yes, since \n starting college", 
                                        "Yes, prior \n to and since \n starting college"))
    
    rv$plot1data <- data %>% 
      select(input$variable, diener_score, schoolYear) %>%  
      group_by(diener_score, input$variable, schoolYear)
    
    
    rv$count <- combined %>% 
      group_by(schoolYear) %>%
      tally() 
    
    
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
  
  # the output of the flourishing interactive plot  
  ## comment what the plot is trying to say
  ## somewhere add the question/ variables mean
  output$plot1 <- renderPlot({
    ggplot(data = rv$plot1data %>% drop_na(input$variable),
           aes_string(x = input$variable,
                      y = "diener_score",
                      fill = input$variable)
    ) +
      geom_jitter() +
      geom_violin(alpha = 0.5) +
      theme_gdocs() +
      theme(legend.position = 'none') +
      # theme(axis.text.x = element_text(angle = 90)) +
      labs(
        subtitle = 'By School Year',
        caption = 'Well-Being Dream Team',
        x = names(options)[which(options == input$variable)],
        y = 'Positive Mental Health Score') +
      facet_wrap(~schoolYear)
  })
  output$demplot <- renderPlot({
    ggplot(data = rv$count, aes(x = schoolYear, y = n, fill = input$demvar)) +
      geom_col()
  })
}

shinyApp(ui, server)