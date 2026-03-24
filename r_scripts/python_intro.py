# Intro to Python
# March 17th 2026
# Hannah Grace McNulty



# Installing Libraries:
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# if you want to pull from a particular function, you have to specity -> np.mean()

#################################
# Objects, Methods, and Functions
#################################

# Printing
print("I love Python")

greeting = "Hello"
print(greeting)


# Numeric Varibles
scaler = 6 # integer value
out = scaler * 3 #doing math with an object
print(out)

# Making a list
myList = [34, 7, 98] # create a list

# Methods
myList.append(33) # add 33 and changes the object within the original file, appending data in a list

len(myList) # length function

##################
# Data Structures:
##################

# make a list of colors
a_list = ["blue", "green", "red"]

# indexing into a list
print(a_list[0])

first_element = a_list[0] # save it as a value
print(first_element)


# looking at data types
nums = [1,2,5,8]
chars = ["a", "b", "c"]
boolean = [True, True, False]

# mixed list of data types
mixed = [1, 2, True, "blue", 5]

# checking data types
type(nums) # type of the whole 
type(nums[0]) # type of the specific character

# Negative Indexing
mixed[-1] # will return the last element
mixed[-3] # third element from the right

# Ranged Indexing
mixed[1:4] # pulls out elements 2-4 , PYTHON STARTS AT 0 SO WE ARE CALLING ON THE SECOND ELEMENT, ALSO GOES UP TO 4 DOES NOT INCLUDE IT
mixed[:4] # goes from the start to the 4th place
mixed[2:] # from third element to the end

# is an item in the list
1 in mixed

# changing elements
mixed[4] = "green" # overrides the element
mixed.insert(0, "start") # inserts in the specific position without overriding it

# other methods associated with a list object:
# extend
# remove
# pop
# clear
# 


# List Comprehension

print(mixed)

[x for x in mixed] # x is indexing variable 

[x for x in mixed if isinstance(x,str)] # each element in mixed if its a character string

###############
# Dictionaries:
###############

#manually creating
md = {
    "first":"John",
    "last":"Smith",
    "year":2017,
    "status":"active"
}
type(md) #what type
len(md) # length of the pairs

#creating with the constructor function
md2 = dict(first = "John", last = "Smith")

# Data types within a dictionary
data_types = {
    "string":"thing",
    "integer":3,
    "float":3.14342,
    "list":[1,2,3,"a"],
    "boolean":False
}

data_types["string"] # returns the value associated with it

data_types.get("boolean") # built in method works too

# return all keys and values using methods in dictionary
data_types.keys()
data_types.values()

data_types.items() #shows pairs in a list (tuples)

data_types["age"] = 36 # add an element

data_types["age"] = 25 # change an element

##########################
# NUMPY
##########################
# creating a numpy array
arr1 = np.array([0,1,2,3,4,5,6,7,8,9])
arr1[3]
arr1[-1] # last element
arr1[:3] # beg to third element (doesnt include the third place)
arr1[1:5] # slice in
arr1[1:8:3] # index with a step, between 1 and 8 it will give every third element

# 2D array
arr2 = np.array([[1,2,3], [4,5,6], [7,8,9]])
arr2[2,2]
arr2[:,2] # all the rows for the column in the third place
arr2[2,:] # rows
arr2[0:2, 0:2] #subset of the array

# 3D array
arr3 = np.array([[[1,2], [3,4]], [[5,6], [7,8]]])

# 3D indexing
arr3[1,0,1]

# Dimensions
arr1.ndim
arr2.ndim
arr3.ndim

# shape of an array
arr1.shape
arr2.shape
arr3.shape

arr2.dtype
arr2.astype(str) # convert to character strings

#reshaping an array
arr1.shape
arr1.reshape(2,5)

# 3D array to 2D
arr3.shape
arr3.reshape(4,2)

# combining arrays
first = np.array([1,2,3])
second = np.array([4,5,6,7,8,9])

long_array = np.concatenate((first, second))

#select axis for higher dims
new_stack = np.concatenate((arr2, arr2), axis = 1) #can change the axis

# stacking arrays
new_stack2 = np.stack((arr2, arr2))

# splitting arrays
np.array_split(arr1, 2)
np.array_split(arr1, 2, axis = 0)

# random numbers
from numpy import random

random.seed(seed = 100)

random.randint(50) # value from 0-50

random.rand(50) # 50 values from 0-1

random.rand(50, 5, 10)

random.choice(arr1) # random number from array 1 (with replacement)

random.choice(arr1, size = (3,3)) #pull from array 1 into a certain size matrix

random.choice([0,1], p = [.3, .7], size = 100)


################
# distributions
################

# Normal Distribution
x = random.normal(loc = 5, scale = 3, size = 20)

plt.hist(x)
plt.show()

# Binomial Distribution
x = random.binomial(n = 10, p = 0.5, size = 300)
plt.hist(x)
plt.show()

# uniform distribution
x = random.uniform(low = 1, high = 10, size = 50)
plt.hist(x)
plt.show()



#######
# Math between arrays
#######
# y - x # subtraction
# y + x # addition
# y / x # division
# y * x # multiplication

# x * 100 # multiply by a scalar

# arr2 * arr2 # multiply two arrays

# functions
np.mean(arr2)
np.max(arr2)

########################
# Logic Structures
########################

# if stat.
a = 3

if a >= 5:
    print("a is greater than or equal to 5")
# only prints if it meets the condition

if a >= 5:
    print("a is greater than or equal to 5")
else:
    print("a is less than 5")
# doing both possible outcomes

a = 3
b = 3
operation = "mult"

if operation == "mult":
    y = a * b
elif operation == "div":
    y = a / b
elif operation == "add":
    y = a + b
elif operation == "sub":
    y = a - b
else:
    y = "I dont know that operation!"        





######################
# LOOPS
######################
l = [10,20]

for i in range(2):
    print([l[i]])

# loop on a object directly
x = ["blue", "green", "red"]

for i in x:
    print(i)


# more complicated loop
rnd = random.uniform(low = 1, high = 5, size = 10)

out_list = [] # creating a truely empty list

arr1

for i in range(len(arr1)):
    out_list.append(rnd[i] + arr1[i])


# nested loop woth ifelse
rnd2D = random.uniform(low = 0, high = 1, size = (3,3))

mat_out = np.empty(shape = (3,3))
shp = rnd2D.shape


# writing nexted loop
for i in range(shp[0]):
    for j in range(shp[1]):

        if rnd2D[i,j] >= 0.5:
            mat_out[i,j] = rnd2D[i,j] * 1000
        else: 
            mat_out[i,j] = rnd2D[i,j] / 1000



########################################
# PANDAS Dataframes
########################################
import pandas as pd

dates = pd.date_range("20130101", periods = 6)

df = pd.DataFrame(np.random.randn(6,4), index = dates, columns = list("ABCD"))

# df methods
df.head(4)
df.tail(4)

df.index # pulls the row index names
df.columns # pulls the column names

df.describe() # summary stats for each column

df.to_numpy() # converts to numpy, take out all row and column names and just leaves the data

# indexing into pandas
df["A"]
df.loc[:, ["A", "B"]]
df["20130102":"20130104"]

# read in a csv file

ds = pd.read_csv("data/iris.data.csv")

ds["sepal_length"] # pulling col out

ds["sepal_area"] = ds.sepal_length * ds.sepal_width # creating a new column

# fully numeric filter
df[df>.5]


