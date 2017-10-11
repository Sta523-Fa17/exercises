library(rvest)
library(magrittr)
library(tibble)
library(stringr)

site_url = "https://www.rottentomatoes.com"
page = read_html(site_url)

data_frame(
  title = page %>% html_nodes("#Top-Box-Office .middle_col a") %>% html_text(),
  url = page %>% html_nodes("#Top-Box-Office .middle_col a") %>% html_attr("href") %>% paste0(site_url, .),
  box_office = page %>% html_nodes("#Top-Box-Office .right a") %>% html_text() %>% 
    str_replace("\\s+", "") %>%
    str_replace("^\\$", "") %>%
    str_replace("M$", "") %>%
    as.numeric(),
  tomato_meter = page %>% html_nodes("#Top-Box-Office .tMeterScore") %>% html_text() %>% 
    str_replace("%$","") %>%
    {as.numeric(.)/100},
  icon = page %>% html_nodes("#Top-Box-Office .tiny") %>% html_attr("class") %>%
    str_replace_all("icon |tiny ", "")
)


page %>% html_nodes("table.movie_list#Top-Box-Office") %>% html_table() %>% {.[[1]]}


