# Estimation Approach to Statistical Inferenence (EASI)
## Basic Functions (Estimate, Test, and Plot)

### Three Group Example Data

Group <- c(rep(1,3),rep(2,3),rep(3,3))
Outcome <- c(3,4,5,7,8,9,8,9,10)
Group <- factor(Group,levels=c(1,2,3),labels=c("Group1","Group2","Group3"))

MyData <- data.frame(Group,Outcome)
MyData

### Analyses of Multiple Groups
### (equivalent to one-sample analyses for each level of a factor)

#### Confidence Intervals for the Means

estimateMeans(Outcome~Group)
estimateMeans(Outcome~Group,conf.level=.99)

#### Plot of the Confidence Intervals for the Means

plotMeans(Outcome~Group)
plotMeans(Outcome~Group,conf.level=.99,mu=5)

#### Significance Tests for the Means

testMeans(Outcome~Group)
testMeans(Outcome~Group,mu=5)

### Analyses of a Group Comparison
### (equivalent to analyses for two levels of a factor)

#### Confidence Interval for a Mean Difference

Comparison=factor(Group,c("Group1","Group2"))
estimateDifference(Outcome~Comparison)
estimateDifference(Outcome~Comparison,conf.level=.99)
Comparison=factor(Group,c("Group3","Group1"))
estimateDifference(Outcome~Comparison)

#### Plot of the Confidence Interval for the Mean Difference

Comparison=factor(Group,c("Group1","Group2"))
plotDifference(Outcome~Comparison)
plotDifference(Outcome~Comparison,conf.level=.99)

#### Significance Test of the Mean Difference

testDifference(Outcome~Comparison)
testDifference(Outcome~Comparison,mu=2)
