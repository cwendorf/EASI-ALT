# Estimation Approach to Statistical Inference
## Pairwise Tukey Comparison Functions

### Confidence Interval Functions 

.ciHSD <- function(x,...) 
  UseMethod(".ciHSD")

.ciHSD.formula <- function(formula,conf.level=.95,...){
  model=aov(formula,...)
  results=round(TukeyHSD(model,conf.level=conf.level)[[1]][,1:3],3)
  results
}

estimateHSD <- function(...){
  cat("\nCONFIDENCE INTERVALS FOR THE POST HOC COMPARISONS\n\n")
  print(.ciHSD(...))
  cat("\n")
}

### Null Hypothesis Significance Test Functions

.nhstHSD <- function(...) 
  UseMethod(".nhstHSD")

.nhstHSD.formula <- function(formula,conf.level=.95,...){
  model=aov(formula,...)
  results=round(TukeyHSD(model,conf.level=conf.level)[[1]][,c(1,4)],3)
  results
}

testHSD <- function(...){
  cat("\nHYPOTHESIS TESTS FOR THE POST HOC COMPARISONS\n\n")
  print(.nhstHSD(...))
  cat("\n")
}
