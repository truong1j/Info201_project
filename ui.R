#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(data.table)
library(tidyr)
library(leaflet)
library(htmltools)
library(plotly)


# Define UI for application that draws a histogram
page_one <- tabPanel(
  "Introduction"# label for the tab in the navbar
)

# Define content for the second page
page_two <- tabPanel(
  "Current energy data", 
  p("Interactive map outlining the current energy production in the US tbd. Couldnt get it to load.
    BTW, merging is hard :) ")
)

# Define content for the third page
page_three <- tabPanel(
  "Potential energy data", # label for the tab in the navbar
  titlePanel("Energy Production by State"),
  sidebarLayout(     
    
    
    sidebarPanel(
      selectInput("state", "State:",
                  choices=energy_sources$X),
      hr(),
      helpText("Data gathered from")
    ),
    
    mainPanel(
      plotOutput("energyPlot"),
      p("This is a basic plot that displays an input menu (State) and outputs
        a bar graph that changes based on the state inputed. The graph outlines
        the three different types of energy production in megawatt hours. I
        that this is a very basic outline and has room to grow.")
      
      )
    )
)
page_four <- tabPanel(
  "Comparison", # label for the tab in the navbar
  titlePanel("Comparision across current and potential energy production"),
  sidebarLayout(
    selectInput(
      "radio_energy",
      "Types of energy",
      choices = colnames(all_potential)),
    hr()
    
  ),
  mainPanel(
    # Show a plot of the generated distribution
    plotOutput("my_id")
  )
)
page_five <- tabPanel(
  "Conclusion" # label for the tab in the navbar
  # ...more content would go here...
)


# Pass each page to a multi-page layout (`navbarPage`)
ui <- navbarPage(
  "Green with Envy", # application title
  page_one,         # include the first page content
  page_two,         # include the second page content
  page_three,
  page_four,
  page_five# include the third page content
)


