# Estimation Approach to Statistical Inference
## Functions for Means

### Descriptive Functions 

.dsMeans <- function(x,...) 
  UseMethod(".dsMeans")

.dsMeans.default <- function(...){
  data <- data.frame(...)
  results <- data.frame(matrix(ncol=3,nrow=0))
  for (i in 1:ncol(data)) results[i,] <- .ds(data[,i])
  colnames(results) <- c("N","M","SD")
  rownames(results) <- colnames(data)
  results
}

.dsMeans.formula <- function(formula,...) {
  results <- aggregate(formula,FUN=.ds,...)
  rn <- results[,1]
  results <- results[[2]]
  rownames(results) <- rn
  results
}

describeMeans <- function(...){
  cat("\nDESCRIPTIVE STATISTICS FOR THE DATA\n\n")
  print(.dsMeans(...))
  cat("\n")
}

### Confidence Interval Functions 

.ciMeans <- function(x,...) 
  UseMethod(".ciMeans")

.ciMeans.default <- function(...,conf.level=.95){
  data <- data.frame(...)
  results <- data.frame(matrix(ncol=5,nrow=0))
  for (i in 1:ncol(data)) results[i,] <- .ci(data[,i],conf.level=conf.level)
  colnames(results) <- c("M","SE","df","LL","UL")
  rownames(results) <- colnames(data)
  results
}

.ciMeans.formula <- function(formula,...) {
  results <- aggregate(formula,FUN=.ci,...)
  rn <- results[,1]
  results <- results[[2]]
  rownames(results) <- rn
  results
}

estimateMeans <- function(...){
  cat("\nCONFIDENCE INTERVALS FOR THE MEANS\n\n")
  print(.ciMeans(...))
  cat("\n")
}

### Null Hypothesis Significance Test Functions

.nhstMeans <- function(x,...) 
  UseMethod(".nhstMeans")

.nhstMeans.default <- function(...,mu=0){
  data <- data.frame(...)
  results <- data.frame(matrix(ncol=5,nrow=0))
  for (i in 1:ncol(data)) results[i,] <- .nhst(data[,i],mu=mu)
  colnames(results) <- c("Diff","SE","t","df","p")
  rownames(results) <- colnames(data)
  results
}

.nhstMeans.formula <- function(formula,...) {
  results <- aggregate(formula,FUN=.nhst,...)
  rn <- results[,1]
  results <- results[[2]]
  rownames(results) <- rn
  results
}

testMeans <- function(...){
  cat("\nHYPOTHESIS TESTS FOR THE MEANS\n\n")
  print(.nhstMeans(...))
  cat("\n")
}

### Confidence Interval Plot Functions

plotMeans <- function(...) 
  UseMethod("plotMeans")

plotMeans.default <- function(...,conf.level=.95,mu=NULL){
  main <- "Confidence Intervals for the Means"
  ylab <- "Outcome"
  xlab <- ""
  results <- .ciMeans(...,conf.level=conf.level)[,c("M","LL","UL")]
  .ciPlot(results,main,ylab,xlab,mu)
}

plotMeans.formula <- function(formula,mu=NULL,...){
  main <- "Confidence Intervals for the Means"
  ylab <- all.vars(formula)[1]
  xlab <- ""
  results <- .ciMeans(formula,...)[,c("M","LL","UL")]
  x <- eval(formula[[3]])
  y <- eval(formula[[2]])
  row.names(results) <- levels(x)
  .ciPlot(results,main,ylab,xlab,mu)
}
