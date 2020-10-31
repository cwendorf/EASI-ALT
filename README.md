# altEASI

## The Other Version of EASI

### Overview

**altEASI** is an R package that implements features of estimation statistics (or the "new statistics"). It only uses raw data input (no summary statistics input), but has some other features that [**EASI**](https://cwendorf.github.io/EASI/) does not yet have. It is mostly a wrapper for built-in R functions and exists as a proof of concept before I develop the functions for [**EASI**](https://cwendorf.github.io/EASI/).

### Installation

This package is not currently on CRAN, but can be installed directly from the repository:

``` r
install.packages("devtools")
devtools::install_github("cwendorf/altEASI")
library(altEASI)
```

If you do not wish a full install, the functions can be sourced instead:

```r
source("http://raw.githubusercontent.com/cwendorf/altEASI/master/source-altEASI.R")
```

### Usage

The following vignettes are offered as tutorials. They show both the default output and the available options for estimation, confidence interval plots, and significance tests.

- The [_BetweenSubjectsVignette_](./docs/BetweenSubjectsVignette.md) analyzes data from a one-way between-subjects design.  
- The [_WithinSubjectsVignette_](./docs/WithinSubjectsVignette.md) analyzes data from a single-factor within-subjects design.  
- The [_RegressionVignette_](./docs/RegressionVignette.md) analyzes data from a single-factor within-subjects design. 

### Contact Me

- GitHub Issues: [https://github.com/cwendorf/altEASI/issues](https://github.com/cwendorf/altEASI/issues) 
- Author Email: [cwendorf@uwsp.edu](mailto:cwendorf@uwsp.edu)
- Author Homepage: [https://cwendorf.github.io](https://cwendorf.github.io)
