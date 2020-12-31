# Estimation Approach to Statistical Inference
## Multiple Regression Functions

### Proportion of Variance Accounted For Functions

pvaRegression <- function(x,...) 
  UseMethod("pvaRegression")

pvaRegression.formula <- function(formula,...) {
  model <- lm(formula)
  summ <- summary(model)
  r2 <- summ$r.squared
  r <- sqrt(r2)
  results <- cbind(r,r2)
  colnames(results) <- c("R","R2")
  rownames(results)="Model"
  round(results,3)
}

### Confidence Interval Functions

ciRegression <- function(x,...) 
  UseMethod("ciRegression")

ciRegression.formula <- function(formula,conf.level=.95,...) {
  model <- lm(formula)
  summ <- summary(model)
  desc <- summ$coef[,c(1,2)]
  ci <- confint(model,level=conf.level)
  results <- cbind(desc,ci)
  colnames(results) <- c("Est","SE","LL","UL")
  round(results,3)
}

### Null Hypothesis Signifcance Test Functions

nhstRegression <- function(x,...) 
  UseMethod("nhstRegression")

nhstRegression.formula <- function(formula,...) {
  model <- lm(formula)
  summ <- summary(model)
  results <- summ$coef
  colnames(results)=c("Est","SE","t","p")
  round(results,3)
}

### Confidence Interval Plot Functions

cipRegression <- function(x,...) 
  UseMethod("cipRegression")

cipRegression.formula <- function(formula,mu=NULL,conf.level=.95,...) {
  main <- "Regression Coefficients"
  ylab <- "Unstandardized Coefficient"
  xlab <- ""
  results <- ciRegression(formula,conf.level=conf.level,...)[,c(1,3,4)]
  .ciPlot(results,main,ylab,xlab,mu)
}
