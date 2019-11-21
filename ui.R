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
  "Introduction",
  
  p("Link to the technical report: https://github.com/truong1j/Info201_project/wiki/Technical-Report"),
  h2("Problem Situation"),
  p("'Wind turbines, solar panels and electric vehicles are spreading 
    far more quickly around the world than many experts had predicted.
    But this rapid growth in clean energy isn’t yet fast enough to slash
    humanity’s greenhouse gas emissions and get global warming under control'
    (New York Times). Washington is said to be one of the nation’s largest 
    producers of renewable energy and we hope to analyze the production potential 
    and actual generation of green energy across the United States. Within green energy production, 
    we find that there are many stakeholders including but not limited to energy companies, energy 
    consumers (residential, commercial, industrial, and transportation sectors), and environmentalists,
    to mention a few. A piece of policy that touches on the topic of green energy is Washington state 
    passing law requiring 100% clean energy by 2045. Beyond this law, the country has seen a rise in 
    interest in other legislation such as the Green New Deal, which has become a point of campaign for 
    Democratic candidates leading up to the 2020 election."),
  h2("What is the problem?"),
  p("There are ample areas for improvement in terms of energy efficiency, 
    one of which is utilizing renewable energy production across the United States
    that are not being used to their full potential. We will find which states are 
    using fully reaching their potential and which states are not by comparing their 
    current production to the potentiality of their production.")
)

# Define content for the second page
page_two <- tabPanel(
  "Current energy data", 
  p("Interactive map outlining the current energy production in the US tbd. Couldnt get it to load.
    BTW, merging is hard :) ")
  # label for the tab in the navbar
)

# Define content for the third page
page_three <- tabPanel(
  "Potential energy data", # label for the tab in the navbar
  titlePanel("Energy Production by State(Potential)"),
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
  "Conclusion",# label for the tab in the navbar
  p("Conclusion will be updated for the final project deliervable...")
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


