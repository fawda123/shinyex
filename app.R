library(shiny)
library(tidyverse)

source('R/functions.R')
otbfimdat <- read.csv('data/otbfimdat.csv')

# get selection options
fish <- unique(otbfimdat$Commonname)
size <- range(otbfimdat$avg_size, na.rm = T)
gear <- unique(otbfimdat$Gear)

# Shiny UI
ui <- fluidPage(
  
  titlePanel("Plotting FIM catch data"),
  
  sidebarLayout(
    
    sidebarPanel(
      selectInput(inputId = 'fishsel', label = 'Select species', choices = fish, 
                  selected = 'Red Drum'),
      uiOutput('uisize'),
      selectInput(inputId = 'gearsel', label = 'Select gear', choices = gear, 
                  selected = '20')
      ),
    
    mainPanel(
      plotOutput('plo')
    )
    
  )
  
)

# Shiny server
server <- function(input, output){
  
  output$uisize <- renderUI({
    
    size <- otbfimdat %>% 
      filter(Commonname %in% input$fishsel) %>% 
      pull(avg_size) %>% 
      range(na.rm = T)
    
    sliderInput(inputId = 'sizesel', label  = 'Select size range (mm)', 
                min = size[1], max = size[2], value = size)
    
  })
  
  output$plo <- renderPlot({
    
    req(input$sizesel)
    
    plotcatch(
      name = input$fishsel, 
      szrng = input$sizesel, 
      gearsel = input$gearsel, 
      datin = otbfimdat)
    
  })
  
}

# run app
shinyApp(ui = ui, server = server)