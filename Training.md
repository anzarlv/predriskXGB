# Instructions on training an XGBoost survival model
This file gives a step-by-step overview of how to train an XGBoost model that infers risk from morphometric features.

## Step 1
Import packages
```
library(surxXgboost) # specialized xgboost package that returns predictions on hazard ratio scale
library(xgboost) # regular xgboost package
```
## Step 2
Read in relevant csv file
```
training_df <- read.csv(...) # input file path to training data into read.csv function
```
Look at sample_training_data.RData for training data formatting (note that both Time and Survival must be included in training)

## Step 3.1 
Label the training data
```
label <- ifelse(training_df$Survival == 1, training_df$Time, -training_df$Time) # supervised learning approach
```

## Step 3.2
Set seed for reproducibility (optional, but recommended)
```
set.seed(123456)
```

## Step 3.3
Train the XGBoost model
```
# prepare training data
x_train <- as.matrix(training_df[is.train, !colnames(training_df) %in% c("Time", "Survival")]) # must be in matrix format for XGBoost
x_label <- label[is.train]

# train XGBoost model
model <- xgb.train.surv(
  params = list(
    objective = "survival:cox",
    eval_metric = "cox-nloglik",
    eta = 0.3 # default (very large eta can lead to the algorithm never converging)
    max_depth = 6 # default
    subsample = 1 # default
  ),
  data = x_train,
  label = x_label,
  nrounds = 100
)
```
