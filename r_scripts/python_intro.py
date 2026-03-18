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


