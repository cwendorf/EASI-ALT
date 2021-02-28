# Estimation Approach to Statistical Inference
## Functions for Sets of Linear Contrasts

### Confidence Interval Functions 

.ciContrasts <- function(x,...) 
  UseMethod(".ciContrasts")
  
.ciContrasts.default <- function(...,contrasts=NULL,conf.level=.95){
  data <- data.frame(...)
  columns <- dim(data)[2]
  dataLong <- reshape(data,varying=1:columns,v.names="Outcome",timevar="Variable",idvar="Subjects",direction="long")
  dataLong$Subjects <- as.factor(dataLong$Subjects)
  dataLong$Variable <- as.factor(dataLong$Variable)
  vlevels <- nlevels(dataLong$Variable)
  if(!is.null(contrasts)) {contrasts(dataLong$Variable)=contrasts}
  contrasts(dataLong$Subjects) <- contr.sum
  model <- aov(Outcome~Variable+Error(Subjects),data=dataLong)
  first <- summary(lm(model))[[4]][1:vlevels,1:2]
  second <- confint(lm(model),level=conf.level)[1:vlevels,1:2]
  df <- lm(model)$df.residual
  results <- cbind(first,df,second)
  colnames(results) <- c("Est","SE","df","LL","UL")
  round(results,3)
}

.ciContrasts.formula <- function(formula,contrasts=NULL,conf.level=.95,...){
  x <- eval(formula[[3]])
  y <- eval(formula[[2]])
  if(!is.null(contrasts)) {contrasts(x)=contrasts}
  model <- lm(y~x,...)
  results <- cbind(summary(model)[[4]][,1:2],model$df.residual,confint(model,level=conf.level))
  colnames(results) <- c("Est","SE","df","LL","UL")
  round(results,3)
}

estimateContrasts <- function(...){
  cat("\nCONFIDENCE INTERVALS FOR THE CONTRASTS\n\n")
  print(.ciContrasts(...))
  cat("\n")
}

### Null Hypothesis Significance Test Functions

.nhstContrasts <- function(x,...) 
  UseMethod(".nhstContrasts")

.nhstContrasts.default <- function(...,contrasts=contr.sum){
  data <- data.frame(...)
  columns <- dim(data)[2]
  dataLong <- reshape(data,varying=1:columns,v.names="Outcome",timevar="Variable",idvar="Subjects",direction="long")
  dataLong$Subjects <- as.factor(dataLong$Subjects)
  dataLong$Variable <- as.factor(dataLong$Variable)
  vlevels <- nlevels(dataLong$Variable)
  contrasts(dataLong$Variable) <- contrasts
  contrasts(dataLong$Subjects) <- contr.sum
  model <- aov(Outcome~Variable+Error(Subjects),data=dataLong)
  df <- lm(model)$df.residual
  results <- cbind(summary(lm(model))[[4]][1:vlevels,1:3],df,summary(lm(model))[[4]][1:vlevels,4])
  colnames(results) <- c("Diff","SE","t","df","p")
  round(results,3)
}

.nhstContrasts.formula <- function(formula,contrasts=contr.sum,...){
  x <- eval(formula[[3]])
  y <- eval(formula[[2]])
  contrasts(x) <- contrasts
  model <- lm(y~x,...)
  df <- lm(model)$df.residual  
  results <- cbind(summary(lm(model))[[4]][,1:3],df,summary(lm(model))[[4]][,4])
  colnames(results) <- c("Diff","SE","t","df","p")
  round(results,3)
}

testContrasts <- function(...){
  cat("\nHYPOTHESIS TESTS FOR THE CONTRASTS\n\n")
  print(.nhstContrasts(...))
  cat("\n")
}


### Confidence Interval Plot Functions

plotContrasts <- function(...) 
  UseMethod("plotContrasts")

plotContrasts.default <- function(...,mu=NULL) {
  main <- "Confidence Intervals for the Contrasts"
  ylab <- "Mean Difference"
  xlab <- ""
  results <- .ciContrasts(...)[,c(1,4,5)]
  .ciPlot(results,main,ylab,xlab,mu)
}  

plotContrasts.formula <- function(formula,mu=NULL,...) {
  main <- "Confidence Intervals for the Contrasts"
  ylab <- "Mean Difference"
  xlab <- ""
  results <- .ciContrasts(formula,...)[,c(1,4,5)]
  .ciPlot(results,main,ylab,xlab,mu)
}
