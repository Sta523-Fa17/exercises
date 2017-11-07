library(dplyr)
library(readr)
library(stringr)
library(lubridate)

nyc_raw = read_csv("/data/nyc_parking/NYParkingViolations.csv") 

nyc = nyc_raw %>%
  setNames(str_replace_all(names(.)," ", "_")) %>%
  select(Registration_State:Issuing_Agency, 
         Violation_Location, Violation_Precinct, Violation_Time,
         House_Number:Intersecting_Street, Vehicle_Color) %>%
  mutate(Issue_Date = mdy(Issue_Date)) %>% 
  mutate(Issue_Day = day(Issue_Date),
         Issue_Month = month(Issue_Date),
         Issue_Year = year(Issue_Date),
         Issue_WDay = wday(Issue_Date, label=TRUE)) %>%
  filter(Issue_Year %in% 2013:2014)
