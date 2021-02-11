---
title: "Estimation Approach to Statistical Inference"
author: "Craig A. Wendorf"
date: "2021-02-11"
output: 
  rmarkdown::html_vignette:
    keep_md: TRUE
vignette: >
  %\VignetteIndexEntry{Between Subjects Vignette}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---





# Estimation Approach to Statistical Inference
## Between Subjects Vignette

### Data Management

#### Data Entry


```r
Group <- c(rep(1,3),rep(2,3),rep(3,3))
Outcome <- c(3,4,5,7,8,9,8,9,10)
Group <- factor(Group,levels=c(1,2,3),labels=c("Group1","Group2","Group3"))
BetweenData <- data.frame(Group,Outcome)
```

#### Inspect Data


```r
BetweenData
```

```
##    Group Outcome
## 1 Group1       3
## 2 Group1       4
## 3 Group1       5
## 4 Group2       7
## 5 Group2       8
## 6 Group2       9
## 7 Group3       8
## 8 Group3       9
## 9 Group3      10
```

```r
plotData(Outcome~Group)
```

![](figures/Between-Data-1.png)<!-- -->

#### Descriptive Statistics


```r
describeMeans(Outcome~Group)
```

```
## 
## DESCRIPTIVE STATISTICS FOR THE DATA
## 
##        N M SD
## Group1 3 4  1
## Group2 3 8  1
## Group3 3 9  1
```

### Analyses of a Model

#### Describe a Model


```r
describeModel(Outcome~Group)
```

```
## 
## SOURCE TABLE FOR THE MODEL
## 
##           SS df MS
## Group     42  2 21
## Residuals  6  6  1
```

#### Overall Fit of a Model


```r
fitModel(Outcome~Group)
```

```
## 
## PROPORTION OF VARIANCE ACCOUNTED FOR BY THE MODEL
## 
##           R    R2 AdjR2
## Model 0.935 0.875 0.833
```

#### Significance Test of a Model


```r
testModel(Outcome~Group)
```

```
## 
## HYPOTHESIS TEST FOR THE MODEL
## 
##        F df1 df2     p
## Model 21   2   6 0.002
```

### Analyses of the Group Means

#### Confidence Intervals for the Means


```r
estimateMeans(Outcome~Group)
```

```
## 
## CONFIDENCE INTERVALS FOR THE MEANS
## 
##        M    SE df    LL     UL
## Group1 4 0.577  6 2.587  5.413
## Group2 8 0.577  6 6.587  9.413
## Group3 9 0.577  6 7.587 10.413
```

```r
estimateMeans(Outcome~Group,conf.level=.99)
```

```
## 
## CONFIDENCE INTERVALS FOR THE MEANS
## 
##        M    SE df   LL    UL
## Group1 4 0.577  6 1.86  6.14
## Group2 8 0.577  6 5.86 10.14
## Group3 9 0.577  6 6.86 11.14
```

#### Plot of the Confidence Intervals for the Means


```r
plotMeans(Outcome~Group)
```

![](figures/Between-Means-1.png)<!-- -->

```r
plotMeans(Outcome~Group,conf.level=.99,mu=5)
```

![](figures/Between-Means-2.png)<!-- -->

#### Significance Tests for the Means


```r
testMeans(Outcome~Group)
```

```
## 
## HYPOTHESIS TESTS FOR THE MEANS
## 
##        Diff    SE df      t p
## Group1    4 0.577  6  6.928 0
## Group2    8 0.577  6 13.856 0
## Group3    9 0.577  6 15.588 0
```

```r
testMeans(Outcome~Group,mu=5)
```

```
## 
## HYPOTHESIS TESTS FOR THE MEANS
## 
##        Diff    SE df      t     p
## Group1   -1 0.577  6 -1.732 0.134
## Group2    3 0.577  6  5.196 0.002
## Group3    4 0.577  6  6.928 0.000
```

### Analyses of a Group Comparison

#### Confidence Interval for a Mean Difference


```r
Comparison=factor(Group,c("Group1","Group2"))
estimateDifference(Outcome~Comparison)
```

```
## 
## CONFIDENCE INTERVAL FOR THE COMPARISON
## 
##            Diff    SE df     LL     UL
## Comparison   -4 0.816  4 -6.267 -1.733
```

```r
estimateDifference(Outcome~Comparison,conf.level=.99)
```

```
## 
## CONFIDENCE INTERVAL FOR THE COMPARISON
## 
##            Diff    SE df     LL     UL
## Comparison   -4 0.816  4 -6.267 -1.733
```

```r
Comparison=factor(Group,c("Group3","Group1"))
estimateDifference(Outcome~Comparison)
```

```
## 
## CONFIDENCE INTERVAL FOR THE COMPARISON
## 
##            Diff    SE df    LL    UL
## Comparison    5 0.816  4 2.733 7.267
```

#### Plot of the Confidence Interval for the Mean Difference


```r
Comparison=factor(Group,c("Group1","Group2"))
plotDifference(Outcome~Comparison)
```

![](figures/Between-Difference-1.png)<!-- -->

```r
plotDifference(Outcome~Comparison,conf.level=.99)
```

![](figures/Between-Difference-2.png)<!-- -->

#### Significance Test of the Mean Difference


```r
testDifference(Outcome~Comparison)
```

```
## 
## HYPOTHESIS TEST FOR THE COMPARISON
## 
##            Diff    SE      t df     p
## Comparison   -4 0.816 -4.899  4 0.008
```

```r
testDifference(Outcome~Comparison,mu=2)
```

```
## 
## HYPOTHESIS TEST FOR THE COMPARISON
## 
##            Diff    SE      t df     p
## Comparison   -6 0.816 -7.348  4 0.002
```

### Analyses of Pairwise Comparisons

#### Confidence Intervals for the Pairwise Comparisons


```r
estimatePairwise(Outcome~Group)
```

```
## 
## CONFIDENCE INTERVALS FOR THE PAIRWISE COMPARISONS
## 
##                 Diff    SE df     LL     UL
## Group1 v Group2   -4 0.816  4 -6.267 -1.733
## Group1 v Group3   -5 0.816  4 -7.267 -2.733
## Group2 v Group3   -1 0.816  4 -3.267  1.267
```

```r
estimatePairwise(Outcome~Group,conf.level=.99)
```

```
## 
## CONFIDENCE INTERVALS FOR THE PAIRWISE COMPARISONS
## 
##                 Diff    SE df     LL     UL
## Group1 v Group2   -4 0.816  4 -7.759 -0.241
## Group1 v Group3   -5 0.816  4 -8.759 -1.241
## Group2 v Group3   -1 0.816  4 -4.759  2.759
```

#### Plot of the Confidence Intervals for the Pairwise Comparisons


```r
plotPairwise(Outcome~Group)
```

![](figures/Between-Pairwise-1.png)<!-- -->

```r
plotPairwise(Outcome~Group,mu=-2,conf.level=.99)
```

![](figures/Between-Pairwise-2.png)<!-- -->

#### Significance Tests of the Pairwise Comparisons


```r
testPairwise(Outcome~Group)
```

```
## 
## HYPOTHESIS TESTS FOR THE PAIRWISE COMPARISONS
## 
##                 Diff    SE      t df     p
## Group1 v Group2   -4 0.816 -4.899  4 0.008
## Group1 v Group3   -5 0.816 -6.124  4 0.004
## Group2 v Group3   -1 0.816 -1.225  4 0.288
```

```r
testPairwise(Outcome~Group,mu=-2)
```

```
## 
## HYPOTHESIS TESTS FOR THE PAIRWISE COMPARISONS
## 
##                 Diff    SE      t df     p
## Group1 v Group2   -2 0.816 -2.449  4 0.070
## Group1 v Group3   -3 0.816 -3.674  4 0.021
## Group2 v Group3    1 0.816  1.225  4 0.288
```

### Analyses of a Set of Contrasts

#### Confidence Intervals for the Set of Contrasts


```r
estimateContrasts(Outcome~Group,contrasts=contr.sum)
```

```
## 
## CONFIDENCE INTERVALS FOR THE CONTRASTS
## 
##             Est    SE     LL     UL
## (Intercept)   7 0.333  6.184  7.816
## x1           -3 0.471 -4.153 -1.847
## x2            1 0.471 -0.153  2.153
```

```r
estimateContrasts(Outcome~Group,contrasts=contr.sum,conf.level=.99)
```

```
## 
## CONFIDENCE INTERVALS FOR THE CONTRASTS
## 
##             Est    SE     LL     UL
## (Intercept)   7 0.333  5.764  8.236
## x1           -3 0.471 -4.748 -1.252
## x2            1 0.471 -0.748  2.748
```

```r
estimateContrasts(Outcome~Group,contrasts=contr.treatment)
```

```
## 
## CONFIDENCE INTERVALS FOR THE CONTRASTS
## 
##             Est    SE    LL    UL
## (Intercept)   4 0.577 2.587 5.413
## x2            4 0.816 2.002 5.998
## x3            5 0.816 3.002 6.998
```

```r
estimateContrasts(Outcome~Group,contrasts=contr.poly)
```

```
## 
## CONFIDENCE INTERVALS FOR THE CONTRASTS
## 
##                Est    SE     LL    UL
## (Intercept)  7.000 0.333  6.184 7.816
## x.L          3.536 0.577  2.123 4.948
## x.Q         -1.225 0.577 -2.637 0.188
```

```r
estimateContrasts(Outcome~Group,contrasts=contr.helmert)
```

```
## 
## CONFIDENCE INTERVALS FOR THE CONTRASTS
## 
##             Est    SE    LL    UL
## (Intercept)   7 0.333 6.184 7.816
## x1            2 0.408 1.001 2.999
## x2            1 0.236 0.423 1.577
```

```r
estimateContrasts(Outcome~Group,contrasts=contr.SAS)
```

```
## 
## CONFIDENCE INTERVALS FOR THE CONTRASTS
## 
##             Est    SE     LL     UL
## (Intercept)   9 0.577  7.587 10.413
## x1           -5 0.816 -6.998 -3.002
## x2           -1 0.816 -2.998  0.998
```

#### Plot of the Confidence Intervals for the Set of Contrasts


```r
plotContrasts(Outcome~Group,contrasts=contr.sum)
```

![](figures/Between-Contrasts-1.png)<!-- -->

```r
plotContrasts(Outcome~Group,contrasts=contr.sum,conf.level=.99)
```

![](figures/Between-Contrasts-2.png)<!-- -->

```r
plotContrasts(Outcome~Group,contrasts=contr.treatment)
```

![](figures/Between-Contrasts-3.png)<!-- -->

```r
plotContrasts(Outcome~Group,contrasts=contr.poly)
```

![](figures/Between-Contrasts-4.png)<!-- -->

```r
plotContrasts(Outcome~Group,contrasts=contr.helmert)
```

![](figures/Between-Contrasts-5.png)<!-- -->

```r
plotContrasts(Outcome~Group,contrasts=contr.SAS)
```

![](figures/Between-Contrasts-6.png)<!-- -->

#### Significance Tests of the Set of Contrasts


```r
testContrasts(Outcome~Group,contrasts=contr.sum)
```

```
## 
## HYPOTHESIS TESTS FOR THE CONTRASTS
## 
##             Diff    SE      t     p
## (Intercept)    7 0.333 21.000 0.000
## x1            -3 0.471 -6.364 0.001
## x2             1 0.471  2.121 0.078
```

```r
testContrasts(Outcome~Group,contrasts=contr.treatment)
```

```
## 
## HYPOTHESIS TESTS FOR THE CONTRASTS
## 
##             Diff    SE     t     p
## (Intercept)    4 0.577 6.928 0.000
## x2             4 0.816 4.899 0.003
## x3             5 0.816 6.124 0.001
```

```r
testContrasts(Outcome~Group,contrasts=contr.poly)
```

```
## 
## HYPOTHESIS TESTS FOR THE CONTRASTS
## 
##               Diff    SE      t     p
## (Intercept)  7.000 0.333 21.000 0.000
## x.L          3.536 0.577  6.124 0.001
## x.Q         -1.225 0.577 -2.121 0.078
```

```r
testContrasts(Outcome~Group,contrasts=contr.helmert)
```

```
## 
## HYPOTHESIS TESTS FOR THE CONTRASTS
## 
##             Diff    SE      t     p
## (Intercept)    7 0.333 21.000 0.000
## x1             2 0.408  4.899 0.003
## x2             1 0.236  4.243 0.005
```

```r
testContrasts(Outcome~Group,contrasts=contr.SAS)
```

```
## 
## HYPOTHESIS TESTS FOR THE CONTRASTS
## 
##             Diff    SE      t     p
## (Intercept)    9 0.577 15.588 0.000
## x1            -5 0.816 -6.124 0.001
## x2            -1 0.816 -1.225 0.267
```
