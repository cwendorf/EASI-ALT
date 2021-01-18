# Estimation Approach to Statistical Inference
## Functions for Mean Differences

### Confidence Interval Functions 

.ciDifference <- function(x,...) 
  UseMethod(".ciDifference")

.ciDifference.default <- function(x,y,conf.level=.95,...){
  model <- t.test(x,y,paired=TRUE,...)
  MD <- as.numeric(model$estimate)
  SE <- as.numeric(model$stderr)
  df <- as.numeric(model$parameter)
  LL <- model$conf.int[1]
  UL <- model$conf.int[2]
  results <- round(data.frame(Diff=MD,SE=SE,df=df,LL=LL,UL=UL),3)
  rownames(results) <- c("Comparison")
  results
}

.ciDifference.formula <- function(formula,conf.level=.95,...){
  model <- t.test(formula,...)
  MD <- as.numeric(model$estimate[1]-model$estimate[2])
  SE <- as.numeric(model$stderr)
  df <- as.numeric(model$parameter)
  LL <- model$conf.int[1]
  UL <- model$conf.int[2]
  results <- round(data.frame(Diff=MD,SE=SE,df=df,LL=LL,UL=UL),3)
  rownames(results) <- c("Comparison")  
  results
}

### Null Hypothesis Significance Test Functions

.nhstDifference <- function(x,...) 
  UseMethod(".nhstDifference")

.nhstDifference.default <- function(x,y,...){
  model <- t.test(x,y,paired=TRUE,...)
  mu <- as.numeric(model$null.value) 
  MD <- as.numeric(model$estimate)
  SE <- as.numeric(model$stderr)
  t <- as.numeric(model$statistic)
  df <- as.numeric(model$parameter)
  p <- as.numeric(model$p.value)
  results <- round(data.frame(Diff=MD,SE=SE,t=t,df=df,p=p),3)
  rownames(results) <- c("Comparison")  
  results
}

.nhstDifference.formula <- function(formula,...){
  model <- t.test(formula,...)
  mu <- as.numeric(model$null.value)
  MD <- as.numeric(model$estimate[1]-model$estimate[2]-mu)
  SE <- as.numeric(model$stderr)
  t <- as.numeric(model$statistic)
  df <- as.numeric(model$parameter)
  p <- as.numeric(model$p.value)
  results <- round(data.frame(Diff=MD,SE=SE,t=t,df=df,p=p),3)
  rownames(results) <- c("Comparison")  
  results
}

### Confidence Interval Plot Functions

.cipDifference <- function(x,...) 
  UseMethod(".cipDifference")

.cipDifference.default <- function(...){
  main <- "Confidence Intervals for the Comparison"
  ylab <- "Outcome"
  xlab <- ""
  Vars <- .ciMeans(...)[2:1,c(2,5,6)]
  Diff <- .ciDifference(...)[1,c(1,4,5)]
  colnames(Diff)=c("M","LL","UL")  
  results <- rbind(Vars,Diff)
  Diff <- Diff+Vars[1,1]  
  graph <- rbind(Vars,Diff)
  rownames(graph)[3] <- "Comparison"
  .diffPlot(results,graph,main,ylab,xlab)
}

.cipDifference.formula <- function(formula,...){
  main <- "Confidence Intervals for the Comparison"
  ylab <- all.vars(formula)[1]
  xlab <- ""
  Groups <- .ciMeans(formula,...)[2:1,c(2,5,6)]
  Diff <- .ciDifference(formula,...)[1,c(1,4,5)]
  colnames(Diff)=c("M","LL","UL")
  results <- rbind(Groups,Diff)
  Diff <- Diff+Groups[1]
  graph <- rbind(Groups,Diff)
  .diffPlot(results,graph,main,ylab,xlab)
}
