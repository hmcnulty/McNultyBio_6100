


# Random Forest
  # I have a problem, and I wanna use it to predict groups for things in the future
  # supervised learning
      # knows what the correct values are and tries to conform to that
  # classifier
      #  know the variable groups, train on the data, use the learning to take in new data and classify it based on the training data
  # decision trees




# PCA
  # get an idea of the overarching way that the variance is distribute
  # Unsupervised
      # has no idea about the data when running
  # dimensionality reduction
  # assumes normal distribution



# For reproducible results
set.seed(1)

# Packages used today
library(ggplot2)
library(psych)        # Bartlett's test
library(randomForest) # Random forest

# Data
data(iris)

# PCA ###########################################################
# Step 1: choose numeric columns and (usually) scale
iris_num <- iris[, 1:4]
iris_species <- iris$Species

round(cor(iris_num), 2)

# Step 2: check whether PCA is “worth it” (Bartlett’s test)
bart <- cortest.bartlett(cor(iris_num), n = nrow(iris_num))
bart

# Step 3: fit PCA with prcomp()
pca <- prcomp(iris_num, center = TRUE, scale. = TRUE)
summary(pca)


# Step 4: variance explained (small table) (eigen values and vector)
eig <- pca$sdev^2
pve <- eig / sum(eig)

pca_var_table <- data.frame(
  PC = paste0("PC", 1:length(eig)),
  Eigenvalue = round(eig, 3),
  PVE = round(pve, 3),
  CumPVE = round(cumsum(pve), 3)
)
pca_var_table

# Step 5: scree plot
plot(eig, type = "b", pch = 19,
     xlab = "Principal component",
     ylab = "Eigenvalue",
     main = "Scree plot (iris PCA)")

# test
broken_stick <- function(p) sapply(1:p, function(k) sum(1/(k:p)) / p)
bs <- broken_stick(ncol(iris_num))

retain <- data.frame(
  PC = paste0("PC", 1:length(pve)),
  ObservedPVE = round(pve, 3),
  BrokenStick = round(bs, 3),
  Keep = pve > bs
)
retain

# Step 6: interpret scores and loadings
head(pca$x)
pca$rotation

# Step 7: plot PC1 vs PC2 (color by species)
scores <- as.data.frame(pca$x)
scores$Species <- iris_species

plt <- ggplot(scores, aes(PC1, PC2, color = Species)) +
  geom_point(size = 2.6, alpha = 0.85) +
  theme_minimal() +
  labs(title = "PCA on iris", subtitle = "PCA is unsupervised; species used only for coloring")

plt + stat_ellipse() # 95% CI

# Optional: test group separation after PCA
man <- manova(cbind(PC1, PC2) ~ Species, data = scores)
summary(man, test = "Pillai")


# Random Forest ##################################################
# Step 1: define response and predictors
 # Here the response is Species (categorical), and predictors are the four measurements.

# Step 2: train/test split
set.seed(42)
id_train <- sample(seq_len(nrow(iris)), size = 0.7 * nrow(iris))
train <- iris[id_train, ]
test  <- iris[-id_train, ]

# Step 3: fit a random forest classifier
rf <- randomForest(
  Species ~ ., data = train,
  ntree = 500,
  mtry = 2,
  importance = TRUE
)
rf

# Step 4: evaluate on the test set
pred <- predict(rf, newdata = test)
conf <- table(Observed = test$Species, Predicted = pred)
conf

acc <- mean(pred == test$Species)
acc

# Step 5: OOB error curve
plot(rf, main = "Random forest OOB error vs number of trees")

# Step 6: variable importance
importance(rf)

varImpPlot(rf)

