# Estimation Approach to Statistical Inference
## Omnibus Functions

### Proportion of Variance Accounted For Functions

.pvaModel <- function(x,...) 
  UseMethod(".pvaModel")

.pvaModel.default <- function(...){
  data <- data.frame(...)
  columns <- dim(data)[2]
  dataLong <- reshape(data,varying=1:columns,v.names="Outcome",timevar="Variables",idvar="Subjects",direction="long")
  dataLong$Subjects <- as.factor(dataLong$Subjects)
  dataLong$Variables <- as.factor(dataLong$Variables)
  model <- lm(Outcome~Variables+Subjects,data=dataLong)
  summ <- summary(model)
  adjr2 <- summ$adj.r.squared
  r2 <- summ$r.squared
  r <- sqrt(r2)
  results <- cbind(r,r2,adjr2)
  colnames(results) <- c("R","R2","AdjR2")
  rownames(results)="Model"
  round(results,3)
}

.pvaModel.formula <- function(formula,...) {
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

effectModel <- function(...){
  cat("\nPROPORTION OF VARIANCE ACCOUNTED FOR\n\n")
  print(.pvaModel(...))
  cat("\n")
}

### Null Hypothesis Signifcance Test Functions

.nhstModel <- function(x,...) 
  UseMethod(".nhstModel")

.nhstModel.default <- function(...){
  data <- data.frame(...)
  columns <- dim(data)[2]
  dataLong <- reshape(data,varying=1:columns,v.names="Outcome",timevar="Variables",idvar="Subjects",direction="long")
  dataLong$Subjects <- as.factor(dataLong$Subjects)
  dataLong$Variables <- as.factor(dataLong$Variables)
  model <- lm(Outcome~Variables+Subjects,data=dataLong)
  anova(model)
}

.nhstModel.formula <- function(formula,...){
  model <- lm(formula,...)
  anova(model)
}

testModel <- function(...){
  cat("\n")
  print(.nhstModel(...))
  cat("\n")
}
