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
    selectInput("x", "Please select a demographic category to view:",
                choices=c("All", "African American", "American Indian", "Asian",
                          "Chicano/Latino", "International", "Unknown", 
                          "White"), selected="All"),
    
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
      filter(ethnicity==input$x, campus==input$y, category==input$z) %>%
      ggplot(aes(x=academic_yr, y=filtered_count_fr, fill=academic_yr))+
      geom_line()+
      theme(axis.text.x=element_text(angle=45, hjust=1))+
      labs(title = "Yearly Admissions Data",
           x = "Year",
           y= "Total Count")
  }) # closes the plot generating output
  
} # closes the server

shinyApp(ui, server)