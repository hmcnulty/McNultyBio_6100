

# Using a dataset of your choice, ask two separate questions about the data and construct an appropriate model and figure to test and visualize each one.


# At least one non-guassian distribution
# At least one interaction term
# At least one mixed model with a random effect.


library(tidyverse)
library(lubridate)
library(lme4)
library(car)
library(readxl)
library(ggplot2)
library(dplyr)

ssc <- read_excel("data/my_data_class.xlsx")


ssc_clean <- ssc %>%
  mutate(
    treatment_num = factor(treatment_num),
    treatment_name = factor(treatment_name),
    tree_id = factor(tree_id),
    mean_ssc = as.numeric(mean_ssc),
    sampling_event = factor(sampling_event)
  )

glimpse(ssc_clean)



# Question 1
# Does sap sugar concentration vary across time by treatment?

ssc_lmer <- lmer(mean_ssc ~ sampling_event + treatment_num + (1 | tree_id),
  data = ssc_clean)

summary(ssc_lmer)


ssc_clean %>% 
  ggplot(aes(x = sampling_event,
             y = mean_ssc,
            col = treatment_num)) + 
  geom_boxplot() + 
  labs(
    x = "Time",
    y = "Mean Sap Sugar Concentration") + 
  theme_classic() +
  scale_y_continuous(limits = c(1,3), expand = c(0.02,0.02)) +
  #scale_x_continuous(limits = c(0,100), expand = c(0.02,0.02))
  scale_color_discrete(labels = c("Gravity", "Vacuum", "Sugar Control"))


anova_test(data = ssc_clean, dv = mean_ssc, wid = tree_id, 
  within = c(sampling_event, treatment_num))





library(rstatix)





ssc_clean_clean <- ssc_clean %>%
  group_by(tree_id) %>%
  mutate(avg_mean_ssc = mean(mean_ssc, na.rm = TRUE)) %>%
  summarise(avg_mean_ssc = mean(avg_mean_ssc, na.rm = TRUE))





ssc_avg <- ssc_clean %>%
  group_by(treatment_num, sampling_event) %>%
  mutate(avg_mean_ssc = mean(mean_ssc, na.rm = TRUE)) %>%
  summarise(avg_mean_ssc = mean(avg_mean_ssc, na.rm = TRUE), .groups = "drop")

ssc_avg %>% 
  ggplot(aes(x = sampling_event,
             y = avg_mean_ssc,
            color = treatment_num,
             group = treatment_num)) + 
  geom_point() + 
  geom_line() +
  labs(
    x = "Time",
    y = "Mean Sap Sugar Concentration",
    color = "Treatment") + 
  theme_classic() +
  scale_y_continuous(limits = c(1,3), expand = c(0.02,0.02)) +
  #scale_x_continuous(limits = c(0,100), expand = c(0.02,0.02))
  scale_color_discrete(labels = c("Gravity", "Vacuum", "Sugar Control"))