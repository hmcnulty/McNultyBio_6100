# dplyr
# February 25th 2026
# Hannah Grace McNulty

#-----------------------------------------------------


# filter(), arrange(), select(), summarize(), group_by(), mutate()

# start with a built in dataset
library(tidyverse)

# to specify the package you are using, you can first call on the package name
dplyr::filter()

# dataset already in r
data(starwars)

class(starwars) # it's a tbl but in gereral can treat them the same as a df

# how to get a quick look at the data
head(starwars)
tail(starwars)
glimpse(starwars)

# cleaning up our dataset

#base r has the complete.cases function. this removes any rows with NA's in it - any instance of NA will remove the ENTIRE row

# indexing has the form of [rows, columns]
starwars_clean <- starwars[complete.cases(starwars[, 1:10]),] # this is only concerning the forst 10 columns of the data set

# check for NA's can use either
is.na(starwars_clean[,1]) 
anyNA(starwars_clean[,1:10])


# filter function - this will subset observations by their values
# use operators - >, >=, <=, ==, !, %in% c((for multiple things))
# use logical operators like & and |(or)
# filter automatically exclused NA's, have to ask for them specifically if you want them

filter(starwars_clean, gender=="masculine" & height < 180)

# add conditional statements with ,
filter(starwars_clean, gender=="masculine", height < 180, height > 100)
filter(starwars_clean, eye_color %in% c("blue", "brown")) # filter multiple conditions

# arrange() reorder rows
arrange(starwars_clean, by = height)
arrange(starwars_clean, by = desc(height)) # desc puts it in descending order
arrange(starwars_clean, height, desc(mass)) # this breaks any ties in a df, like the same height for example then it goes to mass

# select() choose variables based on names/columns
starwars_clean[1:10,] #in base r simple indexing
select(starwars_clean, 1:10) #equivalent to above
select(starwars_clean, name:homeworld) # provides only the columns between column name and homeworld
select(starwars_clean, -(films:starships)) # subsetting everythjing except these variables

# rearrange columns
select(starwars_clean, homeworld, name, gender, species) #only includes the ones you name
select(starwars_clean, homeworld, name, gender, species, everything()) # spit out the rest after the point we stop naming
select(starwars_clean, contains("color")) # looks for column names with color in them 

# rename columns
select(starwars_clean, haircolor=hair_color) # new name first

# mutate() create new variables with functions of existing variables
# create a new column that height divided by mass
mutate(starwars_clean, ratio=height/mass)
starwars_lbs <- mutate(starwars_clean, mass_lbs=mass*2.2)

# you can use the transmute() function to only save the new variable you made
transmute(starwars_clean, mass_lbs=mass*2.2)

# summarize() and group_by() collape a lot of values down to a single summary
summarize(starwars_clean, meanheight=mean(height))
summarize(starwars, heightmean=mean(height)) #will only work with no NA's
summarize(starwars, meanheight=mean(height, na.rm=TRUE), totalnumber = n()) # how to remove NA's within the summary, and see how many rows went into the value

# group_by() for additional calculations
starwars_gender <- group_by(starwars, gender) #separates by whatever it is grouped by
summarize(starwars_gender, meanheight=mean(height, na.rm=TRUE), totalnumber = n())


# pipe statements - the pipe operator is %>% (or |>)
# means 'and then', chains together particular actions
# going to pass intermediate results onto the next function in your sequence
# avoid when you need to manipulate more than one object, or if there are meaningful intermediate objects
# formatting: you should have a space before and follow it with an indent
starwars_clean %>%
  group_by(gender) %>%
  summarize(meanheight=mean(height, na.rm = TRUE), number = n())


# case_when() is useful for multiple 
starwars_clean %>%
  mutate(sp=case_when(species=="Human"~"Human", TRUE ~ "Non_human")) %>%
  select(name, sp, everything())


# pivoting from long to wide format using pivot_wider or pivot_longer
wideSW <- starwars_clean %>%
  select(name, sex, height) %>%
  pivot_wider(names_from = sex, values_from = height, values_fill = NA)


pivot_sw <- starwars %>%
  select(name, homeworld) %>%
  group_by(homeworld) %>%
  mutate(rn=row_number()) %>%
  ungroup() %>%
  pivot_wider(names_from = homeworld, values_from = name)

wideSW %>% #reverting back to the original 
  pivot_longer(cols = male:female, names_to = "sex", values_to = "height", values_drop_na = TRUE)




