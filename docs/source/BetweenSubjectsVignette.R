# Estimation Approach to Statistical Inference
## Between Subjects Vignette

### Three Group Example Data

Group <- c(rep(1,3),rep(2,3),rep(3,3))
Outcome <- c(3,4,5,7,8,9,8,9,10)
Group <- factor(Group,levels=c(1,2,3),labels=c("Group1","Group2","Group3"))

BetweenData <- data.frame(Group,Outcome)
BetweenData

### Analyses of Multiple Groups

#### Confidence Intervals for the Means

.ciMeans(Outcome~Group)
.ciMeans(Outcome~Group,conf.level=.99)

#### Plot of the Confidence Intervals for the Means

.cipMeans(Outcome~Group)
.cipMeans(Outcome~Group,conf.level=.99,mu=5)

#### Significance Tests for the Means

.nhstMeans(Outcome~Group)
.nhstMeans(Outcome~Group,mu=5)

### Analyses of a Group Comparison

#### Confidence Interval for a Mean Difference

Comparison=factor(Group,c("Group1","Group2"))
.ciDifference(Outcome~Comparison)
.ciDifference(Outcome~Comparison,conf.level=.99)
Comparison=factor(Group,c("Group3","Group1"))
.ciDifference(Outcome~Comparison)

#### Plot of the Confidence Interval for the Mean Difference

Comparison=factor(Group,c("Group1","Group2"))
.cipDifference(Outcome~Comparison)
.cipDifference(Outcome~Comparison,conf.level=.99)

#### Significance Test of the Mean Difference

.nhstDifference(Outcome~Comparison)
.nhstDifference(Outcome~Comparison,mu=2)

### Analyses of Pairwise Comparisons

#### Confidence Intervals for the Pairwise Comparisons

.ciPairwise(Outcome~Group)
.ciPairwise(Outcome~Group,conf.level=.99)

#### Plot of the Confidence Intervals for the Pairwise Comparisons

.cipPairwise(Outcome~Group)
.cipPairwise(Outcome~Group,mu=-2,conf.level=.99)

#### Significance Tests of the Pairwise Comparisons

.nhstPairwise(Outcome~Group)
.nhstPairwise(Outcome~Group,mu=-2)

### Analyses of a Set of Contrasts

### Confidence Intervals for the Set of Contrasts

.ciContrasts(Outcome~Group,contrasts=contr.sum)
.ciContrasts(Outcome~Group,contrasts=contr.sum,conf.level=.99)

.ciContrasts(Outcome~Group,contrasts=contr.treatment)
.ciContrasts(Outcome~Group,contrasts=contr.poly)
.ciContrasts(Outcome~Group,contrasts=contr.helmert)
.ciContrasts(Outcome~Group,contrasts=contr.SAS)

#### Plot of the Confidence Intervals for the Set of Contrasts

.cipContrasts(Outcome~Group,contrasts=contr.sum)
.cipContrasts(Outcome~Group,contrasts=contr.sum,conf.level=.99)

.cipContrasts(Outcome~Group,contrasts=contr.treatment)
.cipContrasts(Outcome~Group,contrasts=contr.poly)
.cipContrasts(Outcome~Group,contrasts=contr.helmert)
.cipContrasts(Outcome~Group,contrasts=contr.SAS)

#### Significance Tests of the Set of Contrasts

.nhstContrasts(Outcome~Group,contrasts=contr.sum)
.nhstContrasts(Outcome~Group,contrasts=contr.treatment)
.nhstContrasts(Outcome~Group,contrasts=contr.poly)
.nhstContrasts(Outcome~Group,contrasts=contr.helmert)
.nhstContrasts(Outcome~Group,contrasts=contr.SAS)
