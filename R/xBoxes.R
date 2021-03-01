# Estimation Approach to Statistical Inference
## Data Summaries and Box Plots

### Summary Functions

.fnsBoxes <- function(x,...)
  UseMethod(".fnsBoxes")

.fnsBoxes.default <- function(...) {
  data <- data.frame(...)
  results <- do.call(rbind,lapply(data,function(x) boxplot.stats(x)$stats))
  colnames(results) <- c("Min","LQ","Mdn","UQ","Max")
  round(results,3)
}

.fnsBoxes.formula <- function(formula,...) {
  results <- aggregate(formula,FUN=.fnsBoxes,...)
  rn <- results[[1]]
  results <- results[[2]]
  rownames(results) <- rn
  colnames(results) <- c("Min","LQ","Mdn","UQ","Max")
  round(results,3)
}

.fnsBoxes.lm <- function(object,...) {
  formula <- object$terms
  .fnsBoxes(formula,...)
}

describeBoxes <- function(...){
  cat("\nBOX PLOT SUMMARIES FOR THE DATA\n\n")
  print(.fnsBoxes(...))
  cat("\n")
}

#### Plot Functions for Boxes

plotBoxes <- function(...) 
  UseMethod("plotBoxes")

plotBoxes.default <- function(...,main=NULL,ylab="Outcome",xlab="") {
  if(is.null(main)) {main="Boxplots for the Data"}
  data <- data.frame(...)
  par(bty="l")
  boxplot(data,boxwex=.15,cex=1.5,cex.lab=1.3,xlab=xlab,ylab=ylab,main=main,...)
}  

plotBoxes.formula <- function(formula,main=NULL,ylab="Outcome",xlab="",...) {
  if(is.null(main)) {main="Boxplots for the Data"}
  par(bty="l")
  boxplot(formula,boxwex=.15,cex=1.5,cex.lab=1.3,xlab=xlab,ylab=ylab,main=main,...)
}
