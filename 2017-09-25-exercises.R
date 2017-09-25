library(ggplot2)

movies = read.csv("http://www.stat.duke.edu/~cr173/Sta523_Fa17/data/movies/movies.csv", 
                  stringsAsFactors = FALSE) %>% tbl_df()

ggplot(
  movies, 
  aes(
    x = imdb_num_votes,
    y = imdb_rating,
    color = audience_rating
  )
) +
  geom_point(alpha=0.2) +
  facet_wrap(~mpaa_rating) +
  labs(x = "IMDB number of votes", y = "IMDB rating", color="Audience rating", title = "IMDB scores by MPAA rating")
