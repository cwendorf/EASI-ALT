# Estimation Approach to Statistical Inference
## Within Subjects Vignette

### Data Management

#### Data Entry

Outcome1 <- c(0,0,3,5)
Outcome2 <- c(4,7,4,9)
Outcome3 <- c(9,6,4,9)
RepeatedData <- data.frame(Outcome1,Outcome2,Outcome3)

### Inspect Data

RepeatedData
plotBoxes(Outcome1,Outcome2,Outcome3)
addData(Outcome1,Outcome2,Outcome3)

#### Descriptive Statistics

describeMeans(Outcome1,Outcome2,Outcome3)

### Analyses of a Model

#### Describe a Model

describeModel(Outcome1,Outcome2,Outcome3)

#### Overall Fit of a Model

fitModel(Outcome1,Outcome2,Outcome3)

#### Significance Test of a Model

testModel(Outcome1,Outcome2,Outcome3)

### Analyses of the Variable Means

#### Confidence Intervals for the Means

estimateMeans(Outcome1,Outcome2,Outcome3)
estimateMeans(Outcome1,Outcome2,Outcome3,conf.level=.99)

#### Plots of Confidence Intervals for the Means

plotMeans(Outcome1,Outcome2,Outcome3)
plotMeans(Outcome1,Outcome2,Outcome3,conf.level=.99,mu=5)

#### Significance Tests for the Means

testMeans(Outcome1,Outcome2,Outcome3)
testMeans(Outcome1,Outcome2,Outcome3,mu=5)

### Analyses of a Variable Comparison

#### Confidence Interval for the Mean Difference

estimateDifference(Outcome1,Outcome2)
estimateDifference(Outcome1,Outcome2,conf.level=.99)
estimateDifference(Outcome3,Outcome1)

#### Plots of Confidence Intervals for the Mean Difference

plotDifference(Outcome1,Outcome2)
plotDifference(Outcome1,Outcome2,conf.level=.99)

#### Significance Test for the Mean Difference

testDifference(Outcome1,Outcome2)
testDifference(Outcome1,Outcome2,mu=-2)

### Analyses of Pairwise Comparisons

#### Confidence Intervals for the Pairwise Comparisons

estimatePairwise(Outcome1,Outcome2,Outcome3)
estimatePairwise(Outcome1,Outcome2,Outcome3,conf.level=.99)

#### Plot of the Confidence Intervals for the Pairwise Comparisons

plotPairwise(Outcome1,Outcome2,Outcome3)
plotPairwise(Outcome1,Outcome2,Outcome3,mu=-2,conf.level=.99)

#### Significance Tests of the Pairwise Comparisons

testPairwise(Outcome1,Outcome2,Outcome3)
testPairwise(Outcome1,Outcome2,Outcome3,mu=-2)

### Analyses of a Set of Contrasts

### Confidence Intervals for the Set of Contrasts

estimateContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.sum)
estimateContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.sum,conf.level=.99)

estimateContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.treatment)
estimateContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.poly)
estimateContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.helmert)
estimateContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.SAS)

#### Plot of the Confidence Intervals for the Set of Contrasts

plotContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.sum)
plotContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.sum,conf.level=.99)

plotContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.treatment)
plotContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.poly)
plotContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.helmert)
plotContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.SAS)

#### Significance Tests of the Set of Contrasts

testContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.sum)
testContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.treatment)
testContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.poly)
testContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.helmert)
testContrasts(Outcome1,Outcome2,Outcome3,contrasts=contr.SAS)
