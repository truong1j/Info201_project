
potential_data <- read.csv("dataset/united-states-renewable-energy-technical-potential-1.csv",
                           
                           stringsAsFactors = FALSE, header = TRUE)


annual_generation <- read.csv("dataset/annual_generation_state.csv",
                              header = TRUE,
                              stringsAsFactors = FALSE)

annual_generation$generation <- as.numeric(gsub(",", "", annual_generation$GENERATION..Megawatthours.))

library(shiny)
library(dplyr)
library(ggplot2)
library(data.table)
library(tidyr)
#summary information 
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



#plot for current
  ggplot(sum_current) +
  geom_col(
    mapping = aes(x = ENERGY.SOURCE, y = sum))



# reshape the data potential
sumup_potential <- sum_potential %>%
  spread(
    sum_potential,
    type,
    generation
  )
#plot for potential
  ggplot(sum_potential) +
  geom_col(
    mapping = aes(x = c(sum_wind, sum_hydro, sum_solar), y = generation)
  )

