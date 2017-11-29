library(sparklyr)
library(dbplyr)
library(dplyr)
library(stringr)


#spark_available_versions()
#spark_install(version = "2.2.0", hadoop_version = "2.7")

sc = spark_connect(master="local[8]", spark_home="/data/spark/spark-2.2.0-bin-hadoop2.7/")

#system.time({spark_read_csv(sc, "green", "/data/nyc-taxi-data/nyc_taxi_2017/green_tripdata_2017-01.csv")})
#system.time({readr::read_csv("/data/nyc-taxi-data/nyc_taxi_2017/green_tripdata_2017-01.csv")})

green = spark_read_csv(sc, "green", "/data/nyc-taxi-data/nyc_taxi_2017/green_tripdata_2017-*.csv")
yellow = spark_read_csv(sc, "yellow", "/data/nyc-taxi-data/nyc_taxi_2017/yellow_tripdata_2017-*.csv")

fix_names = function(d) {
  setNames(
    d, 
    tolower(colnames(d)) %>%
      str_replace("[lt]pep_", "")
  )
}

green = fix_names(green)
yellow = fix_names(yellow)



#green %>% mutate(total = fare_amount+tip_amount) %>% select(fare_amount, tip_amount, total)
#green %>% filter(pulocationid == 42)

#green %>% mutate(total = paste(fare_amount,tip_amount,sep="+")) %>% select(fare_amount, tip_amount, total) %>% sql_render()
#green %>% mutate(total = paste0(fare_amount,tip_amount,sep="+")) %>% select(fare_amount, tip_amount, total) %>% sql_render()

wday_hourly_summary = function(df, label="") {
  df %>%
    mutate(
      hour = hour(pickup_datetime),
      wday = date_format(pickup_datetime, "EEE"),
      trip_time = (unix_timestamp(dropoff_datetime) - unix_timestamp(pickup_datetime)) / 60
    ) %>%
    select(hour, wday, trip_time, trip_distance, fare_amount, tip_amount) %>%
    group_by(hour, wday) %>%
    summarize(
      avg_dist = mean(trip_distance),
      avg_time = mean(trip_time),
      avg_fare = mean(fare_amount),
      avg_tip_perc = mean(tip_amount / fare_amount)
    ) %>%
    mutate(taxi = label)
}

green_data = wday_hourly_summary(green, "green") %>% collect()
yellow_data = wday_hourly_summary(yellow, "yellow") %>% collect()

library(ggplot2)
library(tidyr)

data = bind_rows(green_data, yellow_data) %>%
  mutate(wday = factor(wday, levels = c("Mon","Tue","Wed","Thu","Fri","Sat","Sun"))) %>%
  gather(key = type, value=value, avg_dist:avg_tip_perc)




ggplot(data, aes(x=hour, y=value, color=taxi)) +
  geom_line() +
  scale_color_manual(values=c("green","yellow")) +
  theme_bw() +
  facet_grid(type~wday,scales="free") + 
  ylab("")


