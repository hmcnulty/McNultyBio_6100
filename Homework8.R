# Script for Homework #8
# 03/04/2026
# Hannah Grace McNulty

#######################################################



# Question 1
# Using a for loop, write a function to calculate the number of zeroes in a numeric vector. 
# Before entering the loop, set up a counter variable counter <- 0. 
# Inside the loop, add 1 to counter each time you have a zero in the vector. 
# Finally, use return(counter) for the output.

counter <- 0

num_0 <- function(n = 1000){
  
  rb <- rbinom(n, 1 , 0.5)

  for (i in 1:n){
   if(rb[i] == 0){
        counter <- counter + 1 # increase counter
      }
  }
  return(counter)
}

num_0()




# Question 2
# Use subsetting instead of a loop to rewrite the function as a single line of code.

library(dplyr)

rb <- rbinom(1000, 1 , 0.5) 
id <- 1:1000
df <- data.frame(rb, id)

nrow <- nrow(filter(df, rb == 0))

nrow



# Question 3
# Write a function that takes as input two integers representing the number of rows and columns in a matrix. 
# The output is a matrix of these dimensions in which each element is the product of the row number x the column number.


create_matrix <- function(r=5, c=5){

  stor_mat <- matrix(, nrow = r, ncol = c)

  for (i in 1:r){
    for (j in 1:c){

       stor_mat[i,j] <- i*j
    
    }
  }
  return(stor_mat)
}

create_matrix()


# Question 4
# In the next few lectures, you will learn how to do a randomization test on your data. 
# We will complete some of the steps today to practice calling custom functions within a for loop. 
# Use the code from the March 31st lecture (Randomization Tests) to complete the following steps:

# A
# Simulate a dataset with 3 groups of data, each group drawn from a distribution with a different mean. 
# The final data frame should have 1 column for group and 1 column for the response variable.

library(ggplot2)
set.seed(27)


trt_group <- c(rep("Hannah",5), rep("Bryan",6), rep("Jackson",4)) # define groups

z <- c(runif(4) + 1, runif(5) + 10, runif(6)+ 27) # define responses

df <- data.frame(trt=trt_group,res=z) # make a dataframe

obs <- tapply(df$res,df$trt,mean)
obs


# create a simulated data set
df_sim <- df # set up a new data frame

rando <- df_sim$res <- sample(df_sim$res) # randomize assignment of response to treatment groups
print(rando)


# B
# Write a custom function that 1) reshuffles the response variable, and 2) calculates the mean of each group in the reshuffled data. 
# Store the means in a vector of length 3.


shuffle_data <- function(df_sim) {

  df_sim$res <- sample(df_sim$res)

  means <- tapply(df_sim$res, df_sim$trt, mean)

  return(means)
}


df2 <- shuffle_data(df_sim)
df2






# C
# Use a for loop to repeat the function in b 100 times. 
# Store the results in a data frame that has 1 column indicating 
# the replicate number and 1 column for each new group mean, for a total of 4 columns.

n_reps   <- 100
results  <- data.frame(replicate = 1:n_reps, Bryan     = NA_real_, Hannah    = NA_real_, Jackson   = NA_real_)

for (i in 1:n_reps) {
  means          <- shuffle_data(df_sim)   
  results$Bryan[i]   <- means["Bryan"]
  results$Hannah[i]  <- means["Hannah"]
  results$Jackson[i] <- means["Jackson"]
}

head(results)



# D
# Use qplot() to create a histogram of the means for each reshuffled group. 
# Or, if you want a challenge, use ggplot() to overlay all 3 histograms in the same figure. 
# How do the distributions of reshuffled means compare to the original means?


hannah <- ggplot(results, aes(x = Hannah)) +
  geom_histogram(bins = 20) +
  labs(
    x = "Mean",
    y = "Count",
    title = "Hannah means"
  )

hannah




bryan <- ggplot(results, aes(x = Bryan)) +
  geom_histogram(bins = 20) +
  labs(
    x = "Mean",
    y = "Count",
    title = "Bryan means"
  )

bryan



jackson <- ggplot(results, aes(x = Jackson)) +
  geom_histogram(bins = 20) +
  labs(
    x = "Mean",
    y = "Count",
    title = "Jackson means"
  )

jackson








