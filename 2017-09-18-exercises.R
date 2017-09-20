library(magrittr)

# Example 2

primes = c(2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 
          53, 59, 61, 67, 71, 73, 79, 83, 89, 97)

x = c(3, 4, 12, 19, 23, 48, 50, 61, 63, 78)


## Subsetting

x[ !x %in% primes ]

## For loop 

res = rep(NA, length(x))
j = 1
for(x_i in x)
{
  if (!x_i %in% primes)
  {
    res[j] = x_i
    j = j+1
  }
}
res[!is.na(res)]


## l/sapply

sapply(
  x,
  function(x_i) 
  {
    if (!x_i %in% primes) x_i
    else NA
  }
) %>% .[!is.na(.)]


lapply(
  x,
  function(x_i) 
  {
    if (!x_i %in% primes) x_i
    else NULL
  }
) %>% unlist()
