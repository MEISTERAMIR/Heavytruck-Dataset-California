install.packages("zipcodeR")
library(zipcodeR)
cali <- read_csv("~/Desktop/cali.csv")
View(cali)
library(usmap)
library(dplyr)
library(ggplot2)
install.packages("tidyverse")
require(tidyverse)
library(usmapdata)
california <- cali %>% 
  select("Zip Code", "Fuel", "Duty", "Vehicles", ) %>%
  filter(Fuel == "Battery Electric")
view(california)
allelectrictrucks <- california %>% group_by(`Zip Code`) %>%
  summarise(sum_vehicles=sum(Vehicles))
view(allelectrictrucks)
heavyelectrictrucks <- cali %>% 
  select("Zip Code", "Fuel", "Duty", "Vehicles", ) %>%
  filter(Fuel == "Battery Electric", Duty =="Heavy")            
sumheavyelectrictrucks <- heavyelectrictrucks %>% group_by(`Zip Code`) %>%
  summarise(sum_vehicles=sum(Vehicles))
view(sumheavyelectrictrucks)


counties <- reverse_zipcode(sumheavyelectrictrucks$`Zip Code`)
view(counties)
counties$EV <- sumheavyelectrictrucks$sum_vehicles
counties %>%
  select(zipcode,county,state,EV)
HEAVYTRUCKS <- counties %>% group_by(county) %>%
  summarise(sum_EV=sum(EV)) %>%
  na.omit()
view(HEAVYTRUCKS)

