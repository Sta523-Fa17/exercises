# Exercise 1

(d = data.frame(
  Patient     = 1:16,
  Gender      = rep(c("Male","Female"), c(8,8)),     #c(rep("Male",8), rep("Female",8)),
  Treatment_1 = rep(rep(c("Yes","No"), c(4,4)), 2),
  Treatment_2 = rep(c("Yes","No"), c(2,2)),
  Treatment_3 = c("Yes","No"),
  stringsAsFactors = FALSE
))

# Exercise 2

x = c(56, 3, 17, 2, 4, 9, 6, 5, 19, 5, 2, 3, 5, 0, 13, 12, 6, 31, 10, 21, 8, 4, 1, 1, 2, 5, 16, 1, 3, 8, 1,
      3, 4, 8, 5, 2, 8, 6, 18, 40, 10, 20, 1, 27, 2, 11, 14, 5, 7, 0, 3, 0, 7, 0, 8, 10, 10, 12, 8, 82,
      21, 3, 34, 55, 18, 2, 9, 29, 1, 4, 7, 14, 7, 1, 2, 7, 4, 74, 5, 0, 3, 13, 2, 8, 1, 6, 13, 7, 1, 10,
      5, 2, 4, 4, 14, 15, 4, 17, 1, 9)

  
# Select every third value starting at position 2 in x.

x[seq(2, length(x), by=3)]


# Remove all values with an odd index (e.g. 1, 3, etc.)

x[seq_along(x) %% 2 == 0]
x[!(seq_along(x) %% 2 == 1)]
x[seq(2,length(x), by=2)]
x[-seq(1,length(x), by=2)]

# Select only the values that are primes. (You may assume all values are less than 100)

primes = c(2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97)

x[x %in% primes]

# Remove every 4th value, but only if it is odd.

## Find fourth values (with logical vector)
seq_along(x) %% 4 == 0


## Find odd values
x %% 2 == 1

## Putting it together
x[ !( (seq_along(x) %% 4 == 0) & (x %% 2 == 1) ) ]
x[ !( (c(FALSE, FALSE, FALSE, TRUE)) & (x %% 2 == 1) ) ]
