df = hw3_heart
install.packages("pROC")
library(pROC)
library(survival)
library(asaur)
#reclassify heart disease variable
df$status = ifelse(df$class == 0, 0, ifelse(df$class != 0, 1, NA))

#generalized linear model
model = glm(df$status ~ df$trestbps, data = df)

# predicted data
prediction <- predict(model, type="response")
roc_obj = roc(df$status, prediction, direction = "<")
auc_training = roc_obj$auc

#auc = 0.612 
#this is the training error rate, or in the case of AUC, training performance

#Consider fitting two logistic regression models to predict heart disease. 
#Model 1 uses the predictors age, thalach, and chol. Model 2 uses the predictors age,
#trestbps, chol, and thalach. Considering the AUC for the two models, what is the 
#incremental value of adding trestbps as a predictor? Round your answer to 2 decimal places. (Do not use CV to answer this question.)

model1 = glm(df$status ~ df$age + df$thalach + df$chol, family = "binomial")
model2 = glm(df$status ~ df$age + df$trestbps + df$chol + df$thalach, family = "binomial")

#IV(Z_b ) = AUC(p(Z_b)) - AUC(p(Z_b))

AUC1 = preds = predict(model1, type = "response")
roc_object1 = roc(df$status, preds, direction = "<")
roc_object1$auc
#AUC 1 = 0.5768

AUC2 = preds = predict(model2, type = "response")
roc_object2 = roc(df$status, preds, direction = "<")
roc_object2$auc
#Area under the curve: 0.6495

inc_val = roc_object1$auc - roc_object2$auc

#Consider fitting two logistic regression models to predict heart disease. Model 1 uses 
#the predictors age, thalach, and chol. Model 2 uses the predictors age, trestbps, chol, and thalach. 
#Calculate the Akaike information criterion (AIC) for both models. What is AIC(Model 1) - AIC(Model 2)? 

q = AIC(model1) - AIC(model2)

# Consider fitting a logistic regression model using all 13 predictors to predict heart disease.
# Use leave-one-out cross-validation to estimate the average Brier score of this model. 
# Round your answer to 2 decimal places.

total.n = nrow(df)
test.error.vector = vector(length = total.n)

for (i in 1:total.n) {
  training.data = df[-i, ]  # Use all but the i-th row for training
  test.data = df[i, , drop = FALSE]  # Ensure test data is a dataframe
  
  # Fit the logistic regression model
  logistic_model = glm(status ~ age + trestbps + chol 
                       + thalach + fbs + restecg + 
                         exang + oldpeak + slope + thal + ca + cp + X, 
                       data = training.data, family = binomial)  # Specify binomial family
  
  # Predict for the test observation
  preds = predict(logistic_model, newdata = test.data, type = "response")
  
  # Calculate squared error (Brier score component)
  test.error.vector[i] = (preds - test.data$status)^2
}

# Compute final Brier score
brier_score = mean(test.error.vector)
print(brier_score)
