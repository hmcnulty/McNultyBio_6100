# Script for Homework #14
# 04/22/2026
# Hannah Grace McNulty

#######################################################
library(tidyverse)
library(readxl)
library(ggplot2)
library(psych)  



soil <- read_excel("data/soil_df.xlsx", range = "A34:P95")

colnames(soil) <- soil[1, ]

soil <- soil[-1, ]

## PCA

# The dataset describes plant biomass characteristics based on soil moisture conditions.


# Create a figure showing PC1 and PC2 with 95% CI ellipses
## Do you see good separation of your groups on either axis? 

# 

soil_small <- soil[c(4:10)]

soil_small <- soil_small %>% mutate(across(c(soil_moisture, soil_organic_matter, fungal_richness, plant_biomass, bacterial_chao, fungal_chao, bacterial_richness), as.numeric))

soil_treatment <- soil$moisture_treatment

round(cor(soil_small), 2)

bart <- cortest.bartlett(cor(soil_small), n = nrow(soil_small))
bart

# The bartlett test shows a p-value of 5.545715e-41, confirming there is a difference between groups.

pca <- prcomp(soil_small, center = TRUE, scale. = TRUE)
summary(pca)

eig <- pca$sdev^2
pve <- eig / sum(eig)

pca_var_table <- data.frame(
  PC = paste0("PC", 1:length(eig)),
  Eigenvalue = round(eig, 3),
  PVE = round(pve, 3),
  CumPVE = round(cumsum(pve), 3)
)
pca_var_table


plot(eig, type = "b", pch = 19,
     xlab = "Principal component",
     ylab = "Eigenvalue",
     main = "Scree plot (soil PCA)")

broken_stick <- function(p) sapply(1:p, function(k) sum(1/(k:p)) / p)
bs <- broken_stick(ncol(soil_small))



retain <- data.frame(
  PC = paste0("PC", 1:length(pve)),
  ObservedPVE = round(pve, 3),
  BrokenStick = round(bs, 3),
  Keep = pve > bs
)
retain

# Based on the scree plot and broken stick test, only PC1 is needed. The ObservedPVE is 0.446, and the BrokenStick is 0.370, resulting in a keep of TRUE. 

head(pca$x)
pca$rotation

# The variables contributing most to PC1 are fungal_chao, fungal_richness, bacterial_chao and bacterial_richness. The variables which contribute most to PC2 are soil_moisture, plant_biomass and bacterial_richness. 

scores <- as.data.frame(pca$x)
scores$moisture_treatment <- soil_treatment


plt <- ggplot(scores, aes(PC1, PC2, color = moisture_treatment)) +
  geom_point(size = 2.6, alpha = 0.85) +
  theme_minimal() +
  labs(title = "PCA")

plt + stat_ellipse()

# In this PCA, there is minor separation on both the PC1 and PC2 axes. PC1 and PC2 show separations of Ambient and Drought moisture treatments grouping in the bottom right and top left of the graph, respectively. 



# Random Forest

library(randomForest)

soil_rf <- soil[c(2,4:10)]

soil_rf <- soil_rf %>% mutate(across(c(soil_moisture, soil_organic_matter, fungal_richness, plant_biomass, bacterial_chao, fungal_chao, bacterial_richness), as.numeric))

set.seed(42)

treatment_train <- sample(seq_len(nrow(soil_rf)), size = 0.7 * nrow(soil_rf))

train <- soil_rf[treatment_train, ]
test  <- soil_rf[-treatment_train, ]

str(soil_rf$soil_moisture)
soil_rf$soil_moisture <- factor(soil_rf$soil_moisture)

rf <- randomForest(
  soil_moisture ~ ., data = train,
  ntree = 500,
  mtry = 2,
  importance = TRUE
)
rf

# My OOB estimate of error rate is 0%. In this random forest model, there are 0 errors when predicting ambient or drought classes 500 times. 

# Based on my confusion matrix, my model is excillent at classifying drough or ambient measurements. The OOB is 0%, and the class.error was 0. 

pred <- predict(rf, newdata = test)
conf <- table(Observed = test$soil_moisture, Predicted = pred)
conf

acc <- mean(pred == test$soil_moisture)
acc

plot(rf, main = "Random forest OOB error vs number of trees")


importance(rf)

varImpPlot(rf)

# Based on Mean Decrease Accuracy, soil moisture and fungal richness were the most important variables for classification. The same variables were also the most important for Mean Decreased Gini. 


# The variables contributing most to PC1 are fungal_chao, fungal_richness, bacterial_chao and bacterial_richness. The variables which contribute most to PC2 are soil_moisture, plant_biomass and bacterial_richness. 


# Summary
# My models have similar variable importance, but they are not identical. The random forest model determined the most important variables for classification were, by a large margin, soil moisture and fungal richness. The PCA showed many variables were important in a smaller quantity including, fungal_chao, fungal_richness, bacterial_chao bacterial_richness, soil_moisture, plant_biomass, and bacterial_richness. The Soil moisture and fungal richness variables are found to be important in both models at varying amounts. 

# The random forest model provided a more specific set of important variables. The PCA gave several variables for PC1 and PC2, leaving the results and figure highly open to analysis and interpretation.