library(dplyr)
library(nycflights13)

flights = flights %>% tbl_df()

# Demo 1

flights %>%
  filter(dest == "LAX") %>%                        # How many flights to Los Angeles (LAX) 
  filter(carrier %in% c("AA","UA","DL","US")) %>%  # did each of the legacy carriers (AA, UA, DL or US)
  mutate(carrier = as.factor(carrier)) %>%
  group_by(carrier) %>%
  filter(month == 5) %>%                           # have in May
  filter(origin == "JFK") %>%                      # from JFK, and 
  filter(!is.na(air_time)) %>%
  summarize(n = n(), avg_dur = mean(air_time))              # what was their average duration?


# Demo 2 - Skip


# Exercise 1 - Which plane (check the tail number) flew out of each New York airport the most?

flights %>%
  filter(!is.na(tailnum)) %>%
  group_by(tailnum, origin) %>% 
  summarize(n = n()) %>%
  group_by(origin) %>%
  filter(n >= sort(n,decreasing = TRUE)[3]) %>%
  ungroup() %>%
  arrange(origin, desc(n))

# Exercise 2 - What was the shortest flight out of each airport in terms of distance? In terms of duration?
  
flights %>%
  filter(!is.na(distance)) %>%
  group_by(origin) %>%
  arrange(origin, distance) %>%
  filter(distance == distance[1]) %>%
  ungroup()

flights %>%
  filter(!is.na(air_time)) %>%
  arrange(origin, air_time) %>%
  filter(air_time == air_time[1]) %>%
  ungroup()

