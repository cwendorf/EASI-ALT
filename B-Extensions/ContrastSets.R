# EASI: Estimation Approach to Statistical Inference
## Alternate Extensions Under Development
### TO INSTALL, SIMPLY COPY AND PASTE CONTENTS OF THIS ENTIRE FILE INTO R

### Analyses of Sets of Linear Contrasts
### (equivalent to dummy, effect, and other sets of codes)

#### CI Function for Group and Variable Contrasts

alt.ciContrasts <- function(...) 
  UseMethod("alt.ciContrasts")

alt.ciContrasts.default <- function(...,contrasts=contr.sum,conf.level=.95){
  data <- data.frame(...)
  columns <- dim(data)[2]
  dataLong <- reshape(data,varying=1:columns,v.names="Outcome",timevar="Variable",idvar="Subjects",direction="long")
  dataLong$Subjects <- as.factor(dataLong$Subjects)
  dataLong$Variable <- as.factor(dataLong$Variable)
  vlevels <- nlevels(dataLong$Variable)
  contrasts(dataLong$Variable) <- contrasts
  contrasts(dataLong$Subjects) <- contr.sum
  model <- aov(Outcome~Variable+Error(Subjects),data=dataLong)
  first <- summary(lm(model))[[4]][1:vlevels,1:2]
  second <- confint(lm(model),level=conf.level)[1:vlevels,1:2]
  results <- round(cbind(first,second),3)
  colnames(results) <- c("Est","SE","LL","UL")
  return(results)
}

alt.ciContrasts.formula <- function(formula,contrasts=contr.sum,conf.level=.95,...){
  x <- eval(formula[[3]])
  y <- eval(formula[[2]])
  contrasts(x) <- contrasts
  model <- lm(y~x,...)
  results <- round(cbind(summary(model)[[4]][,1:2],confint(model,level=conf.level)),3)
  colnames(results) <- c("Est","SE","LL","UL")
  return(results)
}
 
alt.estimateContrasts <- function(...) {
  cat("\nCONFIDENCE INTERVALS FOR THE CONTRASTS\n\n")
  print(alt.ciContrasts(...)) 
  cat("\n")  
}

#### NHST Function for Group and Variable Contrasts

alt.nhstContrasts <- function(...) 
  UseMethod("alt.nhstContrasts")

alt.nhstContrasts.default <- function(...,contrasts=contr.sum){
  data <- data.frame(...)
  columns <- dim(data)[2]
  dataLong <- reshape(data,varying=1:columns,v.names="Outcome",timevar="Variable",idvar="Subjects",direction="long")
  dataLong$Subjects <- as.factor(dataLong$Subjects)
  dataLong$Variable <- as.factor(dataLong$Variable)
  vlevels <- nlevels(dataLong$Variable)
  contrasts(dataLong$Variable) <- contrasts
  contrasts(dataLong$Subjects) <- contr.sum
  model <- aov(Outcome~Variable+Error(Subjects),data=dataLong)
  first <- summary(lm(model))[[4]][1:vlevels,1:4]
  results <- round(first,3)
  colnames(results) <- c("Diff","SE","t","p")
  return(results)
}

alt.nhstContrasts.formula <- function(formula,contrasts=contr.sum,...){
  x <- eval(formula[[3]])
  y <- eval(formula[[2]])
  contrasts(x) <- contrasts
  model <- lm(y~x,...)
  results <- round(summary(model)[[4]][,],3)
  colnames(results) <- c("Diff","SE","t","p")
  return(results)
}

alt.testContrasts<-function(...) {
  cat("\nHYPOTHESIS TESTS FOR THE CONTRASTS\n\n")
  print(alt.nhstContrasts(...)) 
  cat("\n")  
}

#### Contrast Plots

alt.plotContrasts <- function(...) 
  UseMethod("alt.plotContrasts")

alt.plotContrasts.default <- function(...,mu=NULL) {
  main="Confidence Intervals for the Contrasts"
  ylab="Mean Difference"
  xlab="Contrasts"
  results <- alt.ciContrasts(...)[,c(1,3,4)]
  plot(results[,1],xaxt='n',xlim=c(.5,nrow(results)+.5),ylim=c(floor(min(results[,2])/2)*2,ceiling(max(results[,3])/2)*2),xlab=xlab,cex.lab=1.3,ylab=ylab,main=main,las=1,cex=1.5,pch=15,bty="l")
  axis(1,at=1:length(results[,1]),labels=row.names(results))
  for (i in 1:nrow(results)) lines(x=c(i,i),y=c(results[,2][i],results[,3][i]),lwd=2)
  for (i in 1:nrow(results)) text(i,results[,1][i],results[,1][i],cex=.8,pos=2,offset=.5,font=2)
  for (i in 1:nrow(results)) text(i,results[,2][i],results[,2][i],cex=.8,pos=2,offset=.5)  
  for (i in 1:nrow(results)) text(i,results[,3][i],results[,3][i],cex=.8,pos=2,offset=.5)
  if (!is.null(mu)) {abline(h=mu,lty=2)} 
}

alt.plotContrasts.formula <- function(formula,mu=NULL,...) {
  main="Confidence Intervals for the Contrasts"
  ylab="Mean Difference"
  xlab="Contrasts"
  results <- alt.ciContrasts(formula,...)[,c(1,3,4)]
  plot(results[,1],xaxt='n',xlim=c(.5,nrow(results)+.5),ylim=c(floor(min(results[,2])/2)*2,ceiling(max(results[,3])/2)*2),xlab=xlab,cex.lab=1.3,ylab=ylab,main=main,las=1,cex=1.5,pch=15,bty="l")
  axis(1,at=1:length(results[,1]),labels=row.names(results))
  for (i in 1:nrow(results)) lines(x=c(i,i),y=c(results[,2][i],results[,3][i]),lwd=2)
  for (i in 1:nrow(results)) text(i,results[,1][i],results[,1][i],cex=.8,pos=2,offset=.5,font=2)
  for (i in 1:nrow(results)) text(i,results[,2][i],results[,2][i],cex=.8,pos=2,offset=.5)  
  for (i in 1:nrow(results)) text(i,results[,3][i],results[,3][i],cex=.8,pos=2,offset=.5)
  if (!is.null(mu)) {abline(h=mu,lty=2)} 
}

### Three Group Example Data

Group <- c(rep(1,3),rep(2,3),rep(3,3))
Outcome <- c(3,4,5,7,8,9,8,9,10)
Group <- factor(Group,levels=c(1,2,3),labels=c("Group1","Group2","Group3"))

#### Estimate, Plot, and Test a Set of Contrasts
#### (default are sum contrasts -- comparisons of levels to grand mean)

alt.estimateContrasts(Outcome~Group)
alt.plotContrasts(Outcome~Group)
alt.testContrasts(Outcome~Group)

alt.estimateContrasts(Outcome~Group,conf.level=.99)
alt.plotContrasts(Outcome~Group,conf.level=.99)

#### Other Standard Sets of Contrasts can be Specified

alt.estimateContrasts(Outcome~Group,contrasts=contr.sum)
alt.testContrasts(Outcome~Group,contrasts=contr.sum)
alt.plotContrasts(Outcome~Group,contrasts=contr.sum)

alt.estimateContrasts(Outcome~Group,contrasts=contr.treatment)
alt.plotContrasts(Outcome~Group,contrasts=contr.treatment)
alt.testContrasts(Outcome~Group,contrasts=contr.treatment)

alt.estimateContrasts(Outcome~Group,contrasts=contr.poly)
alt.plotContrasts(Outcome~Group,contrasts=contr.poly)
alt.testContrasts(Outcome~Group,contrasts=contr.poly)

alt.estimateContrasts(Outcome~Group,contrasts=contr.helmert)
alt.plotContrasts(Outcome~Group,contrasts=contr.helmert)
alt.testContrasts(Outcome~Group,contrasts=contr.helmert)

alt.estimateContrasts(Outcome~Group,contrasts=contr.SAS)
alt.plotContrasts(Outcome~Group,contrasts=contr.SAS)
alt.testContrasts(Outcome~Group,contrasts=contr.SAS)

### Three Time Period Example Data

Time1 <- c(5,6,6,7,8)
Time2 <- c(7,7,8,8,9)
Time3 <- c(8,8,9,9,9)

#### Estimate, Plot, and Test a Set of Contrasts
#### (default are sum contrasts -- comparisons of levels to grand mean)

alt.estimateContrasts(Time1,Time2,Time3)
alt.plotContrasts(Time1,Time2,Time3)
alt.testContrasts(Time1,Time2,Time3)

alt.estimateContrasts(Time1,Time2,Time3,conf.level=.99)
alt.plotContrasts(Time1,Time2,Time3,conf.level=.99)

#### Other Standard Sets of Contrasts can be Specified

alt.estimateContrasts(Time1,Time2,Time3,contrasts=contr.sum)
alt.plotContrasts(Time1,Time2,Time3,contrasts=contr.sum)
alt.testContrasts(Time1,Time2,Time3,contrasts=contr.sum)

alt.estimateContrasts(Time1,Time2,Time3,contrasts=contr.treatment)
alt.plotContrasts(Time1,Time2,Time3,contrasts=contr.treatment)
alt.testContrasts(Time1,Time2,Time3,contrasts=contr.treatment)

alt.estimateContrasts(Time1,Time2,Time3,contrasts=contr.poly)
alt.plotContrasts(Time1,Time2,Time3,contrasts=contr.poly)
alt.testContrasts(Time1,Time2,Time3,contrasts=contr.poly)

alt.estimateContrasts(Time1,Time2,Time3,contrasts=contr.helmert)
alt.plotContrasts(Time1,Time2,Time3,contrasts=contr.helmert)
alt.testContrasts(Time1,Time2,Time3,contrasts=contr.helmert)

alt.estimateContrasts(Time1,Time2,Time3,contrasts=contr.SAS)
alt.plotContrasts(Time1,Time2,Time3,contrasts=contr.SAS)
alt.testContrasts(Time1,Time2,Time3,contrasts=contr.SAS)
