# Estimation Approach to Statistical Inference
## Unadjusted Pairwise Comparison Functions

### Confidence Interval Functions 

.ciPairwise <- function(x,...) 
  UseMethod(".ciPairwise")

.ciPairwise.default <- function(...,conf.level=.95){
  data <- data.frame(...)
  nr <- dim(data)[2]
  rn <- colnames(data)
  ncomp <- (nr)*(nr-1)/2
  results <- data.frame(matrix(ncol=5,nrow=ncomp))
  colnames(results) <- c("Diff","SE","df","LL","UL")
  comp <- 1
  for( i in 1:(nr-1) ){
  for( j in (i+1):nr ){
    rownames(results)[comp] <- paste(rn[i],"v",rn[j])
	  varx <- get(rn[i])
	  vary <- get(rn[j])
	  model <- t.test(varx,vary,paired=TRUE,conf.level=conf.level)
	  MD <- as.numeric(model$estimate)
	  SE <- as.numeric(model$stderr)
	  df <- as.numeric(model$parameter)
	  LL <- model$conf.int[1]
	  UL <- model$conf.int[2]
    results[comp,] <- c(MD,SE,df,LL,UL)
  	comp <-comp+1
  }
  }
  round(results,3)
}

.ciPairwise.formula <- function(formula,...){
  varx <- eval(formula[[3]])
  vary <- eval(formula[[2]])
  nr <- nlevels(varx)
  rn <- levels(varx)
  ncomp <- (nr)*(nr-1)/2
  results <- data.frame(matrix(ncol=5,nrow=ncomp))
  colnames(results) <- c("Diff","SE","df","LL","UL")
  comp <- 1
  for( i in 1:(nr-1) ){
  for( j in (i+1):nr ){
    rownames(results)[comp] <- paste(rn[i],"v",rn[j])
	  Comparison <- factor(varx,c(rn[i],rn[j]))
	  model <- t.test(vary~Comparison,...)
    MD <- as.numeric(model$estimate)[1]-as.numeric(model$estimate)[2]
    SE <- as.numeric(model$stderr)
    df <- as.numeric(model$parameter)
    LL <- model$conf.int[1]
    UL <- model$conf.int[2]
    results[comp,] <- c(MD,SE,df,LL,UL)
	comp <- comp+1
  }
  }
  round(results,3)
}

estimatePairwise <- function(...){
  cat("\nCONFIDENCE INTERVALS FOR THE PAIRWISE COMPARISONS\n\n")
  print(.ciPairwise(...))
  cat("\n")
}
### Null Hypothesis Significance Test Functions

.nhstPairwise <- function(x,...) 
  UseMethod(".nhstPairwise")

.nhstPairwise.default <- function(...,conf.level=.95,mu=0){
  data <- data.frame(...)
  nr <- dim(data)[2]
  rn <- colnames(data)
  ncomp <- (nr)*(nr-1)/2
  results <- data.frame(matrix(ncol=5,nrow=ncomp))
  colnames(results) <- c("Diff","SE","t","df","p")
  comp <- 1
  for( i in 1:(nr-1) ){
  for( j in (i+1):nr ){
    rownames(results)[comp] <- paste(rn[i],"v",rn[j])
	  varx <- get(rn[i])
	  vary <- get(rn[j])
	  model <- t.test(varx,vary,paired=TRUE,conf.level=conf.level,mu=mu)
	  MD <- as.numeric(model$estimate)
	  SE <- as.numeric(model$stderr)
	  t <- as.numeric(model$statistic)
	  df <- as.numeric(model$parameter)
	  p <- as.numeric(model$p.value)
    results[comp,] <- c(MD,SE,t,df,p)
  	comp <- comp+1
  }
  }
  round(results,3)
}

.nhstPairwise.formula <- function(formula,...){
  varx <- eval(formula[[3]])
  vary <- eval(formula[[2]])
  nr <- nlevels(varx)
  rn <- levels(varx)
  ncomp <- (nr)*(nr-1)/2
  results <- data.frame(matrix(ncol=5,nrow=ncomp))
  colnames(results) <- c("Diff","SE","t","df","p")
  comp <- 1
  for( i in 1:(nr-1) ){
  for( j in (i+1):nr ){
    rownames(results)[comp] <- paste(rn[i],"v",rn[j])
	  Comparison <- factor(varx,c(rn[i],rn[j]))
	  model <- t.test(vary~Comparison,...)
	  mu <- as.numeric(model$null.value)
	  MD <- as.numeric(model$estimate[1]-model$estimate[2]-mu)		
    SE <- as.numeric(model$stderr)
	  t <- as.numeric(model$statistic)
	  df <- as.numeric(model$parameter)
	  p <- as.numeric(model$p.value)
    results[comp,] <- c(MD,SE,t,df,p)
	  comp <- comp+1
  }
  }
  round(results,3)
}

testPairwise <- function(...){
  cat("\nHYPOTHESIS TESTS FOR THE PAIRWISE COMPARISONS\n\n")
  print(.nhstPairwise(...))
  cat("\n")
}

### Confidence Interval Plot Functions

plotPairwise <- function(x,...) 
  UseMethod("plotPairwise")

plotPairwise.default <- function(...,mu=NULL) {
  main <- "Confidence Intervals for the Pairwise Comparisons"
  ylab <- "Mean Difference"
  xlab <- ""
  results <- .ciPairwise(...)[,c(1,4,5)]
  .ciPlot(results,main,ylab,xlab,mu)
} 

plotPairwise.formula <- function(formula,conf.level=.95,mu=NA,...) {
  main <- "Confidence Intervals for the Pairwise Comparisons"
  ylab <- "Mean Difference"
  xlab <- ""
  results <- .ciPairwise(formula,...)[,c(1,4,5)]
  .ciPlot(results,main,ylab,xlab,mu)
} 
