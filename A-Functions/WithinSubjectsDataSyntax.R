# Estimation Approach to Statistical Inferenence (EASI)
## Alternate Basic Functions (Estimate, Test, and Plot)

### Source the alt-EASI Functions

source("http://raw.githubusercontent.com/cwendorf/EASI-DEV/master/A-Functions/ALL-ALTEASI-FUNCTIONS.R")

### Three Time Period Example Data

Time1 <- c(5,6,6,7,8)
Time2 <- c(7,7,8,8,9)
Time3 <- c(8,8,9,9,9)

MyData <- data.frame(Time1,Time2,Time3)
MyData

### Analyses of Multiple Variables
### (equivalent to one-sample analyses for each level of a factor)

#### Confidence Intervals for the Means

alt.estimateMeans(Time1,Time2,Time3)
alt.estimateMeans(Time1,Time2,Time3,conf.level=.99)

#### Plots of Confidence Intervals for the Means

alt.plotMeans(Time1,Time2,Time3)
alt.plotMeans(Time1,Time2,Time3,conf.level=.99,mu=6)

#### Significance Tests for the Means

alt.testMeans(Time1,Time2,Time3)
alt.testMeans(Time1,Time2,Time3,mu=6)

### Analyses of a Variable Comparison
### (equivalent to analyses for two levels of a factor)

#### Confidence Interval for the Mean Difference

alt.estimateDifference(Time1,Time2)
alt.estimateDifference(Time1,Time2,conf.level=.99)
alt.estimateDifference(Time3,Time1)

#### Plots of Confidence Intervals for the Mean Difference

alt.plotDifference(Time1,Time2)
alt.plotDifference(Time1,Time2,conf.level=.99)

#### Significance Test for the Mean Difference

alt.testDifference(Time1,Time2)
alt.testDifference(Time1,Time2,mu=-2)
