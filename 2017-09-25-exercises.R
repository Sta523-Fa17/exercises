library(ggplot2)

movies = read.csv("http://www.stat.duke.edu/~cr173/Sta523_Fa17/data/movies/movies.csv", 
                  stringsAsFactors = FALSE) %>% tbl_df()


## Exercise #1

ggplot(movies, aes( x = imdb_num_votes, y = imdb_rating, color = audience_rating)) +
  geom_point(alpha=0.2) +
  facet_wrap(~mpaa_rating) +
  labs(x = "IMDB number of votes", y = "IMDB rating", color="Audience rating", title = "IMDB scores by MPAA rating") +
  theme_bw()


## Exercise #2



ggplot(movies, aes(x=audience_score, y=critics_score)) +
  geom_abline(slope = 1, intercept = 0, color="grey", size=0.5, alpha=0.5) +
  geom_point(aes(color=best_pic_nom), alpha=0.2) +
  facet_wrap(~mpaa_rating) +
  geom_smooth(method="lm", se = FALSE, fullrange=TRUE, color="black", size=0.5) +
  theme_bw()

