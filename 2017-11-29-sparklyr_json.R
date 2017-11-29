library(sparklyr)
library(dbplyr)
library(dplyr)
library(stringr)

sc = spark_connect(master="local[8]", spark_home="/data/spark/spark-2.2.0-bin-hadoop2.7/")

