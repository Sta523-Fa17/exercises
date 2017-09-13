library(dplyr)
library(nycflights13)

flights = flights %>% tbl_df()

# Demo 1 - 

flights %>%
  filter(dest == "LAX") %>%                        # How many flights to Los Angeles (LAX) 
  filter(carrier %in% c("AA","UA","DL","US")) %>%  # did each of the legacy carriers (AA, UA, DL or US)
  mutate(carrier = as.factor(carrier)) %>%
  group_by(carrier) %>%
  filter(month == 5) %>%                           # have in May
  filter(origin == "JFK") %>%                      # from JFK, and 
  filter(!is.na(air_time)) %>%
  summarize(n = n(), avg_dur = mean(air_time))              # what was their average duration?

