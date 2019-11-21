#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
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
potential_data <- read.csv("united-states-renewable-energy-technical-potential-1.csv", 
                           header = TRUE,
                           stringsAsFactors = FALSE)
annual_generation <- read.csv("annual_generation_state.csv",
                              header = TRUE,
                              stringsAsFactors = FALSE)

annual_generation$generation <- as.numeric(gsub(",", "", annual_generation$GENERATION..Megawatthours.))


# Define server logic required to draw a histogram
server <- function(input, output) {
  #comparsion 
  output$my_id <- renderPlot({
    all_current <- annual_generation %>%
      filter(YEAR == "2018" &
               ENERGY.SOURCE %in% c("Wind", "Hydroelectric Conventional", "Solar Thermal and Photovoltaic") )
    
    all_potential <- potential_data %>%
      select(onshoreWind_GWh, hydropower_GWh, EGSGeothermal_GWh)
    
    #rename the column
    setnames(all_potential, old=c("onshoreWind_GWh","hydropower_GWh", "EGSGeothermal_GWh"),
             new=c("Wind", "Hydroelectric Conventional", "Solar Thermal and Photovoltaic"))
    
    #sum potential across three energy resources
    sum_potential <- all_potential %>%
      summarize(sum_wind = sum(Wind, na.rm = TRUE),
                sum_hydro = sum(`Hydroelectric Conventional`, na.rm = TRUE),
                sum_solar = sum(`Solar Thermal and Photovoltaic`, na.rm = TRUE)) %>%
      select(sum_wind, sum_hydro, sum_solar)
    rownames(sum_potential)[rownames(sum_potential) == "1"] = "generation"
    
    #sum current across three energy resources
    sum_current <- all_current %>%
      filter(ENERGY.SOURCE == "Wind" | ENERGY.SOURCE == "Hydroelectric Conventional" |
               ENERGY.SOURCE == "Solar Thermal and Photovoltaic") %>% 
      group_by(ENERGY.SOURCE) %>% 
      summarise(sum = sum(generation, na.rm = TRUE))
    
    ggplot(sum_current) +
      geom_col(
        mapping = aes(x = ENERGY.SOURCE, y = sum)
      )
  })
  
  #potential
  energy_sources <- potential_data %>% 
    select(X, hydropower_GWh, EGSGeothermal_GW, onshoreWind_GWh)
  
  
  energy_sources_df <- energy_sources %>%   
    gather(key = "type",
           value = "Gwh",
           hydropower_GWh, EGSGeothermal_GW, onshoreWind_GWh)
  write.csv(energy_sources_df, "energy_sources_df.csv")  
  output$energyPlot <- renderPlot({
    data <- energy_sources_df %>% filter(X == input$state)
    
    data %>% 
      ggplot(aes(x = type,
                 y = Gwh)) + geom_col()  + ggtitle("Energy Prodction by State") 
    
  })
}


