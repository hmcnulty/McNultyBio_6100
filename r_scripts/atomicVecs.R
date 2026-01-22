# This is a document describing vectors in R
# January 22nd 2026
# Hannah Grace McNulty


#-----------------------------------------------------
# START OF SCRIPT

x <- 5 #assigning a variable a number
print(x) # can print either this way, or just putting the x
x

y = 3 #also makes a value but, only stores the number within a function, it works in python but not in r

#two different naming options for values or variables
plant_height <- 3 #this is called snake case ___ this is what i use!
plantHeight <- 4 #this is camel case 
plant.height <- 2 #not preferred but can do it in a pinch
. #reserve for a temporary variable


#four basic data types in R

# dimension | homogenous (1,2 (t),3) | heterogenous (1, Y, T)
#    1D     |      Vector            |     list
#    2D     |      matrix            |   data frame
#   N-D     |      array             |    xxxxxx


#1D Atomic vector:
z <- c(3.2, 5, 5, 6)
print(z)
typeof(z) #asking what type we have, double means its a decimal and can go on forever (mainly means a numeric variable)

z <- c(c(3.2, 3), c(3, 5)) #flattens them back into a vector
z

is.numeric(z) #yes
is.character(z) #no


#character strings


