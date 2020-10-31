# EASI: Estimation Approach to Statistical Inference
## Alternate Extensions Under Development
### TO INSTALL, SIMPLY COPY AND PASTE CONTENTS OF THIS ENTIRE FILE INTO R

### Arelational and Relational Intervals (ARISE)
### From Wendorf, C. A. (2012). Drawing inferences from multiple intervals in the single-factor design: Derivations, clarifications, extensions, and representations. Methodology, 8(4), 125-133.

### Source the EASI Functions

source("http://raw.githubusercontent.com/cwendorf/EASI-DEV/master/A-Functions/ALL_ALTEASI_FUNCTIONS.R")

### Calculate Relational Intervals

alt.ciRelational <- function(...) 
  UseMethod("alt.ciRelational")

alt.ciRelational.formula <- function(formula,conf.level=.95,...){
  results <- alt.ciMeans(formula,conf.level=conf.level,...)
  mymodel <- aov(formula,...)
  dfe <- anova(mymodel)[["Df"]][[2]]
  mse <- anova(mymodel)[["Mean Sq"]][[2]]  
  ntilde <- 1/mean(1/results[[1]]) 
  a2 <- sqrt(2*mse/ntilde)
  a1 <- qt(1/2-conf.level/2,dfe,lower.tail=FALSE)
  rill <- results[,2]-a1*a2/2
  riul <- results[,2]+a1*a2/2
  results <- round(cbind(results[,c(2,5,6)],rill,riul),3)
  colnames(results) <- c("M","CI.LL","CI.UL","RI.LL","RI.UL")
  results
}

alt.estimateRelational <- function(...){
  cat("\nCONFIDENCE AND RELATIONAL INTERVALS FOR THE LEVELS\n\n")
  print(alt.ciRelational(...))
  cat("\n")
}

### Plot Relational Intervals

alt.plotRelational <- function(...) 
  UseMethod("alt.plotRelational")

alt.plotRelational.formula <- function (formula,conf.level=.95,mu=NA,...){
  main="Confidence and Relational Interval Plot for the Levels"
  ylab=all.vars(formula)[1]
  xlab=all.vars(formula)[2]
  results <- alt.ciRelational(formula,conf.level=conf.level,...)
  plot(results[,1],xaxt='n',xlim=c(.5,nrow(results)+.5),ylim=c(floor(min(results[,2])/2)*2,ceiling(max(results[,3])/2)*2),xlab=xlab,cex.lab=1.3,ylab=ylab,main=main,las=1,cex=1.5,pch=15,bty="l")
  axis(1, 1:nrow(results), row.names(results))
  for (i in 1:nrow(results)) lines(x=c(i,i),y=c(results[,2][i],results[,3][i]),lwd=2)
  for (i in 1:nrow(results)) text(i,results[,1][i],results[,1][i],cex=.8,pos=2,offset=.5,font=2)
  for (i in 1:nrow(results)) text(i,results[,2][i],results[,2][i],cex=.8,pos=2,offset=.5)  
  for (i in 1:nrow(results)) text(i,results[,3][i],results[,3][i],cex=.8,pos=2,offset=.5)
  for (i in 1:nrow(results)) rect(i-.05,results[,4][i],i+.05,results[,5][i],col=rgb(.5,.5,.5,.4),border=NA)
  if (!is.null(mu)) {abline(h=mu,lty=2)}
}

### Add Relational to Existing CI Plot

alt.addRelational <- function(...) 
  UseMethod("alt.addRelational")

alt.addRelational.formula <- function (formula,conf.level=.95,mu=NA,...){
  results <- alt.ciRelational(formula,conf.level=conf.level,...)
  for (i in 1:nrow(results)) rect(i-.05,results[,4][i],i+.05,results[,5][i],col=rgb(.5,.5,.5,.4),border=NA)
  if (!is.null(mu)) {abline(h=mu,lty=2)}
}

### Add Data to Relational Plot

alt.addData <- function(...) 
  UseMethod("alt.addData")

alt.addData.default <- function(...,method="jitter",col="gray60") {
  data <- data.frame(...)
  mx <- ncol(data)+.15
  mn <- 1+.15
  stripchart(data,add=TRUE,at=mn:mx,vertical=TRUE,method=method,jitter=0.08,pch=16,col=col)
}  

alt.addData.formula <- function(formula,method="jitter",col="gray60",...) {
  x <- eval(formula[[3]])
  adjustX <- as.numeric(x)+.15
  mn <- min(adjustX,na.rm=TRUE)
  mx <- max(adjustX,na.rm=TRUE)
  stripchart(formula,add=TRUE,at=mn:mx,vertical=TRUE,method=method,jitter=0.08,pch=16,col=col)
}

### Five Group ARISE Data (from Wendorf, 2012)

Group <- c(rep(1,10),rep(2,10),rep(3,10),rep(4,10),rep(5,10))
Outcome <- c(61,64,72,64,64,70,73,65,65,72,69,74,79,69,64,64,69,69,74,79,70,75,80,80,70,65,70,75,70,70,70,80,85,75,70,65,75,75,85,80,65,55,70,65,65,70,70,60,65,70)
Group <- factor(Group,levels=c(1,2,3,4,5),labels=c("Group1","Group2","Group3","Group4","Group5"))

MyData <- data.frame(Group,Outcome)
MyData

alt.estimateRelational(Outcome~Group)
alt.plotRelational(Outcome~Group)
alt.addData(Outcome~Group)
