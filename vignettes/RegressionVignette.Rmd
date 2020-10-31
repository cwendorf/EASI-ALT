---
title: "Estimation Approach to Statistical Inference"
author: "Craig A. Wendorf"
date: "`r Sys.Date()`"
output: 
  rmarkdown::html_vignette:
    keep_md: TRUE
vignette: >
  %\VignetteIndexEntry{Multiple Regression Vignette}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---

```{r,include=FALSE}
#suppress the warnings and other messages from showing in the knitted file.
knitr::opts_chunk$set(fig.width=7, fig.height=5,fig.path='figures/',echo=TRUE,warning=FALSE,message=FALSE)
```

```{r,include=FALSE}
library(altEASI)
```

# Estimation Approach to Statistical Inference
## Multiple Regression Vignette

### Three Variable Example Data

```{r}
Score1 <- c(5,6,6,7,7,7,8,8,9)
Score2 <- c(6,7,8,8,7,9,7,9,9)
Outcome <- c(72,69,75,84,72,81,75,84,81)

RegressionData <- data.frame(Score1,Score2,Outcome)
RegressionData
```

### Analyses of a Regression Model

#### Overall Fit of Regression Model

```{r}
pvaRegression(Outcome~Score1+Score2)
```

#### Confidence Intervals for the Regression Coefficients

```{r}
ciRegression(Outcome~Score1+Score2)
ciRegression(Outcome~Score1+Score2,conf.level=.99)
```

#### Plot of the Confidence Intervals for the Regression Coefficients

```{r,Regression}
cipRegression(Outcome~Score1+Score2)
cipRegression(Outcome~Score1+Score2,conf.level=.99)
```

#### Significance Tests for the Regression Coefficients

```{r}
nhstRegression(Outcome~Score1+Score2)
```
