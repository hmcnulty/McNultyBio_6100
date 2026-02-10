# This is a document of user defined functions in R
# February 5th 2026
# Hannah Grace McNulty


#-----------------------------------------------------
# START OF SCRIPT


# two types of programming 
# 
# 
# 1. functional programming
# something in -> somthing out -> to the next
# can seperate into steps

# 2. OOP (object-oriented programming)
# not as commen in r
# atributes can do things to themselves
# ex. run a model on the data it puts in


#############
# Anatomy of a Function

# a function called function(inside i get to make up my own arguments)
# a function has a local environment so you need local variables, i.e. need to be inside the function
# example function(x,y)
# then name the function myfunction <- function(x=1, y=2) ((1 and 2 are the default parameters))
# then after you open the body of the function with {}
# myfunction <- function(x=1, y=2){
# out <- x+y
# out1 <- y/x
# w <- list(out, out1)               #trick into outputting both
# return(w)                          # or just the name out if we only want one
# }
# to actually run the function, you have to call the funciton by its name
# ex. z <- myfunction(x=w, y=3)      #add in your parameters and run



# functions that exist in r

sum(3, 2) #two parameters
3 + 2
`+`(3,2) 

y <- 3 #assignment opperator
`<-`(yy,5)

print(read.table) #can print a function to see the source code, see all the parameters


# Creating a little function

# START of function called adder_subtractor
###########################################################################
adder_subtractor <- function(x = 1, y = 2, z = TRUE){
    # Name: adder_subtractor
    # Operation: It does some random math depending on the value of z.
    # Inputs: (3 inputs): 
      # x (numeric scaler value, default = 1): one of the numbers to be operated on
      # y (numeric scaler value, default = 2): one of the numbers to be operated on
      # z (logical, default = TRUE): a switch to decide on subtracting or addingt
    # Outputs: numeric value resulting from addition or subtraction
    if(z == TRUE){
        out <- x + y
      }else{
         out <- x - y
      }
  
    return(out)
}
###########################################################################
# END of function

adder_subtractor() #calling a function, but not defined so using default values

adder_subtractor(x=7, y=4) #calling a function, defined values

adder_subtractor(x=7, y=4, z = TRUE) # = 11

adder_subtractor(x=7, y=4, z = FALSE) # = 3


# START Hardy Weinberg Function
###########################################################################
hardy_w <- function(p = runif(1)){
    # Function: hardy_w
    # Operation: does a Hardy Weinberg equilibrium problem
    # Input: p = allele frequency of the dominant allele
    # Output: q (recessive) = the frequencies of the three genotypes (fAA, fAB, fBB)

    #q <- 1 - p #defined q
    #print(c(q,p)) #   OR    print(sum(c(q,p))) should get 1 in this case
  
    q <- 1 - p
    fAA <- p^2 #gene frequencies
    fAB <- 2*p*q
    fBB <- q^2
  
    #store data for output
    out_vec <- signif(c(q = q, p = p, AA = fAA, BB = fBB, AB = fAB), digits = 3) # signif defines how many significan digits

    return(out_vec) # return values
}
###########################################################################
# END Hardy Weinberg Function

hardy_w(p = .2)




# global vs local parameters

my_func <- function(a = 3, b = 4){

z <- a + b
return(z)
}
my_func()


my_bad_function <- function(a = 3){
  b <- 8 #hard coded variable, will remain the same everytime
  z <- a + b
  return(z)
}
my_bad_function()

# passing global variables properly
a <- 32
b <- 4

my_func_2 <- function(first, second){
  
  z <- first + second
  return(z)
}
my_func_2(first = a, second = b)



###### talking about errors and warnings in functions
hardy_w <- function(p = runif(1)){
    # Function: hardy_w
    # Operation: does a Hardy Weinberg equilibrium problem
    # Input: p = allele frequency of the dominant allele
    # Output: q (recessive) = the frequencies of the three genotypes (fAA, fAB, fBB)
    #q <- 1 - p #defined q
    #print(c(q,p)) #   OR    print(sum(c(q,p))) should get 1 in this case
  
    if (p > 1 | p < 0){
      return("Function Failure: p must be greater then 0 but less than 1!")
    }
  
    q <- 1 - p
    fAA <- p^2 #gene frequencies
    fAB <- 2*p*q
    fBB <- q^2
  
    #store data for output
    out_vec <- signif(c(q = q, p = p, AA = fAA,  AB = fAB, BB = fBB), digits = 3) # signif defines how many significan digits

    return(out_vec) # return values
}
###########################################################################
# END OF FUNCTION

hardy_w(p = 3) # only gives a chunk of text not a true error


###### adding stop, true r style error!!!
hardy_w <- function(p = runif(1)){
    # Function: hardy_w
    # Operation: does a Hardy Weinberg equilibrium problem
    # Input: p = allele frequency of the dominant allele
    # Output: q (recessive) = the frequencies of the three genotypes (fAA, fAB, fBB)
    #q <- 1 - p #defined q
    #print(c(q,p)) #   OR    print(sum(c(q,p))) should get 1 in this case
  
    if (p > 1 | p < 0){
      stop("Function Failure: p must be greater then 0 but less than 1!")
    }
  
    q <- 1 - p
    fAA <- p^2 #gene frequencies
    fAB <- 2*p*q
    fBB <- q^2
  
    #store data for output
    out_vec <- signif(c(q = q, p = p, AA = fAA,  AB = fAB, BB = fBB), digits = 3) # signif defines how many significan digits

    return(out_vec) # return values
}
###########################################################################
# END OF FUNCTION

hardy_w(p = 3)


# creating a linear model function (regression)

# START OF FUNCTION
###########################################################################
fit_linear <- function(x = runif(20), y = runif(20)){
  # FUNCTION: fit_linear
  # PURPOSE: fits a simple linear regression
  # INPUTS: numeric vectors or predictors x and response 7
  # OUTPUTS: slope and p value
  

  #heres the model
  my_mod <- lm(y ~ x) 

  #get the values out
  my_out <- c(slope=summary(my_mod)$coefficients[2,1],
  p_value <- summary(my_mod)$coefficients[2,4])

  #plot the output
  plot(x = x, y = y)

  return(my_out)

}
# END OF FUNCTION

#can run
fit_linear()

# or assign global variables
var1 <- 1:20
var2 <- 21:40
fit_linear(x = var1, y = var2)



# more complex version with more complex defaults
# START OF FUNCTION
###########################################################################
fit_linear <- function(p = NULL){
  # FUNCTION: fit_linear
  # PURPOSE: fits a simple linear regression
  # INPUTS: numeric vectors or predictors x and response 7
  # OUTPUTS: slope and p value
  
  if(is.null(p)){
    p <- list(x = runif(20), y = runif(20))
  } #this will create a list of p if it is NULL

  my_mod <- lm(p$x ~ p$y) 

  my_out <- c(slope=summary(my_mod)$coefficients[2,1],
            p_value <- summary(my_mod)$coefficients[2,4])

  #plot the output
  plot(x = p$x, y = p$y)

  return(my_out)

}
# END OF FUNCTION

fit_linear()

# add my own parameters
my_params <- list(x = 1:10, y = sort(runif(10)))
my_params

fit_linear(p = my_params)

