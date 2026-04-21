# Script for Homework #9
# 03/18/2026
# Hannah Grace McNulty

#######################################################

library(ggplot2)
library(tidyverse)

iris <- iris



# Question 1

q1 <- iris %>% ggplot(aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(size = 1) +
  geom_smooth(method = "lm") +
  labs(
    x = "Petal Length (cm)",
    y = "Petal Width (cm)") +
  theme_classic() +
  scale_y_continuous(limits = c(0,3), expand = c(0.02,0.02)) + #fix scale on both axis
  scale_x_continuous(limits = c(0,8), expand = c(0.02,0.02))


# Question 2

q2 <- iris %>% ggplot(aes(x = Species, y = Petal.Length)) +
  geom_boxplot(fill = "green") +
  #geom_jitter() + 
  labs(
    x = "Species Type",
    y = "Petal Length (cm)") +
  theme_classic() +
  scale_y_continuous(limits = c(0,8), expand = c(0.02,0.02))



# Question 3

library(tidyverse)

df <- iris %>% mutate(is_setosa = case_when(
  Species == "setosa" ~ 1,
  Species %in% c("virginica", "versicolor") ~ 0,))



q3 <- df %>% ggplot(aes(x = Petal.Length, y = is_setosa)) +
  geom_point(size = 1) +
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  labs(
    x = "Petal Length (cm)",
    y = "Is Setosa Species") +
  theme_classic() +
  scale_y_continuous(limits = c(0,1.5), expand = c(0.02,0.02)) + #fix scale on both axis
  scale_x_continuous(limits = c(0,8), expand = c(0.02,0.02))


# Question 4

bee_data <- read.csv("/Users/hannahmcnulty/Documents/github/McNultyBio_6100/data/bees.csv",header = T, sep=",")



mosaicplot(~ sampling_event + bee_caste, data = bee_data, color = c("pink", "purple", "lightblue"), main = "Sampling Event and Bee Caste", xlab = "Sampling Event", ylab = "Bee Caste")




