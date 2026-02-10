# basic coding with for loops
# february 10th, 2026
# Hannah Grace McNulty


# creating a basic for loop:

for (i in 1:5) { #declared a loop of 1-5
  cat("stuck in a loop", "\n") # the "\n" moves it to the next line in the console
  cat(3 + 2, "\n")
  cat(runif(1), "\n")
}

my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")

for (i in 1:length(my_dogs)){
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}


my_bad_dogs <- NULL 
for (i in 1:length(my_bad_dogs)){
    cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")

}

for (i in seq_along(my_dogs)){
    cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")

}
