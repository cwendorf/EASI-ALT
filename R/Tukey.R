# Estimation Approach to Statistical Inference
## Pairwise Tukey Comparison Functions

### Confidence Interval Functions 

ciHSD <- function(formula,conf.level=.95,...){
  model=aov(formula,...)
  results=round(TukeyHSD(model,conf.level=conf.level)[[1]][,1:3],3)
  return(results)
}

### Null Hypothesis Significance Test Functions

nhstHSD <- function(formula,conf.level=.95,...){
  model=aov(formula,...)
  results=round(TukeyHSD(model,conf.level=conf.level)[[1]][,c(1,4)],3)
  return(results)
}

