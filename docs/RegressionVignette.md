---
title: "Estimation Approach to Statistical Inference"
author: "Craig A. Wendorf"
date: "2021-02-14"
output: 
  rmarkdown::html_vignette:
    keep_md: TRUE
vignette: >
  %\VignetteIndexEntry{Multiple Regression Vignette}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---





# Estimation Approach to Statistical Inference
## Multiple Regression Vignette

### Data Management

#### Data Entry


```r
Pred1 <- c(5,6,6,7,7,7,8,8,9)
Pred2 <- c(6,7,8,8,7,9,7,9,9)
Outcome <- c(72,69,75,84,72,81,75,84,81)
RegressionData <- data.frame(Pred1,Pred2,Outcome)
```

#### Inspect Data


```r
RegressionData
```

```
##   Pred1 Pred2 Outcome
## 1     5     6      72
## 2     6     7      69
## 3     6     8      75
## 4     7     8      84
## 5     7     7      72
## 6     7     9      81
## 7     8     7      75
## 8     8     9      84
## 9     9     9      81
```

```r
plotBoxes(Pred1,Pred2)
addData(Pred1,Pred2)
```

![](figures/Regression-Data-1.png)<!-- -->

```r
plotBoxes(Outcome)
addData(Outcome)
```

![](figures/Regression-Data-2.png)<!-- -->

#### Descriptive Statistics


```r
describeMeans(Pred1,Pred2,Outcome)
```

```
## 
## DESCRIPTIVE STATISTICS FOR THE DATA
## 
##         N      M    SD
## Pred1   9  7.000 1.225
## Pred2   9  7.778 1.093
## Outcome 9 77.000 5.612
```

### Analyses of a Regression Model

#### Overall Fit of Regression Model


```r
describeModel(Outcome~Pred1+Pred2)
```

```
## 
## SOURCE TABLE FOR THE MODEL
## 
##               SS df     MS
## Pred1     90.750  1 90.750
## Pred2     78.681  1 78.681
## Residuals 82.569  6 13.761
```

#### Significance Test of the Regression Model


```r
testModel(Outcome~Pred1+Pred2)
```

```
## 
## HYPOTHESIS TEST FOR THE MODEL
## 
##           F df1 df2     p
## Model 6.156   2   6 0.035
```

### Analyses of the Regression Coefficients

#### Confidence Intervals for the Regression Coefficients


```r
estimateRegression(Outcome~Pred1+Pred2)
```

```
## 
## CONFIDENCE INTERVALS FOR THE REGRESSION COEFFICENTS
## 
##                Est    SE     LL     UL
## (Intercept) 43.741 9.594 20.265 67.217
## Pred1        0.538 1.415 -2.925  4.001
## Pred2        3.792 1.586 -0.088  7.672
```

```r
estimateRegression(Outcome~Pred1+Pred2,conf.level=.99)
```

```
## 
## CONFIDENCE INTERVALS FOR THE REGRESSION COEFFICENTS
## 
##                Est    SE     LL     UL
## (Intercept) 43.741 9.594  8.172 79.310
## Pred1        0.538 1.415 -4.708  5.784
## Pred2        3.792 1.586 -2.087  9.671
```

#### Plot of the Confidence Intervals for the Regression Coefficients


```r
plotRegression(Outcome~Pred1+Pred2)
```

![](figures/Regression-Coefficients-1.png)<!-- -->

```r
plotRegression(Outcome~Pred1+Pred2,conf.level=.99)
```

![](figures/Regression-Coefficients-2.png)<!-- -->

#### Significance Tests for the Regression Coefficients


```r
testRegression(Outcome~Pred1+Pred2)
```

```
## 
## HYPOTHESIS TESTS FOR THE REGRESSION COEFFICIENTS
## 
##                Est    SE     t     p
## (Intercept) 43.741 9.594 4.559 0.004
## Pred1        0.538 1.415 0.380 0.717
## Pred2        3.792 1.586 2.391 0.054
```
