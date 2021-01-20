# Estimation Approach to Statistical Inference
## Within Subjects Vignette

### Data Management

#### Data Entry

Time1 <- c(5,6,6,7,8)
Time2 <- c(7,7,8,8,9)
Time3 <- c(8,8,9,9,9)
WithinData <- data.frame(Time1,Time2,Time3)
WithinData

#### Descriptive Statistics

describeMeans(Time1,Time2,Time3)

### Analyses of a Model

#### Overall Fit of a Model

effectModel(Time1,Time2,Time3)

#### Significance Test of a Model

testModel(Time1,Time2,Time3)

### Analyses of the Variable Means

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

### Analyses of Pairwise Comparisons

#### Confidence Intervals for the Pairwise Comparisons

estimatePairwise(Time1,Time2,Time3)
estimatePairwise(Time1,Time2,Time3,conf.level=.99)

#### Plot of the Confidence Intervals for the Pairwise Comparisons

plotPairwise(Time1,Time2,Time3)
plotPairwise(Time1,Time2,Time3,mu=-2,conf.level=.99)

#### Significance Tests of the Pairwise Comparisons

testPairwise(Time1,Time2,Time3)
testPairwise(Time1,Time2,Time3,mu=-2)

### Analyses of a Set of Contrasts

### Confidence Intervals for the Set of Contrasts

estimateContrasts(Time1,Time2,Time3,contrasts=contr.sum)
estimateContrasts(Time1,Time2,Time3,contrasts=contr.sum,conf.level=.99)

estimateContrasts(Time1,Time2,Time3,contrasts=contr.treatment)
estimateContrasts(Time1,Time2,Time3,contrasts=contr.poly)
estimateContrasts(Time1,Time2,Time3,contrasts=contr.helmert)
estimateContrasts(Time1,Time2,Time3,contrasts=contr.SAS)

#### Plot of the Confidence Intervals for the Set of Contrasts

plotContrasts(Time1,Time2,Time3,contrasts=contr.sum)
plotContrasts(Time1,Time2,Time3,contrasts=contr.sum,conf.level=.99)

plotContrasts(Time1,Time2,Time3,contrasts=contr.treatment)
plotContrasts(Time1,Time2,Time3,contrasts=contr.poly)
plotContrasts(Time1,Time2,Time3,contrasts=contr.helmert)
plotContrasts(Time1,Time2,Time3,contrasts=contr.SAS)

#### Significance Tests of the Set of Contrasts

testContrasts(Time1,Time2,Time3,contrasts=contr.sum)
testContrasts(Time1,Time2,Time3,contrasts=contr.treatment)
testContrasts(Time1,Time2,Time3,contrasts=contr.poly)
testContrasts(Time1,Time2,Time3,contrasts=contr.helmert)
testContrasts(Time1,Time2,Time3,contrasts=contr.SAS)
