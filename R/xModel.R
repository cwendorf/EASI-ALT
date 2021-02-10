# Estimation Approach to Statistical Inference
## Omnibus/Model Functions

### Descriptive Functions

.dsModel <- function(x,...) 
  UseMethod(".dsModel")

.dsModel.default <- function(...) {
  data <- data.frame(...)
  columns <- dim(data)[2]
  dataLong <- reshape(data,varying=1:columns,v.names="Outcome",timevar="Variables",idvar="Subjects",direction="long")
  dataLong$Subjects <- as.factor(dataLong$Subjects)
  dataLong$Variables <- as.factor(dataLong$Variables)
  model <- lm(Outcome~Variables+Subjects,data=dataLong)
  x <- anova(model)
  results <- cbind(x[2],x[1],x[3])
  colnames(results) <- c("SS","df","MS")
  rownames(results) <- c("Variables","Subjects","Residual")
  round(results,3)
}

.dsModel.formula <- function(formula,...) {
  model <- lm(formula)
  x <- anova(model)
  results <- cbind(x[2],x[1],x[3])
  colnames(results) <- c("SS","df","MS")
  round(results,3)
}

describeModel <- function(...){
  cat("\nSOURCE TABLE FOR THE MODEL\n\n")
  print(.dsModel(...))
  cat("\n")
}


### Fit Functions

.fitModel <- function(x,...) 
  UseMethod(".fitModel")

.fitModel.default <- function(...) {
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

.fitModel.formula <- function(formula,...) {
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

fitModel <- function(...){
  cat("\nPROPORTION OF VARIANCE ACCOUNTED FOR BY THE MODEL\n\n")
  print(.fitModel(...))
  cat("\n")
}

### Null Hypothesis Signifcance Test Functions

.nhstModel <- function(x,...) 
  UseMethod(".nhstModel")

.nhstModel.default <- function(...) {
  data <- data.frame(...)
  columns <- dim(data)[2]
  dataLong <- reshape(data,varying=1:columns,v.names="Outcome",timevar="Variables",idvar="Subjects",direction="long")
  dataLong$Subjects <- as.factor(dataLong$Subjects)
  dataLong$Variables <- as.factor(dataLong$Variables)
  model <- lm(Outcome~Variables+Subjects,data=dataLong)
  x <- summary(model)
  F <- x[[10]][1]
  df1 <- x[[10]][2]
  df2 <- x[[10]][3]
  p <- pf(q,df1,df2,lower.tail=FALSE)
  results <- c(F,df1,df2,p)
  results <- rbind(results)
  colnames(results) <- c("F","df1","df2","p")
  rownames(results) <- "Model"
  round(results,3)
}

.nhstModel.formula <- function(formula,...) {
  model <- lm(formula,...)
  x <- summary(model)
  F <- x[[10]][1]
  df1 <- x[[10]][2]
  df2 <- x[[10]][3]
  p <- pf(q,df1,df2,lower.tail=FALSE)
  results <- c(F,df1,df2,p)
  results <- rbind(results)
  colnames(results) <- c("F","df1","df2","p")
  rownames(results) <- "Model"
  round(results,3)
}

testModel <- function(...) {
  cat("\nHYPOTHESIS TEST FOR THE MODEL\n\n")
  print(.nhstModel(...))
  cat("\n")
}
