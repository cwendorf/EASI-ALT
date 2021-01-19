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
  an <- anova(model)
  results <- data.frame(an$`Sum Sq`,an$Df,an$`Mean Sq`,an$`F value`,an$`Pr(>F)`)
  colnames(results) <- c("SS","df","MS","F","p")
  rownames(results) <- c("Model","Residuals")
  results= round(results,3)
  results["Residuals","F"]=""
  results["Residuals","p"]=""
  results  
}

.nhstANOVA.formula <- function(formula,...){
  model <- lm(formula,...)
  an <- anova(model)
  results <- data.frame(an$`Sum Sq`,an$Df,an$`Mean Sq`,an$`F value`,an$`Pr(>F)`)
  colnames(results) <- c("SS","df","MS","F","p")
  rownames(results) <- c("Model","Residuals")
  results <- round(results,3)
  results["Residuals","F"]=""
  results["Residuals","p"]=""
  results
}

testANOVA <- function(...){
  cat("\nANALYSIS OF VARIANCE\n\n")
  print(.nhstANOVA(...))
  cat("\n")
}
