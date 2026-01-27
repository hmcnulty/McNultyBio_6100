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

#create an empty vector
z <- rep(NA, 100)
z
typeof(z) #logical, when you make it full of NAs


z[1] <- "Vermont"
head(z)

typeof(z)


#creating vectors with lots of names
my_vector <- runif(100) #give 100 random valuez from 0-1
my_names <- paste("Species", seq(1:Length(my_vector)), sep = "") #could also do seq(1:100), but not as goos if going to chnage the data later
#were creating "Species" 1-100, the seq function outlines the starting and the stopping positiion (going to give integers 1-100), sep with no space

print(my_names)

names(my_vector) <- my_names  #assigning the names to the vectors
head(my_vector) # showing the fist few in the file

str(my_vector) #structure function



#using the rep function

rep(0.5, 6) #can do this but below is better
rep(x=0.5, times = 6)

my_vec <- c(1, 2, 3)

#repeat a vector
rep(x = my_vec, times = 2, each = 2)

#sequencing a vector
seq(from = 2, to = 4)
2:4 #shorthand for above^

x <- seq(from = 2, to = 4, length = 7) #will equally space to make 7 values




my_vec <- 1:length(x) # common in other languages, slow in R

#IN R better to use
seq_along(my_vec)


#generating random vectors

runif(5) # gives us 5 values from 0-1

# making it generate the SAME RANDOM NUMBER sequence every time
runif(n=3, min=100, max = 101)

set.seed(123) #have to hit set.seed everytime!!!

runif(n=1, min=0, max = 1)



#now for normal distributions
out <- rnorm(n = 500, mean = 100, sd = 30) #creating a normal disctribution and ranomly sampling 500 times
hist(out)


#random sampling
long_vec <- seq_len(10) #10 long

sample(x = long_vec) #will shufflt vector

sample(x = long_vec, size = 100, replace = TRUE) #size is how many to take out randomly, if replace = true when we draw a card out we put it back in before thr next draw and have the osibilioty to get it again
#if we want the same ones drawn everytime we would need to set.seed



#weighted sampling from a vector, adding weights 
weights <- c(rep(20, 5), rep(100, 5))

sample(x = long_vec, replace = TRUE, prob = weights)



#################### Subsetting Vectors

z <- c(3.1, 9.2, 1.3, 0.4, 7.5)

z[1] #indexing, gives value in the 1 position

z[c(2,3)] #slicing and putting the 2nd and third vectors together

# a negative sign excludes a number z[-c(2,3)] would remove 2 and 3

#using logicals
z[z<3] #selects only the ones that are true for the statement











