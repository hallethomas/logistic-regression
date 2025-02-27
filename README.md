# logistic-regression
Heart Disease Prediction Analysis

Overview

This R script analyzes heart disease prediction using logistic regression models. It evaluates model performance using metrics such as AUC (Area Under the Curve), AIC (Akaike Information Criterion), and the Brier score with leave-one-out cross-validation (LOOCV).

Prerequisites

Ensure you have the following R packages installed before running the script:

install.packages("pROC")
install.packages("survival")
install.packages("asaur")

Script Breakdown

1. Data Preparation

The dataset hw3_heart is loaded into df.

The class variable is reclassified into a binary status variable (0 = no disease, 1 = disease).

2. Logistic Regression Model & AUC Calculation

A logistic regression model (glm) is fit using trestbps as a predictor.

AUC is calculated using the pROC package.

3. Comparing Two Models

Model 1 uses predictors: age, thalach, chol.

Model 2 adds trestbps to Model 1.

AUC values for both models are computed to evaluate the incremental value of trestbps.

AIC values are calculated, and the difference between AIC(Model 1) and AIC(Model 2) is determined.

4. Leave-One-Out Cross-Validation (LOOCV) for Brier Score

A logistic regression model using all 13 predictors is trained using LOOCV.

The Brier score is computed as an average squared prediction error across all observations.

Outputs

AUC values for Model 1 and Model 2.

Difference in AIC between the two models.

Computed Brier score for model validation.
