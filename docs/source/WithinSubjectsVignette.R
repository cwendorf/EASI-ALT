# Estimation Approach to Statistical Inference
## Within Subjects Vignette

### Three Time Period Example Data

Time1 <- c(5,6,6,7,8)
Time2 <- c(7,7,8,8,9)
Time3 <- c(8,8,9,9,9)

WithinData <- data.frame(Time1,Time2,Time3)
WithinData

### Analyses of Multiple Variables

#### Confidence Intervals for the Means

ciMeans(Time1,Time2,Time3)
ciMeans(Time1,Time2,Time3,conf.level=.99)

#### Plots of Confidence Intervals for the Means

.cipMeans(Time1,Time2,Time3)
.cipMeans(Time1,Time2,Time3,conf.level=.99,mu=6)

#### Significance Tests for the Means

.nhstMeans(Time1,Time2,Time3)
.nhstMeans(Time1,Time2,Time3,mu=6)

### Analyses of a Variable Comparison

#### Confidence Interval for the Mean Difference

.ciDifference(Time1,Time2)
.ciDifference(Time1,Time2,conf.level=.99)
.ciDifference(Time3,Time1)

#### Plots of Confidence Intervals for the Mean Difference

.cipDifference(Time1,Time2)
.cipDifference(Time1,Time2,conf.level=.99)

#### Significance Test for the Mean Difference

.nhstDifference(Time1,Time2)
.nhstDifference(Time1,Time2,mu=-2)

### Analyses of Pairwise Comparisons

#### Confidence Intervals for the Pairwise Comparisons

.ciPairwise(Time1,Time2,Time3)
.ciPairwise(Time1,Time2,Time3,conf.level=.99)

#### Plot of the Confidence Intervals for the Pairwise Comparisons

.cipPairwise(Time1,Time2,Time3)
.cipPairwise(Time1,Time2,Time3,mu=-2,conf.level=.99)

#### Significance Tests of the Pairwise Comparisons

.nhstPairwise(Time1,Time2,Time3)
.nhstPairwise(Time1,Time2,Time3,mu=-2)

### Analyses of a Set of Contrasts

### Confidence Intervals for the Set of Contrasts

.ciContrasts(Time1,Time2,Time3,contrasts=contr.sum)
.ciContrasts(Time1,Time2,Time3,contrasts=contr.sum,conf.level=.99)

.ciContrasts(Time1,Time2,Time3,contrasts=contr.treatment)
.ciContrasts(Time1,Time2,Time3,contrasts=contr.poly)
.ciContrasts(Time1,Time2,Time3,contrasts=contr.helmert)
.ciContrasts(Time1,Time2,Time3,contrasts=contr.SAS)

#### Plot of the Confidence Intervals for the Set of Contrasts

.cipContrasts(Time1,Time2,Time3,contrasts=contr.sum)
.cipContrasts(Time1,Time2,Time3,contrasts=contr.sum,conf.level=.99)

.cipContrasts(Time1,Time2,Time3,contrasts=contr.treatment)
.cipContrasts(Time1,Time2,Time3,contrasts=contr.poly)
.cipContrasts(Time1,Time2,Time3,contrasts=contr.helmert)
.cipContrasts(Time1,Time2,Time3,contrasts=contr.SAS)

#### Significance Tests of the Set of Contrasts

.nhstContrasts(Time1,Time2,Time3,contrasts=contr.sum)
.nhstContrasts(Time1,Time2,Time3,contrasts=contr.treatment)
.nhstContrasts(Time1,Time2,Time3,contrasts=contr.poly)
.nhstContrasts(Time1,Time2,Time3,contrasts=contr.helmert)
.nhstContrasts(Time1,Time2,Time3,contrasts=contr.SAS)
