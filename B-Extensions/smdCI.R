# EASI: Estimation Approach to Statistical Inference
## Extensions Under Development
### TO INSTALL, SIMPLY COPY AND PASTE CONTENTS OF THIS ENTIRE FILE INTO R

### Functions for Confidence Interval of Cohens d based on Approximated NCP

.smd <- function(y,conf.level=.95,...){
  model=t.test(y,...)
  mu=as.numeric(model$null.value)
  MD=as.numeric(model$estimate-mu)
  SD=sd(y,na.rm=TRUE)  
  t=as.numeric(model$statistic)
  df=as.numeric(model$parameter)
  alpha=1-conf.level
  CD=MD/SD
  CDU=(1-3/(4*df-1))*CD
  SE=sqrt((df+2)/(length(y)^2)+((CD^2)/(2*(df+2))))
  k=exp(((log(2)-log(df))/2)+lgamma((df+1)/2)-lgamma(df/2))
  m=t*k
  v=1+(t^2)*(1-k^2)
  w=(2*m^3)-((2*df-1)/df)*(t^2*m)
  skew=abs(w/sqrt(v)^3)
  sdz=sqrt(v)
  llz=qnorm(1-alpha/2,lower.tail=FALSE)
  ulz=qnorm(1-alpha/2)
  ll1=m+sdz*llz
  ul1=m+sdz*ulz
  c=w/(4*v)
  q=v/(2*c^2)
  a=m-(q*c)
  llp=2*(qgamma(alpha/2,q/2,rate=1))
  ulp=2*(qgamma(1-alpha/2,q/2,rate=1))
  ll2=if(t>0) {a+c*llp} else {a+c*ulp}
  ul2=if(t>0) {a+c*ulp} else {a+c*llp}
  LL=if(skew<.001) {LL=ll1*sqrt(1/length(y))} else {LL=ll2*sqrt(1/length(y))}
  UL=if(skew<.001) {UL=ul1*sqrt(1/length(y))} else {UL=ul2*sqrt(1/length(y))} 
  results=round(c(d=CD,"d(unb)"=CDU,df=df,SE=SE,LL=LL,UL=UL),3)
  return(results)
}

.smdMeans <- function(...) 
  UseMethod(".smdMeans")

.smdMeans.default <- function(...,conf.level=.95,mu=0){
  df=data.frame(...)
  results=data.frame(matrix(ncol=6,nrow=0))
  for (i in 1:ncol(df)) results[i,]=.smd(df[,i],conf.level=conf.level,mu=mu)
  colnames(results)=cbind("d","d(unb)","df","SE","LL","UL")
  rownames(results)=colnames(df)
  return(results)
}

.smdMeans.formula <- function(formula,...) {
  results=aggregate(formula,FUN=.smd,...)
  colnames(results)=c("Group","")
  rownames(results)=results[,1]
  results=results[2]
  return(results)
}

.smdDifference <- function(...) 
  UseMethod(".smdDifference")

.smdDifference.default <- function(...,conf.level=.95,mu=0){
  model=t.test(...,paired=TRUE)
  mu=as.numeric(model$null.value) 
  t=as.numeric(model$statistic)
  df=as.numeric(model$parameter)
  R=cor(...)
  Groups=.ciMeans(...)
  rn=Groups[2:1,1]
  Groups=Groups[1:2,1:3]
  MD=Groups[1,2][[1]]-Groups[2,2][[1]]-mu
  df1=Groups[1,1][[1]]-1
  df2=Groups[2,1][[1]]-1
  alpha=1-conf.level
  SD=sqrt((Groups[1,3][[1]]^2+Groups[2,3][[1]]^2)/2)
  CD=MD/SD
  CDU=(1-3/(4*df-1))*CD
  SE=sqrt((1/(df+1))+((CD^2)/(2*(df+1)))*2*(1-R))
  k=exp(((log(2)-log(df))/2)+lgamma((df+1)/2)-lgamma(df/2))
  m=t*k
  v=1+(t^2)*(1-k^2)
  w=(2*m^3)-((2*df-1)/df)*(t^2*m)
  skew=abs(w/sqrt(v)^3)
  sdz=sqrt(v)
  llz=qnorm(1-alpha/2,lower.tail=FALSE)
  ulz=qnorm(1-alpha/2)
  ll1=m+sdz*llz
  ul1=m+sdz*ulz
  c=w/(4*v)
  q=v/(2*c^2)
  a=m-(q*c)
  llp=2*(qgamma(alpha/2,q/2,rate=1))
  ulp=2*(qgamma(1-alpha/2,q/2,rate=1))
  ll2=if(t>0) {a+c*llp} else {a+c*ulp}
  ul2=if(t>0) {a+c*ulp} else {a+c*llp}
  LL=if(skew<.001) {LL=ll1*sqrt(1/(df+1))} else {LL=ll2*sqrt(1/(df+1))}
  UL=if(skew<.001) {UL=ul1*sqrt(1/(df+1))} else {UL=ul2*sqrt(1/(df+1))} 
  results=round(c(d=CD,"d(unb)"=CDU,df=df,SE=SE,LL=LL,UL=UL),3)
  return(results)
}

.smdDifference.formula <- function(formula,conf.level=.95,...){
  model=t.test(formula,...)
  mu=as.numeric(model$null.value)
  Groups=.ciMeans(formula,...)
  rn=Groups[2:1,1]
  Groups=Groups[1:2,1:3]
  MD=Groups[1,2][[1]]-Groups[2,2][[1]]-mu
  df1=Groups[1,1][[1]]-1
  df2=Groups[2,1][[1]]-1
  t=as.numeric(model$statistic)
  df=as.numeric(model$parameter)
  alpha=1-conf.level
  SD=(df1*Groups[1,3][[1]]^2+df2*Groups[2,3][[1]]^2)/(df)
  CD=MD/SD
  CDU=(1-3/(4*df-1))*CD
  SE=sqrt((df+2)/((df1+1)*(df2+1))+((CD^2)/(2*(df+2))))
  k=exp(((log(2)-log(df))/2)+lgamma((df+1)/2)-lgamma(df/2))
  m=t*k
  v=1+(t^2)*(1-k^2)
  w=(2*m^3)-((2*df-1)/df)*(t^2*m)
  skew=abs(w/sqrt(v)^3)
  sdz=sqrt(v)
  llz=qnorm(1-alpha/2,lower.tail=FALSE)
  ulz=qnorm(1-alpha/2)
  ll1=m+sdz*llz
  ul1=m+sdz*ulz
  c=w/(4*v)
  q=v/(2*c^2)
  a=m-(q*c)
  llp=2*(qgamma(alpha/2,q/2,rate=1))
  ulp=2*(qgamma(1-alpha/2,q/2,rate=1))
  ll2=if(t>0) {a+c*llp} else {a+c*ulp}
  ul2=if(t>0) {a+c*ulp} else {a+c*llp}
  LL=if(skew<.001) {LL=ll1*sqrt(1/(df1+1)+1/(df2+1))} else {LL=ll2*sqrt(1/(df1+1)+1/(df2+1))}
  UL=if(skew<.001) {UL=ul1*sqrt(1/(df1+1)+1/(df2+1))} else {UL=ul2*sqrt(1/(df1+1)+1/(df2+1))} 
  results=round(c(d=CD,"d(unb)"=CDU,df=df,SE=SE,LL=LL,UL=UL),3)
  return(results)
}

effectMeans <- function(...){
  cat("\nCONFIDENCE INTERVALS FOR THE STANDARDIZED MEANS\n\n")
  print(.smdMeans(...))
  cat("\n")
}

effectDifference <- function(...) {
  cat("\nCONFIDENCE INTERVAL FOR THE STANDARDIZED COMPARISON\n\n")
  print(.smdDifference(...))
  cat("\n")  
}

### Three Group Example Data

Group <- c(rep(1,3),rep(2,3),rep(3,3))
Outcome <- c(3,4,5,7,8,9,8,9,10)
Group <- factor(Group,levels=c(1,2,3),labels=c("Group1","Group2","Group3"))

effectMeans(Outcome~Group)
Comparison=factor(Group,c("Group1","Group2"))
effectDifference(Outcome~Comparison)

### Three Time Period Example Data

Time1 <- c(5,6,6,7,8)
Time2 <- c(7,7,8,8,9)
Time3 <- c(8,8,9,9,9)

effectMeans(Time1,Time2,Time3)
effectDifference(Time1,Time2)
