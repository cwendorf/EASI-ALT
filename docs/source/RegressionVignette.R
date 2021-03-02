# Estimation Approach to Statistical Inference
## Regression Vignette

### Data Management

#### Data Entry

Predictor1 <- c(0,0,3,5)
Predictor2 <- c(4,7,4,9)
Criterion <- c(9,6,4,9)
RegressionData <- data.frame(Predictor1,Predictor2,Criterion)

### Inspect Data

RegressionData
describeBoxes(Predictor1,Predictor2)
plotBoxes(Predictor1,Predictor2)
addData(Predictor1,Predictor2)
describeBoxes(Criterion)
plotBoxes(Criterion)
addData(Criterion)

#### Descriptive Statistics

describeMeans(Predictor1,Predictor2,Criterion)

### Analyses of a Regression Model

#### Describe the Regression Model

describeModel(Criterion~Predictor1+Predictor2)

#### Overall Fit of the Regression Model

fitModel(Criterion~Predictor1+Predictor2)

#### Significance Test of the Regression Model

testModel(Criterion~Predictor1+Predictor2)

### Analyses of the Regression Coefficients

#### Confidence Intervals for the Regression Coefficients

estimateRegression(Criterion~Predictor1+Predictor2)
estimateRegression(Criterion~Predictor1+Predictor2,conf.level=.99)

#### Plot of the Confidence Intervals for the Regression Coefficients

plotRegression(Criterion~Predictor1+Predictor2)
plotRegression(Criterion~Predictor1+Predictor2,conf.level=.99)

#### Significance Tests for the Regression Coefficients

testRegression(Criterion~Predictor1+Predictor2)
