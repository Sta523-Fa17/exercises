## Benchmarking

library(microbenchmark)

good = function() {
  res = rep(NA, 1e4)
  for(i in seq_along(res))
    res[i] = sqrt(i)
}
bad = function() {
  res = numeric()
  for(i in 1:1e4)
    res = c(res,sqrt(i))
  
}
best = function() {
  sqrt(1:1e4)
}

r = microbenchmark(
  bad(),
  good(),
  best(),
  times = 20
)

rbenchmark::benchmark(
  bad(),
  good(),
  best(),
  replications = 25,
  order = "relative"
)




### Data Frames

library(purrr)
library(dplyr)


set.seed(523)
d = data_frame(
  A = rnorm(1e5),
  B = runif(1e5),
  C = rexp(1e5),
  D = sample(letters, 1e5, replace=TRUE)               
)

dplyr = function() {
  d %>% summarize_all(.funs = max)
}

purrr = function() {
  map(d, max) %>% as_data_frame()
}

lapply_func = function() {
  lapply(d, max) %>% as_data_frame()
}


for_loop = function() {
  l = rep(NA, ncol(d)) %>% as.list()
  for(i in seq_along(d))
    l[[i]] = max(d[[i]])
  names(l) = names(d)
  as_data_frame(l)
}

for_loop2 = function() {
  l = rep(NA, ncol(d)) %>% as.list()
  for(i in seq_along(d))
    l[[i]] = max(d[,2])
  names(l) = names(d)
  as_data_frame(l)
}

r = microbenchmark(
  dplyr(),
  purrr(),
  lapply_func(),
  for_loop(),
  for_loop2(),
  times = 20
)

d = d[1:1000,]

r_small = microbenchmark(
  dplyr(),
  purrr(),
  lapply_func(),
  for_loop(),
  for_loop2(),
  times = 20
)


### ProfVis

x = rnorm(1e6)
y = 1+5*x + rnorm(1e6,sd = 0.2)

l = lm(y~x)



### Bootstrap

library(ggplot2)

set.seed(3212016)
d = data.frame(x = 1:120) %>%
  mutate(y = sin(2*pi*x/120) + runif(length(x),-1,1))

l = loess(y ~ x, data=d)
d = d %>% mutate(
  pred_y = predict(l),
  pred_y_se = predict(l,se=TRUE)$se.fit
) %>% mutate(
  pred_low  = pred_y - 1.96 * pred_y_se,
  pred_high = pred_y + 1.96 * pred_y_se
)


ggplot(d, aes(x,y)) +
  geom_point(color="darkgrey") +
  geom_ribbon(aes(ymin=pred_low, ymax=pred_high), fill="red", alpha=0.25) +
  geom_line(aes(y=pred_y)) +
  theme_bw()


n_rep = 5000
d_xy = select(d, x, y)

res = map(1:n_rep, function(i) {
  d_xy %>% 
    select(x,y) %>% 
    sample_n(nrow(d), replace=TRUE) %>%
    loess(y ~ x, data=.) %>%
    predict(newdata=d) %>%
    setNames(NULL)
}) %>% do.call(cbind, .)


res_par = mclapply(1:n_rep, function(i) {
  d_xy %>% 
    select(x,y) %>% 
    sample_n(nrow(d), replace=TRUE) %>%
    loess(y ~ x, data=.) %>%
    predict(newdata=d) %>%
    setNames(NULL)
}, mc.cores = 12) %>% do.call(cbind, .)


d = d %>% mutate(
  bs_low = apply(res_par,1,quantile,probs=c(0.025), na.rm=TRUE),
  bs_high  = apply(res_par,1,quantile,probs=c(0.975), na.rm=TRUE)
)

ggplot(d, aes(x,y)) +
  geom_point(color="gray50") +
  geom_ribbon(aes(ymin=pred_low, ymax=pred_high), fill="red", alpha=0.25) +
  geom_ribbon(aes(ymin=bs_low, ymax=bs_high), fill="blue", alpha=0.25) +
  geom_line(aes(y=pred_y)) +
  theme_bw()
