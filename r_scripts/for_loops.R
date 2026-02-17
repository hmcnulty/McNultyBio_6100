# basic coding with for loops
# february 10th, 2026
# Hannah Grace McNulty


# creating a basic for loop:

for (i in 1:5) { #declared a loop of 1-5
  cat("stuck in a loop", "\n") # the "\n" moves it to the next line in the console
  cat(3 + 2, "\n")
  cat(runif(1), "\n")
}

my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")

for (i in 1:length(my_dogs)){
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}


my_bad_dogs <- NULL 
for (i in 1:length(my_bad_dogs)){
    cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")

}

for (i in seq_along(my_dogs)){
    cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")

}


# Tip #1
# ____________
# Dont do things in a loop that you do not need to:
for (i in seq_along(my_dogs)){
  my_dogs[i] <- toupper(my_dogs[i])  #toupper = converts to uppercase
}
#^^^^^^^^^^^^^ this works but you could also just do 
toupper(my_dogs)
#or 
tolower(my_dogs)

# Tip #2
# ____________
# dont change dimensions in the loop
my_dat <- runif(1) #start with a single value

for (i in 2:10){ #define how many runs
  temp <- runif(1) #create a random number
  my_dat <- c(my_dat, temp) #put the two variables together
  #cat("loop numer =", i, my_dat[i], "\n") #im not sure what this is doing?
  print(my_dat)
}

# Tip #3
# ____________
# Dont write a loop if you can vectorize it
my_dat <- 1:10
for (i in seq_along(my_dat)){
  my_dat[i] <- my_dat[i] + my_dat[i]^2
  cat("loop numer =", i,"vector element =", my_dat[i], "\n")
}
#^^^^^^^^^^^^ above is the exact same thing as below
z <- 1:10
z <- z + z^2
# DO THIS

# Tip #4
# ____________
# remember the difference between i and z[i]
z <- c(10, 2, 4)
for (i in seq_along(z)){
  cat("i =", i, "z[i] =", z[i], "\n")
}

# Tip #5
# ____________
# dont have to loop through everything
z <- 1:20
for (i in seq_along(z)){
  if(i %% 2 ==0) next #next is a control # this is saying i\2, if its 0 move to the next = basically removing all even numbers
  print(i)
}



##########################################
# Look at the parameter space of the logistic growth model with a for loop


my_function <- function(N0 = 10, r = 0.3, K = 100, tf = 100, ts = 1){
  # FUNCTION: my_function
  # PURPOSE: Run a logistic growth model and return a dataframe with columns for population size and time.
  # INPUTS: No: initial population size, r: growth rate, K: carrying capacity, tfinal: end time, ts: time step 
  # OUTPUTS: dataframe of Population size over Time

  t <- seq(from = 1, to = tf, by = ts) #from year 1-100, by 1 = as defined in the function header

  e <- 2.7182 #constant doesn't change, find the name

  n <-  K/(1+((K-N0)/N0)*e^(-r*t)) #equation to find n

  df <- data.frame(t, n) #combine variables n and t into a data frame

  return(df)

}

r_vec <- seq(0,1, by = .01) #vector of little r's :values we want

container_vec <- rep(NA, length(r_vec)) #storage for max(n) :container, filled full of NAs based on the length of the first vector

for (i in seq_along(r_vec)){
  temp_df <- my_function(r = r_vec[i])
  max_n <- max(temp_df$n)
  #print(max_n) if you wanna just look at rhe max value for checking
  container_vec[i] <- max_n #storage us happening here!
}

growth_df <- data.frame(r = r_vec, N = container_vec)
head(growth_df)

plot(x = growth_df$r, y = growth_df$N)

#####################################################
# 2D parameter sweep for log growth function
# outputs matrix

# vectors for r and K  parameters
r_values <- seq(0,1, length_out = 100)
K_values <- seq(10,1000, length.out = 100)



growth_sweep <- function(rvec, kvec){
  #storage function
  stor_mat <- matrix(NA, nrow = length(rvec), ncol = length(kvec))

  for (i in seq_along(rvec)){ #rows
    for (j in seq_along(kvec)){ #cols

      #run long growth
      tmp_df <- my_function(r = rvec[i], K = kvec[j])

      #store max n in 2d matrix
      stor_mat[i,j] <- max(tmp_df$population)
    }
  }
  return(stor_mat)
}


# run growth param sweep
growth_mat <- growth_sweep(rvec = r_values, kvec = K_values)


#####################################################
# 2D parameter sweep for log growth function
# outputs a data frame

# vectors for r and K  parameters
r_values <- seq(0,1, length_out = 100)
K_values <- seq(10,1000, length.out = 100)



growth_sweep <- function(rvec, kvec){
  #row indexing variable
  counter <- 1
  
  #create storage dataframe
  dflength <- length(rvec)* length(kvec) #how long is the df
  r_out <- rep(NA, dflength)
  k_out <- rep(NA, dflength)
  maxn_out <- rep(NA, dflength)

  # turn vecs to df
  storage_df <- data.frame(r_out, k_out, maxn_out)

  # enther out loops
  for (i in seq_along(rvec)){ #rows
    for (j in seq_along(kvec)){ #cols

      #run long growth
      tmp_df <- my_function(r = rvec[i], K = kvec[j])

      #store max n in dataframe
        storage_df$maxn_out[counter] <- max(tmp_df$population)
        storage_df$r_out[counter] <- rvec[i] # value for r stored
        storage_df$k_out[counter] <- kvec[j] # value for k stores
      counter <- counter+1 # increase counter
    }
  }
  return(storage_df)
}

# run growth param sweep
df <- growth_sweep(rvec = r_values, kvec = K_values)
head(df)




# create a random walk function

############################################
# NAME: ran_walk
# purpose: conduct a random walk
# input: times = number of timesteps
#        n1 = inital pop size
#        lamda = finite rate of increase
#        noise_sd = 10
# output: vector n with population size > 0 until extinction
#
library(ggplot2)

ran_walk <- function(times = 100, n1 = 50, lamda = 1, noise_sd = 10){
  n <- rep(NA, times) # create out output vec : storage container!!
  n[1] <- n1 # initalize init pop size
  noise <- rnorm(n = 100, mean = 0, sd = noise_sd) # created noise/error

  for (i in 1:times-1){ # have to do times-1 b/c we gave it a starting value
      n[i + 1] <- lamda*n[i] + noise[i] # we already have something in i so we have to give it i+1 to go to the second place
      if(n[i +1] <= 0){
        n[i+1] <- NA
        cat("Population Extinction at Time", i+1, "\n")
        break
      }
  }

  return(n) # after the loop but before the function closes

}


ran_walk1 <- function(times=100,n1=50,lamda=1.00,noise_sd=10) {
                n <- rep(NA,times)  # create output vector
                n[1] <- n1 # initialize with starting population size
                noise <- rnorm(n=times,mean=0,sd=noise_sd) # create noise vector
                for(i in 1:(times-1)) {
                  n[i + 1] <- lamda*n[i] + noise[i]
                  if(n[i + 1] <=0) {
                    n[i + 1] <- NA
                    cat("Population extinction at time",i+1,"\n")
                    break}
                }

return(n)
}


x <- ran_walk1()
x

#plotting with default values
qplot(x=1:100, y=ran_walk1(), geom= "line")

#no noise/not so random walk
qplot(x=1:100, y=ran_walk1(noise_sd = 0), geom= "line")

# no noise and adjust lamda
qplot(x=1:100, y=ran_walk1(lamda = 0.92, noise_sd = 0), geom= "line")

# add some stoch back make lamda >1
qplot(x=1:100, y=ran_walk1(lamda = 1.01, noise_sd = 6), geom= "line")

