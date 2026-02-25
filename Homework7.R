# Script for Homework #7
# 02/25/2026
# Hannah Grace McNulty

#######################################################

library(dplyr)
library()
install.packages("sql")


# Question 1
# Examine the structure of the iris data set. How many observations and variables are in the 
# data set?

data(iris)

glimpse(iris)
# Variable # = 5
# Observation # = 150


# Question 2
# Create a new data frame iris1 that contains only the species virginica and versicolor with 
# sepal lengths longer than 6 cm and sepal widths longer than 2.5 cm. How many observations 
# and variables are in the data set?

iris1 <- iris %>%
  filter(Species=="virginica" | Species=="versicolor",Sepal.Length > 6 & Sepal.Width > 2.5)

glimpse(iris1)
# Variable # = 5
# Observation # = 56
  

# Question 3
# Now, create a iris2 data frame from iris1 that contains only the columns for Species, 
# Sepal.Length, and Sepal.Width. How many observations and variables are in the data set?

iris2 <- iris1 %>%
  select(Species, Sepal.Length, Sepal.Width)

glimpse(iris2)
# Variable # = 3
# Observation # = 56

# Question 4
# Create an iris3 data frame from iris2 that orders the observations from largest to smallest 
# sepal length. Show the first 6 rows of this data set.

iris3 <- iris2 %>%
  arrange(by = desc(Sepal.Length))

head(iris3, 6)


# Question 5
# Create an iris4 data frame from iris3 that creates a column with a sepal area 
# (length * width) value for each observation. How many observations and variables are in the
#  data set?

iris4 <- iris3 %>%
  mutate(Sepal_Area= Sepal.Length*Sepal.Width)

glimpse(iris4)
# Variables = 4
# Observations = 56

# Question 6
# Create iris5 that calculates the average sepal length, the average sepal width, and the 
# sample size of the entire iris4 data frame and print iris5.

iris5 <- iris4 %>% 
  summarize(Average_Sepal_Length=mean(Sepal.Length, totalnumber = n()),
            Average_Sepal_Width=mean(Sepal.Width, totalnumber = n()),
          Sample.Size = n())

print(iris5)


# Question 7
# Finally, create iris6 that calculates the average sepal length, the average sepal width, 
# and the sample size for each species of in the iris4 data frame and print iris6.

iris6 <- iris4 %>%
  group_by(Species) %>%
  summarize(Average_Sepal_Length=mean(Sepal.Length, totalnumber = n()),
            Average_Sepal_Width=mean(Sepal.Width, totalnumber = n()),
          Sample.Size = n())

print(iris6)


# Question 8
# In these exercises, you have successively modified different versions of the data frame 
# iris1 iris2 iris3 iris4 iris5 iris6. At each stage, the output data frame from one operation
#  serves as the input fro the next. A more efficient way to do this is to use the pipe 
# operator %>% from the tidyr package. See if you can rework all of your previous statements
#  (except for iris5) into an extended piping operation that uses iris as the input and 
# generates irisFinal as the output.

irisFinal <- iris %>%
  filter(Species=="virginica" | Species=="versicolor", Sepal.Length > 6 & Sepal.Width > 2.5) %>% #Q2 iris2
  select(Species, Sepal.Length, Sepal.Width) %>% #Q3 iris3
  mutate(Sepal_Area= Sepal.Length*Sepal.Width) %>% #Q4 iris4
  group_by(Species) %>%
  summarize(Average_Sepal_Length=mean(Sepal.Length, totalnumber = n()),
            Average_Sepal_Width=mean(Sepal.Width, totalnumber = n()),
          Sample.Size = n()) #Q6 iris6

# Question 9
# Create a ‘longer’ data frame using the original iris data set with three columns named 
# “Species”, “Measure”, “Value”. The column “Species” will retain the species names of the 
# data set. The column “Measure” will include whether the value corresponds to Sepal.Length, 
# Sepal.Width, Petal.Length, or Petal.Width and the column “Value” will include the numerical
#  values of those measurements.

iris_longer <- iris %>%
  pivot_longer(cols = Sepal.Length:Petal.Width, 
                names_to = "Measure", 
                values_to = "Value")

print(iris_longer)


