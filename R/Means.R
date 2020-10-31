# Estimation Approach to Statistical Inference
## Functions for Means

### Confidence Interval Functions 

ciMeans <- function(x,...) 
  UseMethod("ciMeans")

ciMeans.default <- function(...,conf.level=.95){
  data <- data.frame(...)
  results <- data.frame(matrix(ncol=6,nrow=0))
  for (i in 1:ncol(data)) results[i,] <- ci(data[,i],conf.level=conf.level)
  colnames(results) <- c("N","M","SD","SE","LL","UL")
  rownames(results) <- colnames(data)
  return(results)
}

ciMeans.formula <- function(formula,...) {
  results <- aggregate(formula,FUN=ci,...)
  rn <- results[,1]
  results <- results[[2]]
  rownames(results) <- rn
  return(results)
}

### Null Hypothesis Significance Test Functions

nhstMeans <- function(x,...) 
  UseMethod("nhstMeans")

nhstMeans.default <- function(...,mu=0){
  data <- data.frame(...)
  results <- data.frame(matrix(ncol=5,nrow=0))
  for (i in 1:ncol(data)) results[i,] <- nhst(data[,i],mu=mu)
  colnames(results) <- c("Diff","SE","t","df","p")
  rownames(results) <- colnames(data)
  results
}

nhstMeans.formula <- function(formula,...) {
  results <- aggregate(formula,FUN=nhst,...)
  rn <- results[,1]
  results <- results[[2]]
  rownames(results) <- rn
  results
}

### Confidence Interval Plot Functions

cipMeans <- function(x,...) 
  UseMethod("cipMeans")

cipMeans.default <- function(...,conf.level=.95,mu=NULL){
  main <- "Confidence Intervals for the Means"
  ylab <- "Outcome"
  xlab <- "Variables"
  results <- ciMeans(...,conf.level=conf.level)[,c(2,5,6)]
  .ciPlot(results,main,ylab,xlab,mu)
}

cipMeans.formula <- function(formula,mu=NULL,...){
  main <- "Confidence Intervals for the Means"
  ylab <- all.vars(formula)[1]
  xlab <- all.vars(formula)[2]
  results <- ciMeans(formula,...)[,c(2,5,6)]
  x <- eval(formula[[3]])
  y <- eval(formula[[2]])
  row.names(results) <- levels(x)
  .ciPlot(results,main,ylab,xlab,mu)
}
