# EASI: Estimation Approach to Statistical Inference
## Extensions Under Development
### TO INSTALL, SIMPLY COPY AND PASTE CONTENTS OF THIS ENTIRE FILE INTO R

### Pairwise Comparisons (Unadjusted)

#### CI Function for Pairwise Group and Variable Comparisons

.ciPairwise <- function(...) 
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
  return(round(results,3))
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
  return(round(results,3))
}

estimatePairwise <- function(...) {
  cat("\nCONFIDENCE INTERVALS FOR THE PAIRWISE COMPARISONS\n\n")
  print(.ciPairwise(...)) 
  cat("\n")  
}

#### NHST Function for Pairwise Comparisons

.nhstPairwise <- function(...) 
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
  return(round(results,3))
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
  return(round(results,3))
}

testPairwise <- function(...) {
  cat("\nHYPOTHESIS TESTS FOR THE PAIRWISE COMPARISONS\n\n")
  print(.nhstPairwise(...)) 
  cat("\n")  
}

#### Pairwise Plots

plotPairwise <- function(...) 
  UseMethod("plotPairwise")

plotPairwise.default <- function(...,mu=NULL) {
  main="Confidence Intervals for the Pairwise Comparisons"
  ylab="Mean Difference"
  xlab="Pairwise Comparisons"
  results <- .ciPairwise(...)[,c(1,4,5)]
  plot(results[,1],xaxt='n',xlim=c(.5,nrow(results)+.5),ylim=c(floor(min(results[,2])/2)*2,ceiling(max(results[,3])/2)*2),xlab=xlab,cex.lab=1.3,ylab=ylab,main=main,las=1,cex=1.5,pch=15,bty="l")
  axis(1,at=1:length(results[,1]),labels=row.names(results))
  for (i in 1:nrow(results)) lines(x=c(i,i), y=c(results[,2][i],results[,3][i]),lwd=2)
  for (i in 1:nrow(results)) text(i,results[,1][i],results[,1][i],cex=.8,pos=2,offset=.5,font=2)
  for (i in 1:nrow(results)) text(i,results[,2][i],results[,2][i],cex=.8,pos=2,offset=.5)  
  for (i in 1:nrow(results)) text(i,results[,3][i],results[,3][i],cex=.8,pos=2,offset=.5)
  if (!is.null(mu)) {abline(h=mu,lty=2)} 
}

plotPairwise.formula <- function(formula,conf.level=.95,mu=NA,...) {
  main="Confidence Intervals for the Pairwise Comparisons"
  ylab="Mean Difference"
  xlab="Pairwise Comparisons"
  results <- .ciPairwise(formula,...)[,c(1,4,5)]
  plot(results[,1],xaxt='n',xlim=c(.5,nrow(results)+.5),ylim=c(floor(min(results[,2])/2)*2,ceiling(max(results[,3])/2)*2),xlab=xlab,cex.lab=1.3,ylab=ylab,main=main,las=1,cex=1.5,pch=15,bty="l")
  axis(1,at=1:length(results[,1]),labels=row.names(results))
  for (i in 1:nrow(results)) lines(x=c(i,i), y=c(results[,2][i],results[,3][i]),lwd=2)
  for (i in 1:nrow(results)) text(i,results[,1][i],results[,1][i],cex=.8,pos=2,offset=.5,font=2)
  for (i in 1:nrow(results)) text(i,results[,2][i],results[,2][i],cex=.8,pos=2,offset=.5)  
  for (i in 1:nrow(results)) text(i,results[,3][i],results[,3][i],cex=.8,pos=2,offset=.5)
  if (!is.null(mu)) {abline(h=mu,lty=2)} 
}

### Three Group Example Data

Group <- c(rep(1,3),rep(2,3),rep(3,3))
Outcome <- c(3,4,5,7,8,9,8,9,10)
Group <- factor(Group,levels=c(1,2,3),labels=c("Group1","Group2","Group3"))

#### Estimate, Plot, and Test Pairwise Comparisons

estimatePairwise(Outcome~Group)
estimatePairwise(Outcome~Group,conf.level=.99)

plotPairwise(Outcome~Group)
plotPairwise(Outcome~Group,mu=-2,conf.level=.99)

testPairwise(Outcome~Group)
testPairwise(Outcome~Group,mu=-2)

### Three Time Period Example Data

Time1 <- c(5,6,6,7,8)
Time2 <- c(7,7,8,8,9)
Time3 <- c(8,8,9,9,9)

#### Estimate, Plot, and Test Pairwise Comparisons

estimatePairwise(Time1,Time2,Time3)
estimatePairwise(Time1,Time2,Time3,conf.level=.99)

plotPairwise(Time1,Time2,Time3)
plotPairwise(Time1,Time2,Time3,mu=-2,conf.level=.99)

testPairwise(Time1,Time2,Time3)
testPairwise(Time1,Time2,Time3,mu=-2)
