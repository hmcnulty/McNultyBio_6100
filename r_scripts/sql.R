# Basics of SQL
# Hannah Grace McNulty
# # 2/26/2026

##########################################################################


library(tidyverse)
library(sqldf)

# read in the dataset
getwd()
setwd("/Users/hannahmcnulty/Documents/github/McNultyBio_6100/data")
species_clean <- read.csv("site_by_species.csv")
var_clean <- read.csv("site_by_variables.csv")


# start with operations/functions on just one file
# subsetting rows
#dplyr: use filter()
species <- filter(species_clean, Site < 30)
var <- filter(var_clean, Site < 30)


# SQL method - you first need to specify a query you will use, then run the sqldf()
query <- "SELECT Site, Sp1, Sp2, Sp3 FROM species WHERE site <'30'" 
# SELECT specifc columns, FROM a specific dataset/object, WHERE filters out for a condition
sqldf(query)


#dplyr for subsetting columns
edit_species <- species %>%
                select(Site, Sp1, Sp2, Sp3)
edit_species2 <- species %>%
                select(1, 2, 3, 4) # these are equivalent 



# query the entire table
query <- "SELECT * FROM species"
a <- sqldf(query)


# renaming columns
# dplyr, ure remane() function
species <- rename(species, Long=Longitude.x., Lat=Latitude.y.)

# sql, use AS command
query <- "SELECT Long AS Longitude FROM species"
sqldf(query)

# pulling out all the numeric columns in a dataset
num_species <- species %>%
              mutate(letters=rep(letters, length.out = length(species$Site)))

num_species <- select(num_species, Site, Long, Lat, Sp1, letters)
num_species

num_species_edit <- num_species %>%
                    select(where(is.numeric)) # looking for if its a numberic or not


# pivot longer to lengthen data, decreasing the number of columns and increasing the number of rows
species_long <- edit_species %>%
                pivot_longer( cols = c(Sp1, Sp2, Sp3), names_to = "ID")
# switch it back to wide
species_wide <- species_long %>%
                pivot_wider( names_from = ID)


# aggregating data, getting kinds of calculations
# SQL
query <- "SELECT SUM(Sp1+Sp2+Sp3) FROM species_wide GROUP BY SITE"
sqldf(query)

query <- "SELECT SUM(Sp1+Sp2+Sp3) AS Occurance FROM species_wide GROUP BY SITE" # rename the column created
sqldf(query)


# 2 file operations: joinging datasets together
# joining things can often be left/right/union joins

# start with clean versions of these variables
edit_species <- species_clean %>%
  filter(Site<30) %>%
  select(Site, Sp1, Sp2, Sp3, Sp4, Longitude.x., Latitude.y.)

edit_var <- var_clean %>%
  filter(Site<30) %>%
  select(Site,Longitude.x., Latitude.y., BIO1_Annual_mean_temperature, BIO12_Annual_precipitation)

# leftjoin() stitching matching rows from file b to file a, requires a matching column to link them
left <- left_join(edit_species, edit_var, by= "Site")
right <- right_join(edit_species, edit_var, by= "Site")
inner <- inner_join(edit_species, edit_var, by= "Site") # retains the rows that match between both files, looses a lot of information if they are not matching
full <- full_join(edit_species, edit_var, by= "Site")# fill_join is the opposite where you keep all values but end up with a lot on NA's


# SQL joining data
query <- "SELECT * FROM edit_var RIGHT JOIN edit_species ON edit_var.Site=edit_species.Site;"
x <- sqldf(query)
x


