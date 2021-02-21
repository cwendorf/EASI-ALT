# Estimation Approach to Statistical Inference
## Correlation Functions

### Confidence Interval Functions 

.ciCorrelation <- function(x,...) 
  UseMethod(".ciCorrelation")

.ciCorrelation.default <- function(...,conf.level=.95){
  data <- data.frame(...)
  test <- cor.test(data[,1],data[,2])
  results <- data.frame(test[4],test[2],test$conf.int[1],test$conf.int[2])
  colnames(results) <- c("Est","df","LL","UL")
  rownames(results) <- "Correlation"
  round(results,3)
}

estimateCorrelation <- function(...){
  cat("\nCONFIDENCE INTERVAL FOR THE CORRELATION\n\n")
  print(.ciCorrelation(...))
  cat("\n")
}

### Null Hypothesis Significance Test Functions

.nhstCorrelation <- function(x,...) 
  UseMethod(".nhstCorrelation")

.nhstCorrelation.default <- function(...,conf.level=.95){
  data <- data.frame(...)
  test <- cor.test(data[,1],data[,2])
  results <- data.frame(test[4],test[2],test[1],test[3])
  colnames(results) <- c("Est","df","t","p")
  rownames(results) <- "Correlation"
  round(results,3)
}

testCorrelation <- function(...){
  cat("\nHYPOTHESIS TEST FOR THE CORRELATION\n\n")
  print(.nhstCorrelation(...))
  cat("\n")
}

### Confidence Interval Plot Functions

plotCorrelation <- function(...) 
  UseMethod("plotCorrelation")

plotCorrelation.default <- function(...,conf.level=.95,mu=NULL){
  main <- "Confidence Interval for the Correlation"
  ylab <- "Correlation"
  xlab <- ""
  results <- .ciCorrelation(...,conf.level=conf.level)[,c("Est","LL","UL")]
  .ciPlot(results,main,ylab,xlab,mu)
}
