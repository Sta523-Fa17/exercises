# Exercise 1 - Nested for loops, no %in%

primes = c( 2,  3,  5,  7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 
           43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97)
x = c(3, 4, 12, 19, 23, 48, 50, 61, 63, 78)

for(prime_cand in x) {
  
  found_match = FALSE
  for(prime in primes) {
    if (prime_cand == prime)
    {
      found_match = TRUE
      break
    }
  }
  
  if (!found_match)
    print(prime_cand)
}

for(prime_cand in x) {
  if(!prime_cand %in% primes)
    print(prime_cand)
}

x[ !(x %in% primes) ]



