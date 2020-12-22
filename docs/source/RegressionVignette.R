# Estimation Approach to Statistical Inference
## Multiple Regression Vignette

### Three Variable Example Data

Pred1 <- c(5,6,6,7,7,7,8,8,9)
Pred2 <- c(6,7,8,8,7,9,7,9,9)
Outcome <- c(72,69,75,84,72,81,75,84,81)

RegressionData <- data.frame(Pred1,Pred2,Outcome)
RegressionData

### Analyses of a Regression Model

#### Overall Fit of Regression Model

pvaRegression(Outcome~Pred1+Pred2)

#### Confidence Intervals for the Regression Coefficients

ciRegression(Outcome~Pred1+Pred2)
ciRegression(Outcome~Pred1+Pred2,conf.level=.99)

#### Plot of the Confidence Intervals for the Regression Coefficients

cipRegression(Outcome~Pred1+Pred2)
cipRegression(Outcome~Pred1+Pred2,conf.level=.99)

#### Significance Tests for the Regression Coefficients

nhstRegression(Outcome~Pred1+Pred2)
