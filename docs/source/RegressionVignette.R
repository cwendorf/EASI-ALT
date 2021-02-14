# Estimation Approach to Statistical Inference
## Multiple Regression Vignette

### Data Management

#### Data Entry

Pred1 <- c(5,6,6,7,7,7,8,8,9)
Pred2 <- c(6,7,8,8,7,9,7,9,9)
Outcome <- c(72,69,75,84,72,81,75,84,81)
RegressionData <- data.frame(Pred1,Pred2,Outcome)

### Inspect Data

RegressionData
plotBoxes(Pred1,Pred2)
addData(Pred1,Pred2)
plotBoxes(Outcome)
addData(Outcome)

#### Descriptive Statistics

describeMeans(Pred1,Pred2,Outcome)

### Analyses of a Regression Model

#### Describe the Regression Model

describeModel(Outcome~Pred1+Pred2)

#### Overall Fit of the Regression Model

fitModel(Outcome~Pred1+Pred2)

#### Significance Test of the Regression Model

testModel(Outcome~Pred1+Pred2)

### Analyses of the Regression Coefficients

#### Confidence Intervals for the Regression Coefficients

estimateRegression(Outcome~Pred1+Pred2)
estimateRegression(Outcome~Pred1+Pred2,conf.level=.99)

#### Plot of the Confidence Intervals for the Regression Coefficients

plotRegression(Outcome~Pred1+Pred2)
plotRegression(Outcome~Pred1+Pred2,conf.level=.99)

#### Significance Tests for the Regression Coefficients

testRegression(Outcome~Pred1+Pred2)
