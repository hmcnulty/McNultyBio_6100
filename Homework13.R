

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


ssc_lmer <- lmer(mean_ssc ~ sampling_event * treatment_num + (1 | tree_id),
                 data = ssc_clean)

summary(ssc_lmer)
anova(ssc_lmer)


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


# This model tested if sap sugar concentration varied across time and treatment. There is substantial variation among individual trees, so Tree ID is included as a random effect. The anova found that part of the interaction is significant, specicically sampling events 1 and 2, with treatment 2 (Gravity). This interaction indicates that treatment effects sap sugar concentration over time.


# Question 2
# Does treatment and tree size influence the probability of high sap sugar concentration?


ssc2 <- ssc %>%
  mutate(
    high_ssc = ifelse(mean_ssc > 2, 1, 0),
    dbh = as.numeric(dbh),
    sampling_event = factor(sampling_event),
    treatment_num = factor(treatment_num),
    tree_id = factor(tree_id)
  )


ssc_event3 <- ssc2 %>%
  filter(sampling_event == 3)

table(ssc_event3$high_ssc)


ssc_glmm <- glmer(high_ssc ~ treatment_num + dbh,
                 data = ssc_event3,
                 family = binomial)


summary(ssc_glmm)
anova(ssc_glmm)


ssc_event3 %>% 
  ggplot(aes(x = dbh, 
            y = high_ssc,
          color = treatment_num)) +
  geom_smooth() +
  labs(
    x = "Tree Diameter (DBH)",
    y = "Probability of High Sugar (>2 °Brix)",
    color = "Treatment") +
  theme_classic() +
  scale_color_discrete(labels = c("Gravity", "Vacuum", "Sugar Control"))
  

# First, I seperated the trees into high (>2) and low (<2) sap sugar concentration to determine highly sweet trees. Then the model tested if tree size is influential on sap sugar concentration. The anova found that tree size (dbh) is not significantly effecting the probability of high sap concentration. Although, treatment 2 (Gravity) significantly reduces the probability of high sap sugar concentration compared to the alternate treatments


