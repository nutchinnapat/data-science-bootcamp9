library(tidyverse)
library(caret)

## import data set (csv file)
churn <- read_csv("churn.csv")
## preview data
head(churn)
view(churn)
## Predict churn: "Yes" and "No"
## 1. split data
train_test_split <- function(data, size=0.8) {
  set.seed(42)
  n <- nrow(data)
  train_id <- sample(1:n, size*n)
  train_df <- data[train_id, ]
  test_df <- data[-train_id, ]
  return( list(train_df, test_df) )
}

prep_df <- train_test_split(churn, size=0.8)

## 2. train model
## cv stands for K-Fold CV
ctrl <- trainControl(method = "cv",
                     number = 10)

model <- train(churn ~ accountlength 
               + internationalplan 
               + voicemailplan 
               + numbervmailmessages 
               + totaldayminutes 
               + totaleveminutes 
               + totalnightminutes
               + totalintlcalls 
               + totalintlcharge 
               + numbercustomerservicecalls
,
               data = prep_df[[1]],
               method = "glm",
               trControl = ctrl)

## 3. score model
pred_churn <- predict(model, newdata= prep_df[[2]])

## 4. evaluate model
actual_churn <- prep_df[[2]]$churn

conf_churn <- confusionMatrix(pred_churn, factor(actual_churn))

print(model)
print(conf_churn)
