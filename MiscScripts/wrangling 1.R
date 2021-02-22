list.files()
library(readr)
library(tidyverse)
AverageMaxTemp <-read_csv("AverageMaximumTemp.csv")
View(AverageMaxTemp)
Locations <-  read_csv("AustralianWeatherStations.csv")
View(Locations)
AverageMax_loc <- cbind(Locations,AverageMaxTemp)
View(AverageMax_loc)
AverageMax_loc <- AverageMax_loc %>%
  rename(ChangedNameAgain = 1,lati = 3) %>%
  select(-c(lat,lon))
AverageMax_loc <-AverageMax_loc %>%
  rename(lat = lati) %>%
  select(-c(X1,ChangedNameAgain,stnnum))
AverageMax_loc_long <-  AverageMax_loc %>%
  pivot_longer(cols = starts_with("V"),names_to = "Year",values_to= "Temp",names_prefix = "wk",values_drop_na = TRUE)
AverageMax_loc_long <- AverageMax_loc_long %>%
  mutate(Year = as.numeric(substring(Year, 2))+1974)
AverageMax_loc_long <- AverageMax_loc_long %>%
  mutate(Year = as.Date(Year))
autoplot(AverageMax_loc_long)
AverageMax_loc_long %>% select(name,Year) %>%
  autoplot(name)
write_csv(AverageMax_loc_long,"AustralianAverageMaxTemp.csv")
