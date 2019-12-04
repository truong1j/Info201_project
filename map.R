
library(shiny)
library(dplyr)
library(ggplot2)
library(data.table)
library(tidyr)
library(leaflet)
library(htmltools)
library(plotly)


potential_data1 <- read.csv("united-states-renewable-energy-technical-potential-1.csv")
states <- read.csv("statelatlong.csv") 
potential_data2 <- potential_data1 %>%
  rename(
    State = X
  )
states <- states %>%
  rename(
    State = City,
    Abbrev = State
  )


GWh <- subset(potential_data2, select = c("State", "urbanUtilityScalePV_GWh", "ruralUtilityScalePV_GWh",
                                         "rooftopPV_GWh", "CSP_GWh", "onshoreWind_GWh", "offshoreWind_GWh",
                                         "biopowerSolid_GWh", "biopowerGaseous_GWh", "geothermalHydrothermal_GWh",
                                         "EGSGeothermal_GWh", "hydropower_GWh"))


GWh1 <- GWh %>%
  inner_join(states, by = "State") 

GWh1[48, 14] = 47.7511
GWh1[48, 15] = -120.7401
GWh1$total <- rowSums(GWh1[, 2:12], na.rm = TRUE)



GWh1$info <- paste0("State: ", GWh1$State, "<br/>",
                   "Total Energy Produced: ", GWh1$total, "GWh", "<br/>")

map_coloring <- colorFactor(topo.colors(3), GWh1$total)

interactive_map <- leaflet(data = GWh1) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addCircleMarkers(
    lat = GWh1$Latitude,     
    lng = GWh1$Longitude, 
    clusterOptions = markerClusterOptions(),
    stroke = FALSE,      
    color = map_coloring(GWh1$total),
    label = ~lapply(info, HTML))

interactive_map




library("dplyr")
library("tidyr")
library("ggplot2")




# put csv into dataframe
my_data <- read.csv("carbon_dioxide_emissions_headers.csv")
df <- data.frame(my_data)
colnames(df) <- c("Year", "Coal", "Natural Gas", "Aviation Gasoline",    "Distillate Fuel Oil",
                  "Hydrocarbon Gas Liquids",    "Jet Fuel",    "Kerosene",    "Lubricants",
                  "Motor Gasoline",    "Petroleum Coke",    "Residual Fuel Oil",
                  "Other Petroleum Products",    "Petroleum",    "Total Energy CO2 Emissions")



# gather to make into a usable dataframe for geom_area
emission_df <- df %>% 
  gather("Coal", "Natural Gas", "Aviation Gasoline", "Distillate Fuel Oil", 
         "Hydrocarbon Gas Liquids", "Jet Fuel", "Kerosene", "Lubricants", "Motor Gasoline", 
         "Petroleum Coke", "Residual Fuel Oil", "Other Petroleum Products", "Petroleum", 
         key = "energy_source", value = "co2_emissions")




# get rid of total column
emissions_df <- emission_df[-2]

