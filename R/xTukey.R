# Estimation Approach to Statistical Inference
## Pairwise Tukey Comparison Functions

### Confidence Interval Functions 

ciHSD <- function(x,...) 
  UseMethod("ciHSD")

ciHSD.formula <- function(formula,conf.level=.95,...){
  model=aov(formula,...)
  results=round(TukeyHSD(model,conf.level=conf.level)[[1]][,1:3],3)
  results
}

### Null Hypothesis Significance Test Functions

nhstHSD <- function(x,...) 
  UseMethod("nhstHSD")

nhstHSD.formula <- function(formula,conf.level=.95,...){
  model=aov(formula,...)
  results=round(TukeyHSD(model,conf.level=conf.level)[[1]][,c(1,4)],3)
  results
}
