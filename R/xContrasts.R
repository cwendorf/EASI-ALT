# Estimation Approach to Statistical Inference
## Functions for Sets of Linear Contrasts

### Confidence Interval Functions 

ciContrasts <- function(x,...) 
  UseMethod("ciContrasts")

ciContrasts.default <- function(...,contrasts=contr.sum,conf.level=.95){
  data <- data.frame(...)
  columns <- dim(data)[2]
  dataLong <- reshape(data,varying=1:columns,v.names="Outcome",timevar="Variable",idvar="Subjects",direction="long")
  dataLong$Subjects <- as.factor(dataLong$Subjects)
  dataLong$Variable <- as.factor(dataLong$Variable)
  vlevels <- nlevels(dataLong$Variable)
  contrasts(dataLong$Variable) <- contrasts
  contrasts(dataLong$Subjects) <- contr.sum
  model <- aov(Outcome~Variable+Error(Subjects),data=dataLong)
  first <- summary(lm(model))[[4]][1:vlevels,1:2]
  second <- confint(lm(model),level=conf.level)[1:vlevels,1:2]
  results <- round(cbind(first,second),3)
  colnames(results) <- c("Est","SE","LL","UL")
  results
}

ciContrasts.formula <- function(formula,contrasts=contr.sum,conf.level=.95,...){
  x <- eval(formula[[3]])
  y <- eval(formula[[2]])
  contrasts(x) <- contrasts
  model <- lm(y~x,...)
  results <- round(cbind(summary(model)[[4]][,1:2],confint(model,level=conf.level)),3)
  colnames(results) <- c("Est","SE","LL","UL")
  results
}
 
### Null Hypothesis Significance Test Functions

nhstContrasts <- function(x,...) 
  UseMethod("nhstContrasts")

nhstContrasts.default <- function(...,contrasts=contr.sum){
  data <- data.frame(...)
  columns <- dim(data)[2]
  dataLong <- reshape(data,varying=1:columns,v.names="Outcome",timevar="Variable",idvar="Subjects",direction="long")
  dataLong$Subjects <- as.factor(dataLong$Subjects)
  dataLong$Variable <- as.factor(dataLong$Variable)
  vlevels <- nlevels(dataLong$Variable)
  contrasts(dataLong$Variable) <- contrasts
  contrasts(dataLong$Subjects) <- contr.sum
  model <- aov(Outcome~Variable+Error(Subjects),data=dataLong)
  first <- summary(lm(model))[[4]][1:vlevels,1:4]
  results <- round(first,3)
  colnames(results) <- c("Diff","SE","t","p")
  results
}

nhstContrasts.formula <- function(formula,contrasts=contr.sum,...){
  x <- eval(formula[[3]])
  y <- eval(formula[[2]])
  contrasts(x) <- contrasts
  model <- lm(y~x,...)
  results <- round(summary(model)[[4]][,],3)
  colnames(results) <- c("Diff","SE","t","p")
  results
}

### Confidence Interval Plot Functions

cipContrasts <- function(x,...) 
  UseMethod("cipContrasts")

cipContrasts.default <- function(...,mu=NULL) {
  main <- "Confidence Intervals for the Contrasts"
  ylab <- "Mean Difference"
  xlab <- ""
  results <- ciContrasts(...)[,c(1,3,4)]
  .ciPlot(results,main,ylab,xlab,mu)
}  

cipContrasts.formula <- function(formula,mu=NULL,...) {
  main <- "Confidence Intervals for the Contrasts"
  ylab <- "Mean Difference"
  xlab <- ""
  results <- ciContrasts(formula,...)[,c(1,3,4)]
  .ciPlot(results,main,ylab,xlab,mu)
}
