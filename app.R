library(shiny)
library(tidyverse)

source('R/functions.R')
data(otbfimdat)

# get selection options
fish <- unique(otbfimdat$Commonname)
size <- range(otbfimdat$avg_size, na.rm = T)
gear <- unique(otbfimdat$Gear)

# Shiny UI
ui <- fluidPage(
  selectInput(inputId = 'fishsel', label = 'Select species', choices = fish, 
              selected = 'Red Drum'),
  sliderInput(inputId = 'sizesel', label  = 'Select size range (in)', 
              min = size[1], max = size[2], value = size),
  selectInput(inputId = 'gearsel', label = 'Select gear', choices = gear, 
              selected = '20'), 
  plotOutput('plo')
)

# Shiny server
server <- function(input, output){
  output$plo <- renderPlot({
    plotcatch(
      name = input$fishsel, 
      szrng = input$sizesel, 
      gearsel = input$gearsel, 
      datin = otbfimdat)
  })
}

# run app
shinyApp(ui = ui, server = server)