library("tidyverse")
library("shiny")

homerange <- readr::read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")

ui <- fluidPage(
  
  radioButtons("f", "Select Your Fill Option", choices = c("trophic.guild", "thermoregulation"), 
               selected = "trophic.guild"), #alternate starting menu display
  
  plotOutput("plot", width="500px", height="400px")
)

server <- function(input, output, session) {
  
  output$plot <- renderPlot({ #specifies the function is to make a plot
    
    ggplot(data=homerange, aes_string(x="locomotion", fill=input$f))+
      geom_bar(position = "dodge", alpha=0.8, color="black")+
      labs(x=NULL, fill="Fill Variable")+
      theme_light(base_size=18)
    
    
    
  })
  
}#closes the server function

shinyApp(ui, server)