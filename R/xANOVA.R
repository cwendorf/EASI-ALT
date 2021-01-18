# Estimation Approach to Statistical Inference
## ANOVA Functions

### ANOVA Omnibus Function

.nhstANOVA <- function(x,...) 
  UseMethod(".nhstANOVA")

.nhstANOVA.default <- function(...){
  data <- data.frame(...)
  columns <- dim(data)[2]
  dataLong <- reshape(data,varying=1:columns,v.names="Outcome",timevar="Variables",idvar="Subjects",direction="long")
  dataLong$Subjects <- as.factor(dataLong$Subjects)
  dataLong$Variables <- as.factor(dataLong$Variables)
  model <- lm(Outcome~Variables+Subjects,data=dataLong)
  anova(model)
}

.nhstANOVA.formula <- function(formula,...){
  model <- lm(formula,...)
  anova(model)
}

testANOVA <- function(...){
  cat("\nANALYSIS OF VARIANCE\n\n")
  print(.nhstANOVA(...))
  cat("\n")
}
