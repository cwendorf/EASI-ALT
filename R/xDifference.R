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

estimateDifference<-function(...) {
  cat("\nCONFIDENCE INTERVAL FOR THE COMPARISON\n\n")
  print(.ciDifference(...)) 
  cat("\n")  
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

testDifference <- function(...){
  cat("\nHYPOTHESIS TEST FOR THE COMPARISON\n\n")
  print(.nhstDifference(...)) 
  cat("\n")
}

### Confidence Interval Plot Functions

.diffPlot <- function(results,graph,main,ylab,xlab){
  ylim <- range(pretty(c(floor(min(graph[,2]-.4)),ceiling(max(graph[,3])+.4))))
  plot(c(1,2,3),graph[,1],xaxt="n",yaxt="n",xaxs="i",yaxs="i",xlim=c(.4,3.6),ylim=ylim,pch=c(16,16,17),cex=1.5,xlab=xlab,ylab=ylab,main=main,las=1,cex.lab=1.15,bty="n")
  axis(1,.4:2.4,labels=FALSE,lwd.tick=0)
  axis(1,2.6:3.6,labels=FALSE,lwd.tick=0)
  axis(1,at=c(1,2),labels=rownames(graph)[1:2])
  axis(1,at=3,labels=rownames(graph)[3])
  axis(2)
  axis(2,at=ylim,labels=FALSE,lwd.tick=0)  
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

plotDifference <- function(...) 
  UseMethod("plotDifference")

plotDifference.default <- function(...){
  main <- "Confidence Intervals for the Comparison"
  ylab <- "Outcome"
  xlab <- ""
  Vars <- .ciMeans(...)[2:1,c(1,4,5)]
  Diff <- .ciDifference(...)[1,c(1,4,5)]
  colnames(Diff)=c("M","LL","UL")  
  results <- rbind(Vars,Diff)
  Diff <- Diff+Vars[1,1]  
  graph <- rbind(Vars,Diff)
  rownames(graph)[3] <- "Comparison"
  .diffPlot(results,graph,main,ylab,xlab)
}

plotDifference.formula <- function(formula,...){
  main <- "Confidence Intervals for the Comparison"
  ylab <- all.vars(formula)[1]
  xlab <- ""
  Groups <- .ciMeans(formula,...)[2:1,c(1,4,5)]
  Diff <- .ciDifference(formula,...)[1,c(1,4,5)]
  colnames(Diff)=c("M","LL","UL")
  results <- rbind(Groups,Diff)
  Diff <- Diff+Groups[1]
  graph <- rbind(Groups,Diff)
  .diffPlot(results,graph,main,ylab,xlab)
}
