# Estimation Approach to Statistical Inference
## Between Subjects Vignette

### Data Management

#### Data Entry

Group <- c(rep(1,3),rep(2,3),rep(3,3))
Outcome <- c(3,4,5,7,8,9,8,9,10)
Group <- factor(Group,levels=c(1,2,3),labels=c("Group1","Group2","Group3"))
BetweenData <- data.frame(Group,Outcome)

#### Inspect Data

BetweenData

plotBoxes(Outcome~Group)
addData(Outcome~Group)

#### Descriptive Statistics

describeMeans(Outcome~Group)

### Analyses of a Model

#### Describe a Model

describeModel(Outcome~Group)

#### Overall Fit of a Model

fitModel(Outcome~Group)

#### Significance Test of a Model

testModel(Outcome~Group)

### Analyses of the Group Means

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

### Analyses of Pairwise Comparisons

#### Confidence Intervals for the Pairwise Comparisons

estimatePairwise(Outcome~Group)
estimatePairwise(Outcome~Group,conf.level=.99)

#### Plot of the Confidence Intervals for the Pairwise Comparisons

plotPairwise(Outcome~Group)
plotPairwise(Outcome~Group,mu=-2,conf.level=.99)

#### Significance Tests of the Pairwise Comparisons

testPairwise(Outcome~Group)
testPairwise(Outcome~Group,mu=-2)

### Analyses of a Set of Contrasts

### Confidence Intervals for the Set of Contrasts

estimateContrasts(Outcome~Group,contrasts=contr.sum)
estimateContrasts(Outcome~Group,contrasts=contr.sum,conf.level=.99)

estimateContrasts(Outcome~Group,contrasts=contr.treatment)
estimateContrasts(Outcome~Group,contrasts=contr.poly)
estimateContrasts(Outcome~Group,contrasts=contr.helmert)
estimateContrasts(Outcome~Group,contrasts=contr.SAS)

#### Plot of the Confidence Intervals for the Set of Contrasts

plotContrasts(Outcome~Group,contrasts=contr.sum)
plotContrasts(Outcome~Group,contrasts=contr.sum,conf.level=.99)

plotContrasts(Outcome~Group,contrasts=contr.treatment)
plotContrasts(Outcome~Group,contrasts=contr.poly)
plotContrasts(Outcome~Group,contrasts=contr.helmert)
plotContrasts(Outcome~Group,contrasts=contr.SAS)

#### Significance Tests of the Set of Contrasts

testContrasts(Outcome~Group,contrasts=contr.sum)
testContrasts(Outcome~Group,contrasts=contr.treatment)
testContrasts(Outcome~Group,contrasts=contr.poly)
testContrasts(Outcome~Group,contrasts=contr.helmert)
testContrasts(Outcome~Group,contrasts=contr.SAS)
