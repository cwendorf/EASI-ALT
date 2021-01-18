# EASI: Estimation Approach to Statistical Inference
## Alternate Extensions Under Development
### TO INSTALL, SIMPLY COPY AND PASTE CONTENTS OF THIS ENTIRE FILE INTO R

### Pairwise Tukey Comparisons

.ciHSD <- function(formula,conf.level=.95,...){
  model=aov(formula,...)
  results=round(TukeyHSD(model,conf.level=conf.level)[[1]][,1:3],3)
  colnames(results)=c("Diff","LL","UL")
  results
}

estimateHSD <- function(...) {
  cat("\nCONFIDENCE INTERVALS FOR TUKEY HSD COMPARISONS\n\n")
  print(.ciHSD(...)) 
  cat("\n")  
}

.nhstHSD <- function(formula,conf.level=.95,...){
  model=aov(formula,...)
  results=round(TukeyHSD(model,conf.level=conf.level)[[1]][,c(1,4)],3)
  colnames(results)=c("Diff","p adj")
  results
}

testHSD <- function(...) {
  cat("\nHYPOTHESIS TESTS FOR TUKEY HSD COMPARISONS\n\n")
  print(.nhstHSD(...)) 
  cat("\n")  
}

### Three Group Example Data

Group <- c(rep("Group1",3),rep("Group2",3),rep("Group3",3))
Outcome <- c(3,4,5,7,8,9,8,9,10)
Group <- factor(Group)

estimateHSD(Outcome~Group)
testHSD(Outcome~Group)
