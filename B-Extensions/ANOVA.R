# EASI: Estimation Approach to Statistical Inference
## Extensions Under Development
### TO INSTALL, SIMPLY COPY AND PASTE CONTENTS OF THIS ENTIRE FILE INTO R

### ANOVA Omnibus Function

testANOVA <- function(...) 
  UseMethod("testANOVA")

testANOVA.default <- function(...){
  data <- data.frame(...)
  columns <- dim(data)[2]
  dataLong <- reshape(data,varying=1:columns,v.names="Outcome",timevar="Variables",idvar="Subjects",direction="long")
  dataLong$Subjects <- as.factor(dataLong$Subjects)
  dataLong$Variables <- as.factor(dataLong$Variables)
  results <- aov(Outcome~Variables+Error(Subjects),data=dataLong)
  summary(results)
}

testANOVA.formula <- function(formula,...){
  model <- aov(formula,...)
  summary(model)
}

### Three Group Example Data

Group <- c(rep(1,3),rep(2,3),rep(3,3))
Outcome <- c(3,4,5,7,8,9,8,9,10)
Group <- factor(Group)

testANOVA(Outcome~Group)

### Within Subjects Example Data

Time1 <- c(5,6,6,7,8)
Time2 <- c(7,7,8,8,9)
Time3 <- c(8,8,9,9,9)

testANOVA(Time1,Time2,Time3)
