# EASIalt

## The Alternative Version of EASI

### Overview

**EASIalt** is an R package that implements features of estimation statistics. It only uses raw data input (no summary statistics input), but has some other features that [**EASI**](https://cwendorf.github.io/EASI/) does not yet have. It is mostly a wrapper for built-in R functions and exists as a proof of concept before I develop the functions for [**EASI**](https://cwendorf.github.io/EASI/).

### Installation

This package is not currently on CRAN, but the latest stable release can be installed from GitHub:

```r
install.packages("devtools")
devtools::install_github("cwendorf/EASIalt@*release",build_vignettes=TRUE)
library(EASIalt)
```

To get a bug fix or to use the newest features, install the development version from GitHub:

``` r
install.packages("devtools")
devtools::install_github("cwendorf/EASIalt")
library(EASIalt)
```

If you do not wish a full install, the latest functions can be sourced directly from GitHub:

```r
source("http://raw.githubusercontent.com/cwendorf/EASIalt/main/sourceEASIalt.R")
```

### Usage

The following vignettes are offered as tutorials. They show both the default output and the available options for estimation, confidence interval plots, and significance tests.

- The [_BetweenSubjectsVignette_](./docs/BetweenSubjectsVignette.md) analyzes data from a one-way between-subjects design.  
- The [_WithinSubjectsVignette_](./docs/WithinSubjectsVignette.md) analyzes data from a single-factor within-subjects design.  
- The [_RegressionVignette_](./docs/RegressionVignette.md) analyzes data from a multiple-variable design. 

### Contact Me

- GitHub Issues: [https://github.com/cwendorf/EASIalt/issues](https://github.com/cwendorf/EASIalt/issues) 
- Author Email: [cwendorf@uwsp.edu](mailto:cwendorf@uwsp.edu)
- Author Homepage: [https://cwendorf.github.io](https://cwendorf.github.io)
