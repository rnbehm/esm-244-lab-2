library(shiny)
library(tidyverse)
library(shinythemes)
library(RColorBrewer)

# get da data
marvel <- read_csv("marvel-wikia-data.csv")

marvel$SEX[is.na(marvel$SEX)] <- "Not Specified"

#create user interface
ui<- fluidPage(
  
  theme = shinytheme("slate"),
  titlePanel("Marvel Characters"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("side",
                  "Choose a side",
                  c("Good Characters",
                    "Bad Characters",
                    "Neutral Characters"))
    ),
    mainPanel(
      plotOutput(outputId ="marvelplot")
    )
  )
  
  
)

server<- function(input, output) {
  
  output$marvelplot<- renderPlot({
    
    ggplot(filter(marvel, ALIGN== input$side), aes(x=Year))+
      geom_bar(aes(fill=SEX), position= "fill")+
      theme_dark()
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

