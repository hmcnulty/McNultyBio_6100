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
#. #reserve for a temporary variable


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


#character strings " "

t <- "perch"
print(t)

t <- c("perch", "bass", "trout") #perch is the 1st position
print(t)
t[1]
t[3]


t <- c("this is a 'character' string", "a second") #actually two parts
t[1] #pulls the first part
t[2] #pulls the second

typeof(t)
is.character(t)
is.numeric(t)


# Logical/Boolean 

z <- c(TRUE, FALSE, TRUE)
z

is.logical(z)
is.integer(z)
typeof(z)


c(T, F) #can be made with the first capital letter

# true=1 false=0 so we can use it to do math, as below
mean(z) #0.6666667


# three properties of a vector

#type
z <- c(1.1, 1.2, 1.3, 1.4)
typeof(z)
is.numeric(z)
t <- as.character(z) #coerces variable from a numeric to a character

print(t)
typeof(t)

t <- c(1, 2, "3", 4) #if it sees one character, it will make the entire thing characters


#length
length(t)

#naming


#random number generator
z <- runif(5) #its going to default to numbers between 0 and 1

names(z) #NULL there are no names

names(z) <- c("A", "B", "C", "D", "E") #added names

print(z)

names(t) <- NULL #resets the names back to nothing


# special data types

z <- c(3.2, 3, 3, NA)
z

typeof(z)
length(z)
typeof(z[3]) #asking what the third position of z is
typeof(z[4])

sum(z) #returns value NA

sum(z, na.rm=T) #this removed NA and does the calculation


z <- 0/0
z


z <- 1/0
z


#vectorization
z <- c(10, 20, 30)

z + 1
z / 3

y <- c(1, 2, 3)

z + y


# recycling coercion 

x <- c(1, 2)

z + x # this recycled so 10+1= 11 and then 20+2=22, BUT there is no other number so it does the 1 again 30+1=31



##########################################
# Atomic Vectors Part 2!

z <- vector(mode = "numeric", length = 0) # create an empty vector, specify mode & length
print(z)

#dynamic creation, very inefficient in R
#adding elements, added 5 as a number
z <- c(z, 5)
z



#creating a vector with a predefined length, rep function

z <- rep(0, 100)
length(z) #checking length



