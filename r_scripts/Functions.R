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





