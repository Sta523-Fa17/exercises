library(purrr)
library(dplyr)
library(tibble)
library(repurrrsive)
library(stringr)

data(sw_people)


d = data_frame(
  name = map_chr(sw_people, "name"),
  height = map_chr(sw_people, "height"),
  mass = map_chr(sw_people, "mass")
) %>% 
  mutate(
    height = str_replace(height,",","") %>% as.double(height),
    mass   = str_replace(mass,",","") %>% as.double(mass)
  )


films = map(sw_people, "films") %>% 
  unlist() %>%
  unique() %>%
  sort() %>% 
  set_names(., paste0("film_", 1:length(.)))

# Bad - Hardcoded
d2 = d %>%
  mutate(
    film_1 = map(sw_people, "films") %>% map_lgl(function(x) films[1] %in% x),
    film_2 = map(sw_people, "films") %>% map_lgl(function(x) films[2] %in% x),
    film_3 = map(sw_people, "films") %>% map_lgl(function(x) films[3] %in% x),
    film_4 = map(sw_people, "films") %>% map_lgl(function(x) films[4] %in% x),
    film_5 = map(sw_people, "films") %>% map_lgl(function(x) films[5] %in% x),
    film_6 = map(sw_people, "films") %>% map_lgl(function(x) films[6] %in% x),
    film_7 = map(sw_people, "films") %>% map_lgl(function(x) films[7] %in% x)
  )


# Better (wide) - automatic

d3 = bind_cols(
  d,
  map_df(
    films, 
    function(film)
    {
      map(sw_people, "films") %>% 
        map_lgl(function(x) film %in% x)  
    }
  )
)
  



# Better (long)

d4 = d %>%
  slice(rep(1:n(), map(sw_people, "films") %>% map_int(length))) %>%
  mutate(film = map(sw_people, "films") %>% unlist())




# Best - list columns

d5 = d %>%
  mutate(film = map(sw_people, "films"))

d6 = data.frame(
  d,
  film = 1
)
d6$film = map(sw_people, "films")
d6


d7 = data_frame(
  film = map(sw_people, "films")
)




### A more general approach

map_df(
  sw_people[1:3], 
  function(row)
  {
    map_if(row, function(x) length(x) > 1, list)
  }
) %>% View() 


list_cols = map(sw_people, ~ map_int(., length) )  %>% 
  map(~ which(. > 1)) %>% 
  unlist() %>% 
  names() %>% 
  unique()

map_df(
  sw_people, 
  function(row)
  {
    map_at(row, list_cols, list)
  }
) %>% View() 



