
# Constants
nsim = 1e6
x = 5
n = 10


prior = rbeta(nsim, 3, 7)
sim_data = rbinom(nsim, size = n, prob = prior)
post = prior[sim_data == x]

plot(density(post))

p = seq(0,1,length.out = 100)
d = dbeta(p, shape1 = 3+x, shape2 = 7+n-x)
lines(x=p, y=d, col="blue")
