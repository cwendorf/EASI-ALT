# Estimation Approach to Statistical Inference
## OneWay Vignette

### Data Management

#### Data Entry

Factor <- c(rep(1,4),rep(2,4),rep(3,4))
Outcome <- c(0,0,3,5,4,7,4,9,9,6,4,9)
Factor <- factor(Factor,levels=c(1,2,3),labels=c("Level1","Level2","Level3"))
OneWayData <- data.frame(Factor,Outcome)

#### Inspect Data

OneWayData
describeBoxes(Outcome~Factor)
plotBoxes(Outcome~Factor)
addData(Outcome~Factor)

#### Descriptive Statistics

describeMeans(Outcome~Factor)

### Analyses of a Model

#### Describe a Model

describeModel(Outcome~Factor)

#### Overall Fit of a Model

fitModel(Outcome~Factor)

#### Significance Test of a Model

testModel(Outcome~Factor)

### Analyses of the Factor Means

#### Confidence Intervals for the Means

estimateMeans(Outcome~Factor)
estimateMeans(Outcome~Factor,conf.level=.99)

#### Plot of the Confidence Intervals for the Means

plotMeans(Outcome~Factor)
plotMeans(Outcome~Factor,conf.level=.99,mu=5)

#### Significance Tests for the Means

testMeans(Outcome~Factor)
testMeans(Outcome~Factor,mu=5)

### Analyses of a Factor Comparison

#### Confidence Interval for a Mean Difference

Comparison=factor(Factor,c("Level1","Level2"))
estimateDifference(Outcome~Comparison)
estimateDifference(Outcome~Comparison,conf.level=.99)
Comparison=factor(Factor,c("Level3","Level1"))
estimateDifference(Outcome~Comparison)

#### Plot of the Confidence Interval for the Mean Difference

Comparison=factor(Factor,c("Level1","Level2"))
plotDifference(Outcome~Comparison)
plotDifference(Outcome~Comparison,conf.level=.99)

#### Significance Test of the Mean Difference

testDifference(Outcome~Comparison)
testDifference(Outcome~Comparison,mu=-2)

### Analyses of Pairwise Comparisons

#### Confidence Intervals for the Pairwise Comparisons

estimatePairwise(Outcome~Factor)
estimatePairwise(Outcome~Factor,conf.level=.99)

#### Plot of the Confidence Intervals for the Pairwise Comparisons

plotPairwise(Outcome~Factor)
plotPairwise(Outcome~Factor,mu=-2,conf.level=.99)

#### Significance Tests of the Pairwise Comparisons

testPairwise(Outcome~Factor)
testPairwise(Outcome~Factor,mu=-2)

### Analyses of a Set of Contrasts

### Confidence Intervals for the Set of Contrasts

estimateContrasts(Outcome~Factor,contrasts=contr.sum)
estimateContrasts(Outcome~Factor,contrasts=contr.sum,conf.level=.99)

estimateContrasts(Outcome~Factor,contrasts=contr.treatment)
estimateContrasts(Outcome~Factor,contrasts=contr.poly)
estimateContrasts(Outcome~Factor,contrasts=contr.helmert)
estimateContrasts(Outcome~Factor,contrasts=contr.SAS)

c1=c(1,-1,0)
c2=c(1,1,-2)
estimateContrasts(Outcome~Factor,contrasts=cbind(c1,c2))

#### Plot of the Confidence Intervals for the Set of Contrasts

plotContrasts(Outcome~Factor,contrasts=contr.sum)
plotContrasts(Outcome~Factor,contrasts=contr.sum,conf.level=.99)

plotContrasts(Outcome~Factor,contrasts=contr.treatment)
plotContrasts(Outcome~Factor,contrasts=contr.poly)
plotContrasts(Outcome~Factor,contrasts=contr.helmert)
plotContrasts(Outcome~Factor,contrasts=contr.SAS)

c1=c(1,-1,0)
c2=c(1,1,-2)
plotContrasts(Outcome~Factor,contrasts=cbind(c1,c2))

#### Significance Tests of the Set of Contrasts

testContrasts(Outcome~Factor,contrasts=contr.sum)
testContrasts(Outcome~Factor,contrasts=contr.treatment)
testContrasts(Outcome~Factor,contrasts=contr.poly)
testContrasts(Outcome~Factor,contrasts=contr.helmert)
testContrasts(Outcome~Factor,contrasts=contr.SAS)

c1=c(1,-1,0)
c2=c(1,1,-2)
testContrasts(Outcome~Factor,contrasts=cbind(c1,c2))
