# Libraries
library(tidyverse)
library(shiny)
library(shinydashboard)
library(naniar)
library(janitor)

# Data
UC_admit <- read_csv("../../lab14/data/UC_admit.csv") %>% clean_names()

# App Script
ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(disable=T),
  dashboardBody(
    selectInput("x", "Please select the year to view:",
                choices=c(2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018,
                          2019), selected=2010),
    
    selectInput("y", "Please select a campus to view:", 
                choices=c("Berkeley","Davis","Irvine","Los_Angeles","Merced",
                          "Riverside","San_Diego","Santa_Barbara","Santa_Cruz"), 
                selected="Berkeley"),
    
    selectInput("z", "Please select an admissions data category:",
                choices=c("Applicants","Admits","Enrollees"),
                selected="Applicants"),
    
    plotOutput("plot", width="600px", height="500px")
    
  ) # closes the dashboardBody
) # closes the dashboardPage

server <- function(input, output, session) {
  
  session$onSessionEnded(stopApp)
  
  output$plot <- renderPlot({
    UC_admit %>%
      filter(academic_yr==input$x, campus==input$y, category==input$z, ethnicity!="All") %>%
      ggplot(aes(x=ethnicity, y=filtered_count_fr, fill=ethnicity))+
      geom_col()+
      theme(axis.text.x=element_text(angle=45, hjust=1))+
      labs(title = "Admissions Data by Ethnicity",
           x = "Ethnicity",
           y= "Total Count")
  }) # closes the plot generating output
  
} # closes the server

shinyApp(ui, server)