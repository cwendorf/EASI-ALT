# Estimation Approach to Statistical Inference
## Multiple Regression Functions

### Proportion of Variance Accounted For Functions

.pvaRegression <- function(x,...) 
  UseMethod(".pvaRegression")

.pvaRegression.formula <- function(formula,...) {
  model <- lm(formula)
  summ <- summary(model)
  adjr2 <- summ$adj.r.squared
  r2 <- summ$r.squared
  r <- sqrt(r2)
  results <- cbind(r,r2,adjr2)
  colnames(results) <- c("R","R2","AdjR2")
  rownames(results)="Model"
  round(results,3)
}

effectRegression <- function(...){
  cat("\nPROPORTION OF VARIANCE ACCOUNTED FOR\n\n")
  print(.pvaRegression(...))
  cat("\n")
}

### Confidence Interval Functions

.ciRegression <- function(x,...) 
  UseMethod(".ciRegression")

.ciRegression.formula <- function(formula,conf.level=.95,...) {
  model <- lm(formula)
  summ <- summary(model)
  desc <- summ$coef[,c(1,2)]
  ci <- confint(model,level=conf.level)
  results <- cbind(desc,ci)
  colnames(results) <- c("Est","SE","LL","UL")
  round(results,3)
}

estimateRegression <- function(...){
  cat("\nCONFIDENCE INTERVALS FOR THE REGRESSION COEFFICENTS\n\n")
  print(.ciRegression(...))
  cat("\n")
}

### Null Hypothesis Signifcance Test Functions

.nhstRegression <- function(x,...) 
  UseMethod(".nhstRegression")

.nhstRegression.formula <- function(formula,...) {
  model <- lm(formula)
  summ <- summary(model)
  results <- summ$coef
  colnames(results)=c("Est","SE","t","p")
  round(results,3)
}

testRegression <- function(...){
  cat("\nHYPOTHESIS TESTS FOR THE REGRESSION COEFFICIENTS\n\n")
  print(.nhstRegression(...))
  cat("\n")
}

### Confidence Interval Plot Functions

plotRegression <- function(...) 
  UseMethod("plotRegression")

plotRegression.formula <- function(formula,mu=NULL,conf.level=.95,...) {
  main <- "Regression Coefficients"
  ylab <- "Unstandardized Coefficient"
  xlab <- ""
  results <- .ciRegression(formula,conf.level=conf.level,...)[,c(1,3,4)]
  .ciPlot(results,main,ylab,xlab,mu)
}
