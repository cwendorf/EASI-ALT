# Estimation Approach to Statistical Inferenence (EASI)
## Basic Functions (Estimate, Test, and Plot)

### Three Time Period Example Data

Time1 <- c(5,6,6,7,8)
Time2 <- c(7,7,8,8,9)
Time3 <- c(8,8,9,9,9)

MyData <- data.frame(Time1,Time2,Time3)
MyData

### Analyses of Multiple Variables
### (equivalent to one-sample analyses for each level of a factor)

#### Confidence Intervals for the Means

estimateMeans(Time1,Time2,Time3)
estimateMeans(Time1,Time2,Time3,conf.level=.99)

#### Plots of Confidence Intervals for the Means

plotMeans(Time1,Time2,Time3)
plotMeans(Time1,Time2,Time3,conf.level=.99,mu=6)

#### Significance Tests for the Means

testMeans(Time1,Time2,Time3)
testMeans(Time1,Time2,Time3,mu=6)

### Analyses of a Variable Comparison
### (equivalent to analyses for two levels of a factor)

#### Confidence Interval for the Mean Difference

estimateDifference(Time1,Time2)
estimateDifference(Time1,Time2,conf.level=.99)
estimateDifference(Time3,Time1)

#### Plots of Confidence Intervals for the Mean Difference

plotDifference(Time1,Time2)
plotDifference(Time1,Time2,conf.level=.99)

#### Significance Test for the Mean Difference

testDifference(Time1,Time2)
testDifference(Time1,Time2,mu=-2)
