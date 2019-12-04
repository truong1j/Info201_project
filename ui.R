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
library(shinythemes)
source("map.R")
energy_sources <- potential_data2 %>% 
  select(State, hydropower_GWh, EGSGeothermal_GW, onshoreWind_GWh)
# Define UI for application that draws a histogram
page_one <- tabPanel(
  "Introduction",
  
  p("Link to the technical report: https://github.com/truong1j/Info201_project/wiki/Technical-Report"),
  h2("Problem Situation"),
  p("Wind turbines, solar panels, and electric vehicles are growing 
    enormously across the globe, however this growth isn’t fast 
    enough to match our greenhouse gas emissions and help the fight 
    against climate change. The International Energy Agency published 
    its annual World Energy Outlook showing that growth of these clean 
    energies will only hasten with the technologies getting cheaper and
    more countries acting on clean energy legislation and targets. 
    Although this potential seems uplifting, people are only using more 
    energy and because of reliance on fossil fuels, it is causing a continual 
    rise in greenhouse gas emissions."),

  p("Below is a visualization of Carbon Dioxide Emission by Energy source between 1973 and 2018 in the United States."),

  plotOutput("co2"),
  
  p("This visual tells us that we have seen a fairly consistent emission of carbon dioxide in the past five decades, 
    despite the growth in renewables. Along with a consistent emission of approximately 7500 million metric tons of 
    carbon dioxide over the last 50 years. The significance of this lies in the greenhouse effect, illustrated below:"),
  uiOutput("image1"),
  a("Source", href = "https://www.environmentblog.net/what-is-the-greenhouse-effect/"),
  
  
  
  em("“Global energy-related CO2 emissions grew 1.7% in 2018 to reach a historic high of 33.1 Gt CO2. It was the highest rate of growth since 2013, and 70% higher than the average increase since 2010… The increase in emissions was driven by higher energy consumption resulting from a robust global economy, as well as from weather conditions in some parts of the world that led to increased energy demand for heating and cooling.” [IEA]"),
  p("With the need for renewable energy being so dire, we hope to assess how states are sizing up to the challenge."),
  
  
  
  p(" Washington is said to be one of the nation’s largest producers of renewable energy and 
    we hope to analyze the production potential and actual generation of green energy across
    the United States. Within green energy production, we find that there are many stakeholders 
    including but not limited to energy companies, energy consumers (residential, commercial, 
    industrial, and transportation sectors), and environmentalists, to mention a few. A piece of 
    policy that touches on the topic of green energy is Washington state passing law requiring 100% 
    clean energy by 2045. Beyond this law, the country has seen a rise in interest in other legislation 
    such as the 'Green New Deal'
    which has become a point of campaign for Democratic candidates leading up to the 2020 election. There are ample areas for improvement in 
    terms of energy efficiency, one of which is utilizing renewable energy production across the United States that are not being used to their 
    full potential. We will find which states are using fully reaching their potential and which states are not by comparing their current production 
    to the potentiality of their production.")
  
)

# Define content for the second page
page_two <- tabPanel(
  "Current energy data", 
  h2("Map of Current Energy Production"),
sidebarPanel(p(
"This interactive map displays the total renewable energy output for every state. 
We thought that this data visualization would be a good introduction to our project as it's aggregate data. It first provides a user with an overview of the renewable energy production prevalent in each state and an understanding of the sheer magnitude of said production. We structured it so the following tabs explore more granular results and more detailed breakdowns of each type of renewable energy produced per state.")),
  mainPanel(
    leafletOutput("map"),
    h6("This data was gathered from the U.S Energy Information Administration")
  )

)
# Define content for the third pages
page_three <- tabPanel(
  "Potential energy data", # label for the tab in the navbar
  sidebarLayout(     
    
    
    sidebarPanel(
      selectInput("state", "State:",
                  choices=energy_sources$State),
      hr(),
      helpText("Data gathered from Data.World")
    ),

    mainPanel(
      plotOutput("energyPlot"),
      helpText("The y-axis denotes the generation of energy in gigawatt hours, while the x-axis denotes the three difffering types of
               energy production: wind, hydroelectric, and geothermal."),
      p("This graph outlines the potential energy production by state. The three energy sources outlined (geothermal, onshore wind, and hydropower) vary in potential production by state. One observation is that the potential for geothermal energy production is very low, as geothermal energy is not the most efficient means of energy production currently. While hydropower energy production and onshore wind energy production have massive room for improvement in states such as Connecticut and Washington. Overall, it is evidently clear that the fight for clean energy still has massive room for improvement. In the mean time, lawmakers should analyze these potentials and discuss the best options for their respective states moving forward."),
      a(href = "https://energyadvantageinvestor.com/wp-content/uploads/EAI-September-Blog-4-1.jpg"),
       uiOutput("image")
    ))
      
      )
    

page_four <- tabPanel(
  "Comparison", # label for the tab in the navbar
  titlePanel("Comparision across current and potential energy production"),
  sidebarLayout(
    radioButtons(
      "radio_energy",
      "Radio energy",
      c("Current", "Potential")
      ),
    hr()
    
  ),
  mainPanel(
    # Show a plot of the generated distribution
    plotOutput("my_id")
  )
)
page_five <- tabPanel(
  "Conclusion",# label for the tab in the navbar
  h2("Concluding Thoughts:"),
  sidebarPanel("Our Team:",
               br(),
               br(),
"Jenna: Environmental studies major from Spokane, WA",
                br(),
br(),
               "Vicky: Informatics major from Yunnan, China",
br(),
br(),
               "Madeline: Linguisticsfrom major from Kalamazoo, MI",
               br(),
br(),
               "Daniel: Design major from Mercer Island, WA"
               ),
  mainPanel(
p("With large scale projects, comes difficulty organizing everyone’s information (especially in our GitHub repo).
Thus, our group struggles slightly with organizing our code and making sure everything worked well together. 
But we worked through this challenge as a team. Subsequently, our collaborative skills recall shown through as we 
crossed the finish line together. 
 Overall, we learned that even with our minimal knowledge we can make an impact on real world problems via critically 
thinking and teamwork. Environmental issues are one the forefront of our world concerns, thus it is important to approach
these issues and be able to think of a solution to a problem. There is so much room for improvement when it comes to our 
energy production and our analysis showed that. Though it is contrastive to recognize our progress, there is always room for
improvement. Lawmakers should realize where those improvements are best implemented. 
As a group, we learned that we are capable of teamwork and critical thinking. We are confident moving forward with other 
personal or academic related projects."))
 
)
page_six <- tabPanel(
  "About the tech",
  h2("About the Tech:"),
  p("The major components of our shiny application are the Introduction, Current energy data, potential energy data, comparison, the tech, and conclusion. 
The introduction functions to introduce the user to the problem situation at hand. 
It contains a fair amount of verbal information as well as a non-interactive data visualization to reveal the effects of non-renewable energy on carbon dioxide emissions,
and hence climate change. The current energy data tab contains an interactive map created through leaflet 
that shows the total current renewable energy production by state as you zoom in. 
The potential energy data has a drop down to allow you to select the state and then displays a bar graph comparing geothermal, 
onshore wind, and hydropower. The comparison portionp provides the user with the option to choose between the 
current energy production and potential energy production via radio buttons. The user is then prompted with
the current production of geothermal, wind, and hydroelectric energy based on their selection of potential
or current. This page outlines the information provided throughout this report and why we chose the visualization methods 
we did. Lastly, the conclusion houses our analysis of the project as well as an about the team. 
In order to complete all of this, we loaded our data in comma separated values files, and utilized the following packages: tidyr, ggplot2, plotly, htmltools, leaflet, and dplyr. Unfortunately,
we did not have a well-thought-out organizational system for our directories and files, so they’re all simply in our github.
We also did not answer any questions using machine learning or statistically analysis. For more information, please reference our
technical report:"),
uiOutput("url")
)



# Pass each page to a multi-page layout (`navbarPage`)
ui <- navbarPage(
  theme = shinytheme("superhero"),
  "Green with Envy", # application title
  page_one,         # include the first page content
  page_two,         # include the second page content
  page_three,
  page_four,
  page_five,
  page_six
)


