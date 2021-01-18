# Estimation Approach to Statistical Inferenence (EASI)
## Basic Functions (Estimate, Test, and Plot)
## TO INSTALL, SIMPLY COPY AND PASTE CONTENTS OF THIS ENTIRE FILE INTO R 

### Confidence Interval Functions 

#### Basic CI Function

.ci <- function(y,...){
  N <- length(y)
  M <- mean(y,na.rm=TRUE)
  SD <- sd(y,na.rm=TRUE)
  SE <- SD/sqrt(N)
  LL <- t.test(y,...)$conf.int[1]
  UL <- t.test(y,...)$conf.int[2]
  round(c(N=N,M=M,SD=SD,SE=SE,LL=LL,UL=UL),3)
}

#### CI Function for Mutiple Groups and Variables

.ciMeans <- function(...) 
  UseMethod(".ciMeans")

.ciMeans.default <- function(...,conf.level=.95){
  data <- data.frame(...)
  results <- data.frame(matrix(ncol=6,nrow=0))
  for (i in 1:ncol(data)) results[i,] <- .ci(data[,i],conf.level=conf.level)
  colnames(results) <- c("N","M","SD","SE","LL","UL")
  rownames(results) <- colnames(data)
  return(results)
}

.ciMeans.formula <- function(formula,...) {
  results <- aggregate(formula,FUN=.ci,...)
  rn <- results[,1]
  results <- results[[2]]
  rownames(results) <- rn
  return(results)
}

#### CI Function for Group and Variable Differences

.ciDifference <- function(...) 
  UseMethod(".ciDifference")

.ciDifference.default <- function(x,y,conf.level=.95,...){
  model=t.test(x,y,paired=TRUE,...)
  MD=as.numeric(model$estimate)
  SE=as.numeric(model$stderr)
  df=as.numeric(model$parameter)
  LL=model$conf.int[1]
  UL=model$conf.int[2]
  results=round(c(Diff=MD,SE=SE,df=df,LL=LL,UL=UL),3)
  return(results) 
}

.ciDifference.formula <- function(formula,conf.level=.95,...){
  model=t.test(formula,...)
  MD=as.numeric(model$estimate[1]-model$estimate[2])
  SE=as.numeric(model$stderr)
  df=as.numeric(model$parameter)
  LL=model$conf.int[1]
  UL=model$conf.int[2]
  results=round(c(Diff=MD,SE=SE,df=df,LL=LL,UL=UL),3)
  return(results)
}

### Wrappers for CI Functions

estimateMeans <- function(...){
  cat("\nCONFIDENCE INTERVALS FOR THE MEANS\n\n")
  print(.ciMeans(...))
  cat("\n")
}

estimateDifference<-function(...) {
  cat("\nCONFIDENCE INTERVAL FOR THE COMPARISON\n\n")
  print(.ciDifference(...)) 
  cat("\n")  
}

### Null Hypothesis Significance Test Functions

#### Basic NHST Function

.nhst <- function(y,...){
  model <- t.test(y,...)
  mu <- as.numeric(model$null.value)
  MD <- as.numeric(model$estimate-mu)
  SE <- as.numeric(model$stderr)
  t <- as.numeric(model$statistic)
  df <- as.numeric(model$parameter)
  p <- as.numeric(model$p.value)
  round(c(Diff=MD,SE=SE,t=t,df=df,p=p),3)
}

#### NHST Function for Mutiple Groups and Variables

.nhstMeans <- function(...) 
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

##### NHST Function for Group and Variable Differences

.nhstDifference <- function(...) 
  UseMethod(".nhstDifference")

.nhstDifference.default <- function(x,y,...){
  model=t.test(x,y,paired=TRUE,...)
  mu=as.numeric(model$null.value) 
  MD=as.numeric(model$estimate)
  SE=as.numeric(model$stderr)
  t=as.numeric(model$statistic)
  df=as.numeric(model$parameter)
  p=as.numeric(model$p.value)
  results=round(c(Diff=MD,SE=SE,t=t,df=df,p=p),3)
  return(results) 
}

.nhstDifference.formula <- function(formula,...){
  model=t.test(formula,...)
  mu=as.numeric(model$null.value)
  MD=as.numeric(model$estimate[1]-model$estimate[2]-mu)
  SE=as.numeric(model$stderr)
  t=as.numeric(model$statistic)
  df=as.numeric(model$parameter)
  p=as.numeric(model$p.value)
  results=round(c(Diff=MD,SE=SE,t=t,df=df,p=p),3)
  return(results)
}

### Wrappers for NHST Functions

testMeans <- function(...){
  cat("\nHYPOTHESIS TESTS FOR THE MEANS\n\n")
  print(.nhstMeans(...))
  cat("\n")
}

testDifference <- function(...){
  cat("\nHYPOTHESIS TEST FOR THE COMPARISON\n\n")
  print(.nhstDifference(...)) 
  cat("\n")
}

### Confidence Interval Plot Functions

#### Basic Plot Functions

.cipMeans <- function(results,main,ylab,xlab,mu){
  plot(results[,1],xaxt='n',xlim=c(.5,nrow(results)+.5),ylim=c(floor(min(results[,2])/2)*2,ceiling(max(results[,3])/2)*2),xlab=xlab,cex.lab=1.3,ylab=ylab,main=main,las=1,cex=1.5,pch=15,bty="l")
  axis(1, 1:nrow(results), row.names(results))
  for (i in 1:nrow(results)) lines(x=c(i,i),y=c(results[,2][i],results[,3][i]),lwd=2)
  for (i in 1:nrow(results)) text(i,results[,1][i],results[,1][i],cex=.8,pos=2,offset=.5,font=2)
  for (i in 1:nrow(results)) text(i,results[,2][i],results[,2][i],cex=.8,pos=2,offset=.5)  
  for (i in 1:nrow(results)) text(i,results[,3][i],results[,3][i],cex=.8,pos=2,offset=.5)
  if (!is.null(mu)) {abline(h=mu,lty=2)}
}

.cipDifference <- function(results,graph,main,ylab,xlab){
  plot(c(1,2,3),graph[,1],xaxt="n",xlim=c(.4,3.6),ylim=c(floor(min(graph[,2])/2)*2,ceiling(max(graph[,3])/2)*2),pch=c(15,15,17),cex=1.5,xlab=xlab,ylab=ylab,main=main,las=1,cex.lab=1.3,bty="l")
  axis(1,at=c(1,2,3),labels=rownames(graph))
  for (i in 1:3) lines(x=c(i,i), y=c(graph[,2][i],graph[,3][i]),lwd=2)
  for (i in 1:2) text(i,graph[,1][i],graph[,1][i],cex=.8,pos=2,offset=.5,font=2)
  for (i in 1:2) text(i,graph[,2][i],graph[,2][i],cex=.8,pos=2,offset=.5)  
  for (i in 1:2) text(i,graph[,3][i],graph[,3][i],cex=.8,pos=2,offset=.5)
  text(3,graph[,1][3],results[,1][3],cex=.8,pos=4,offset=.5,font=2)
  text(3,graph[,2][3],results[,2][3],cex=.8,pos=4,offset=.5)  
  text(3,graph[,3][3],results[,3][3],cex=.8,pos=4,offset=.5)
  arrows(1,graph[1,1],4.5,graph[1,1],code=3,length=0,lty=2)  
  arrows(2,graph[2,1],4.5,graph[2,1],code=3,length=0,lty=2)
  if(results[1,1]<results[2,1]) {td <- graph[1,1]-axTicks(4)[max(which(axTicks(4)<graph[1,1]))]}
  if(results[1,1]>=results[2,1]) {td <- graph[1,1]-axTicks(4)[min(which(axTicks(4)>graph[1,1]))]}  
  val <- axTicks(4)-graph[1,1]+td
  loc <- axTicks(4)+td  
  axis(4,at=loc,labels=val,las=1)
  rect(2.5,-1e6,4.5,1e6,col=rgb(.5,.5,.5,.07),border=NA)
}

#### Plot Function for Confidence Intervals for Multiple Groups and Levels

plotMeans <- function(...) 
  UseMethod("plotMeans")

plotMeans.default <- function(...,conf.level=.95,mu=NULL){
  main="Confidence Intervals for the Means"
  ylab="Outcome"
  xlab="Variables"
  results <- .ciMeans(...,conf.level=conf.level)[,c(2,5,6)]
  .cipMeans(results,main,ylab,xlab,mu)
}

plotMeans.formula <- function(formula,mu=NULL,...){
  main="Confidence Intervals for the Means"
  ylab=all.vars(formula)[1]
  xlab=all.vars(formula)[2]
  results <- .ciMeans(formula,...)[,c(2,5,6)]
  x <- eval(formula[[3]])
  y <- eval(formula[[2]])
  row.names(results) <- levels(x)
  .cipMeans(results,main,ylab,xlab,mu)
}

#### Plot Function for Confidence Intervals of a Mean Difference/Comparison of Groups and Variables

plotDifference <- function(...) 
  UseMethod("plotDifference")

plotDifference.default <- function(...){
  main="Confidence Intervals for the Comparison"
  ylab="Outcome"
  xlab="Variables"
  Vars <- .ciMeans(...)[2:1,c(2,5,6)]
  Diff <- .ciDifference(...)[c(1,4,5)]
  results <- rbind(Vars,Diff)
  Diff <- Diff+Vars[1,1]  
  graph <- rbind(Vars,Diff)
  rownames(graph)[3]="Diff"
  .cipDifference(results,graph,main,ylab,xlab)
}

plotDifference.formula <- function(formula,...){
  main="Confidence Intervals for the Comparison"
  ylab=all.vars(formula)[1]
  xlab=all.vars(formula)[2]
  Groups <- .ciMeans(formula,...)
  Groups <- Groups[2:1,c(2,5,6)]
  Diff <- .ciDifference(formula,...)[c(1,4,5)]
  results <- rbind(Groups,Diff)
  Diff <- Diff+Groups[1]
  graph <- rbind(Groups,Diff)
  .cipDifference(results,graph,main,ylab,xlab)
}
