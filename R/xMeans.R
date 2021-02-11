# Estimation Approach to Statistical Inference
## Functions for Means

### Descriptive Functions 

.dsMeans <- function(x,...) 
  UseMethod(".dsMeans")

.dsMeans.default <- function(...){
  data <- data.frame(...)
  rn <- names(data)
  M <- sapply(data,mean,na.rm=TRUE)
  SD <- sapply(data,sd,na.rm=TRUE) 
  results <- cbind(N=N,M=M,SD=SD)
  rownames(results) <- rn
  round(results,3)
}

.dsMeans.formula <- function(formula,...) {
  rn <- aggregate(formula,FUN=length)[[1]]
  N <- aggregate(formula,FUN=length)[[2]]
  M <- aggregate(formula,FUN=mean,na.rm=TRUE)[[2]]
  SD <- aggregate(formula,FUN=sd,na.rm=TRUE)[[2]]
  results <- cbind(N=N,M=M,SD=SD)
  rownames(results) <- rn
  round(results,3)
}

describeMeans <- function(...){
  cat("\nDESCRIPTIVE STATISTICS FOR THE DATA\n\n")
  print(.dsMeans(...))
  cat("\n")
}  

### Confidence Interval Functions 

.ciMeans <- function(x,...) 
  UseMethod(".ciMeans")

.ciMeans.default <- function(...,conf.level=.95) {
  data <- data.frame(...)
  columns <- dim(data)[2]
  dataLong <- reshape(data,varying=1:columns,v.names="Outcome",timevar="Variables",idvar="Subjects",direction="long")
  dataLong$Subjects <- as.factor(dataLong$Subjects)
  dataLong$Variables <- as.factor(dataLong$Variables)
  model <- lm(Outcome~Variables-1,data=dataLong)
  results <- cbind(summary(model)$coeff[,1:2],model$df.residual,confint(model,level=conf.level))
  colnames(results) <- c("M","SE","df","LL","UL")
  rownames(results) <- names(data)
  round(results,3)
}

.ciMeans.formula <- function(formula,conf.level=.95,...) {
  x <- eval(formula[[3]])
  formula <- update(formula, ~ . + -1)
  model <- lm(formula)
  results <- cbind(summary(model)$coeff[,1:2],model$df.residual,confint(model,level=conf.level))
  colnames(results) <- c("M","SE","df","LL","UL")
  rownames(results) <- levels(x)
  round(results,3)
}

estimateMeans <- function(...) {
  cat("\nCONFIDENCE INTERVALS FOR THE MEANS\n\n")
  print(.ciMeans(...))
  cat("\n")
}

### Null Hypothesis Significance Test Functions

.nhstMeans <- function(x,...) 
  UseMethod(".nhstMeans")

.nhstMeans.default <- function(...,mu=0) {
  data <- data.frame(...)
  columns <- dim(data)[2]
  dataLong <- reshape(data,varying=1:columns,v.names="Outcome",timevar="Variables",idvar="Subjects",direction="long")
  dataLong$Subjects <- as.factor(dataLong$Subjects)
  dataLong$Variables <- as.factor(dataLong$Variables)
  model <- lm(Outcome~Variables-1,data=dataLong)
  results <- cbind(summary(model)$coeff,1)
  results[,1] <- results[,1]-mu
  results[,3] <- model$df.residual
  results[,4] <- results[,1]/results[,2]
  results[,5] <- 2*pt(-abs(results[,4]),df=results[,3])
  colnames(results) <- c("Diff","SE","df","t","p")
  rownames(results) <- names(data)
  round(results,3)  
}

.nhstMeans.formula <- function(formula,mu=0) {
  x <- eval(formula[[3]])
  formula <- update(formula, ~ . + -1)
  model <- lm(formula)
  results <- cbind(summary(model)$coeff,1)
  results[,1] <- results[,1]-mu
  results[,3] <- model$df.residual
  results[,4] <- results[,1]/results[,2]
  results[,5] <- 2*pt(-abs(results[,4]),df=results[,3])
  colnames(results) <- c("Diff","SE","df","t","p")
  rownames(results) <- levels(x)
  round(results,3)
}

testMeans <- function(...) {
  cat("\nHYPOTHESIS TESTS FOR THE MEANS\n\n")
  print(.nhstMeans(...))
  cat("\n")
}

### Confidence Interval Plot Functions

.ciPlot <- function(results,main,ylab,xlab,mu){
  plot(results[,1],xaxt='n',xlim=c(.5,nrow(results)+.5),ylim=c(floor(min(results[,2])/2)*2,ceiling(max(results[,3])/2)*2),xlab=xlab,cex.lab=1.15,ylab=ylab,main=main,las=1,cex=1.5,pch=16,bty="l")
  axis(1, 1:nrow(results), row.names(results))
  for (i in 1:nrow(results)) lines(x=c(i,i),y=c(results[,2][i],results[,3][i]),lwd=2)
  for (i in 1:nrow(results)) text(i,results[,1][i],results[,1][i],cex=.8,pos=2,offset=.5,font=2)
  for (i in 1:nrow(results)) text(i,results[,2][i],results[,2][i],cex=.8,pos=2,offset=.5)  
  for (i in 1:nrow(results)) text(i,results[,3][i],results[,3][i],cex=.8,pos=2,offset=.5)
  if (!is.null(mu)) {abline(h=mu,lty=2)}
}

.diffPlot <- function(results,graph,main,ylab,xlab){
  plot(c(1,2,3),graph[,1],xaxt="n",xlim=c(.4,3.6),ylim=c(floor(min(graph[,2])/2)*2,ceiling(max(graph[,3])/2)*2),pch=c(16,16,17),cex=1.5,xlab=xlab,ylab=ylab,main=main,las=1,cex.lab=1.15,bty="l")
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
}

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

