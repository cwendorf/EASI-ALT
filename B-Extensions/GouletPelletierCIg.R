# EASI: Estimation Approach to Statistical Inference
## Extensions Under Development
### TO INSTALL, SIMPLY COPY AND PASTE CONTENTS OF THIS ENTIRE FILE INTO R

### Goulet-Pelletier and Cousineau Functions for CI for Hedges g
### From Goulet-Pelletier, J-C. & Cousineau, D. (2018). A review of effect sizes and their confidence intervals, Part I: The Cohen's d family. The Quantitative Methods for Psychology, 14(4), 242-265.

### Functions for Confidence Intervals for Hedges g

.ciHg <- function(y,conf.level=.95,mu=0,...){
  Var <- .ci(y,...)
  n <- as.numeric(Var[1])
  m <- as.numeric(Var[2])
  sd <- as.numeric(Var[3])
  md <- m-mu
  cohend <- md/sd
  eta <- n-1
  J <- gamma(eta/2)/(sqrt(eta/2)*gamma((eta-1)/2))
  hedgesg <- cohend*J
  lambda <- hedgesg*sqrt(n)
  tlow <- qt(1/2-conf.level/2,df=eta,ncp=lambda)
  thig <- qt(1/2+conf.level/2,df=eta,ncp=lambda)
  dlow <- tlow/lambda*hedgesg 
  dhig <- thig/lambda*hedgesg 
  round(c(d=cohend,g=hedgesg,LL=dlow,UL=dhig),3)
}

.ciHgMeans <- function(...) 
  UseMethod("..ciHgMeans")

.ciHgMeans.default <- function(...,conf.level=.95,mu=0){
  data <- data.frame(...)
  results <- data.frame(matrix(ncol=4,nrow=0))
  for (i in 1:ncol(data)) results[i,] <- .ciHg(data[,i],conf.level=conf.level,mu=mu)
  colnames(results) <- c("d","g","LL","UL")
  rownames(results) <- colnames(data)
  results
}

.ciHgMeans.formula <- function(formula,...) {
  results <- aggregate(formula,FUN=.ciHg,...)
  colnames(results) <- c("Group","")
  rownames(results) <- results[,1]
  results[2]
}

.ciHgDifference <- function(...) 
  UseMethod(".ciHgDifference")  

.ciHgDifference.default <- function(...,conf.level=.95){
  Vars <- .ciMeans(...)
  ns  <- as.numeric(Vars[1:2,1])
  mns <- as.numeric(Vars[1:2,2])
  sds <- as.numeric(Vars[1:2,3])
  ntilde <- 1/mean(1/ns) 
  md <- (mns[1]-mns[2])
  sdp <- sqrt((ns[1]-1)*sds[1]^2+(ns[2]-1)*sds[2]^2)/sqrt(ns[1]+ns[2]-2)
  cohend <- md/sdp
  eta <- ns[1]+ns[2]-2
  J <- gamma(eta/2)/(sqrt(eta/2)*gamma((eta-1)/2))
  hedgesg <- cohend*J
  r <- cor(...)
  lambda <- hedgesg*sqrt(ntilde/(2*(1-r)))
  tlow <- qt(1/2-conf.level/2,df=eta,ncp=lambda)
  thig <- qt(1/2+conf.level/2,df=eta,ncp=lambda)
  dlow <- tlow/lambda*hedgesg 
  dhig <- thig/lambda*hedgesg 
  results=round(cbind(d=cohend,g=hedgesg,LL=dlow,UL=dhig),3)
  rownames(results) <- c("Comparison")
  results
}

.ciHgDifference.formula <- function(formula,conf.level=.95,...){
  Groups <- .ciMeans(formula,...)
  ns <- as.numeric(Groups[1:2,1])
  mns <- as.numeric(Groups[1:2,2])
  sds <- as.numeric(Groups[1:2,3])
  ntilde <- 1/mean(1/ns) 
  md <- (mns[1]-mns[2])
  sdp <- sqrt((ns[1]-1)*sds[1]^2+(ns[2]-1)*sds[2]^2)/sqrt(ns[1]+ns[2]-2)
  cohend <- md/sdp
  eta <- ns[1]+ns[2]-2
  J <- gamma(eta/2)/(sqrt(eta/2)*gamma((eta-1)/2))
  hedgesg <- cohend*J
  lambda <- hedgesg*sqrt(ntilde/2)
  tlow <- qt(1/2-conf.level/2,df=eta,ncp=lambda)
  thig <- qt(1/2+conf.level/2,df=eta,ncp=lambda)
  dlow <- tlow/lambda*hedgesg 
  dhig <- thig/lambda*hedgesg 
  results=round(cbind(d=cohend,g=hedgesg,LL=dlow,UL=dhig),3)
  rownames(results) <- c("Comparison")
  results
}

.ciHgPairwise <- function(...) 
  UseMethod(".ciHgPairwise")
  
.ciHgPairwise.default <- function(...,conf.level=.95){
  Vars <- .ciMeans(...)
  nr <- dim(Vars)[1]
  rn <- rownames(Vars)
  ncomp <- (nr)*(nr-1)/2
  results <- data.frame(matrix(ncol=4,nrow=ncomp))
  colnames(results)<- c("d","g","LL","UL")
  comp <- 1
  for( i in 1:(nr-1) ){
  for( j in (i+1):nr ){
    rownames(results)[comp] <- paste(rn[i],"v",rn[j])
	varx <- get(rn[i])
	vary <- get(rn[j])
    ns <- as.numeric(Vars[c(i,j),1])
	  mns <- as.numeric(Vars[c(i,j),2])
	  sds <- as.numeric(Vars[c(i,j),3])
	  ntilde <- 1/mean(1/ns) 
	  md <- (mns[1]-mns[2])
	  sdp <- sqrt((ns[1]-1)*sds[1]^2+(ns[2]-1)*sds[2]^2)/sqrt(ns[1]+ns[2]-2)
	  cohend <- md/sdp
	  eta <- ns[1]+ns[2]-2
	  J <- gamma(eta/2)/(sqrt(eta/2)*gamma((eta-1)/2))
	  hedgesg <- cohend*J
	  r <- cor(varx,vary)
	  lambda <- hedgesg*sqrt(ntilde/(2*(1-r)))
	  tlow <- qt(1/2-conf.level/2,df=eta,ncp=lambda)
	  thig <- qt(1/2+conf.level/2,df=eta,ncp=lambda)
	  dlow <- tlow/lambda*hedgesg 
	  dhig <- thig/lambda*hedgesg 
    results[comp,] <- c(d=cohend,g=hedgesg,LL=dlow,UL=dhig)
  	comp <- comp+1
  }
  }
  round(results,3)
} 
 
.ciHgPairwise.formula <- function(formula,conf.level=.95,...){
  Groups <- .ciMeans(formula,...)
  nr <- dim(Groups)[1]
  rn <- rownames(Groups)
  ncomp <- (nr)*(nr-1)/2
  results <- data.frame(matrix(ncol=4,nrow=ncomp))
  colnames(results) <- c("d","g","LL","UL")
  comp <- 1
  for( i in 1:(nr-1) ){
  for( j in (i+1):nr ){
    rownames(results)[comp] <- paste(rn[i],"v",rn[j])
	  ns <- as.numeric(Groups[c(i,j),1])
	  mns <- as.numeric(Groups[c(i,j),2])
	  sds <- as.numeric(Groups[c(i,j),3])
	  ntilde <- 1/mean(1/ns) 
	  md <- (mns[1]-mns[2])
	  sdp <- sqrt((ns[1]-1)*sds[1]^2+(ns[2]-1)*sds[2]^2)/sqrt(ns[1]+ns[2]-2)
	  cohend <- md/sdp
	  eta <- ns[1]+ns[2]-2
	  J <- gamma(eta/2)/(sqrt(eta/2)*gamma((eta-1)/2))
	  hedgesg <- cohend*J
	  lambda <- hedgesg*sqrt(ntilde/2)
	  tlow <- qt(1/2-conf.level/2,df=eta,ncp=lambda)
	  thig <- qt(1/2+conf.level/2,df=eta,ncp=lambda)
	  dlow <- tlow/lambda*hedgesg 
	  dhig <- thig/lambda*hedgesg 
    results[comp,] <- c(d=cohend,g=hedgesg,LL=dlow,UL=dhig)
  	comp <- comp+1
  }
  }
  round(results,3)
}

hedgesMeans <- function(...){
  cat("\nCONFIDENCE INTERVALS FOR THE STANDARDIZED MEANS\n\n")
  print(.ciHgMeans(...))
  cat("\n")
}

hedgesDifference <- function(...) {
  cat("\nCONFIDENCE INTERVAL FOR THE STANDARDIZED COMPARISON\n\n")
  print(.ciHgDifference(...))
  cat("\n")  
}

hedgesPairwise <- function(...) {
  cat("\nCONFIDENCE INTERVAL FOR THE STANDARDIZED PAIRWISE COMPARISON\n\n")
  print(.ciHgPairwise(...))
  cat("\n")  
}

### Three Group Example Data

Group <- c(rep(1,3),rep(2,3),rep(3,3))
Outcome <- c(3,4,5,7,8,9,8,9,10)
Group <- factor(Group,levels=c(1,2,3),labels=c("Group1","Group2","Group3"))

hedgesMeans(Outcome~Group)
Comparison=factor(Group,c("Group1","Group2"))
hedgesDifference(Outcome~Comparison)
hedgesPairwise(Outcome~Group)

### Three Time Period Example Data

Time1 <- c(5,6,6,7,8)
Time2 <- c(7,7,8,8,9)
Time3 <- c(8,8,9,9,9)

hedgesMeans(Time1,Time2,Time3)
hedgesDifference(Time1,Time2)
hedgesPairwise(Time1,Time2,Time3)
