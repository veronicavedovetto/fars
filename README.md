
<!-- README.md is generated from README.Rmd. Please edit that file -->
fars
====

<!-- badges: start -->
<!-- badges: end -->
The goal of fars is to provide some functions to analyse data from the [US National Highway Traffic Safety Administration's Fatality Analysis Reporting System](https://www.nhtsa.gov/research-data), which is a nationwide census providing the American public yearly data regarding fatal injuries suffered in motor vehicle traffic crashes.

In the package there are 3 exemplificative files of how the data looks like and that can be used to have a better idea of how the functions work.

Installation
------------

You can install the released version of fars from [GitHub](https://github.com/) with:

``` r
install_github("nome da inserire", build_vignettes = TRUE)
```

How to use fars
---------------

This is a basic example which shows you how to import one of the file with collected data and obtain a summary for the number of monthly accidents happened in two years:

``` r
library(fars)

fars_summarize_years(2013:2014, demo = TRUE)
#> # A tibble: 12 x 3
#>    MONTH `2013` `2014`
#>    <dbl>  <int>  <int>
#>  1     1   2230   2168
#>  2     2   1952   1893
#>  3     3   2356   2245
#>  4     4   2300   2308
#>  5     5   2532   2596
#>  6     6   2692   2583
#>  7     7   2660   2696
#>  8     8   2899   2800
#>  9     9   2741   2618
#> 10    10   2768   2831
#> 11    11   2615   2714
#> 12    12   2457   2604
```

`demo = TRUE` will tell the function to use the data provided with the package as an example. If you want to use new downloaded data set it to FALSE (default value) and put the zipped files in the working directory.

You can also plot where accidents have happened with the following function:

``` r
fars_map_state(1, 2013, demo = TRUE)
```

<img src="man/figures/README-map_state-1.png" width="100%" />

You should indicate the number of the state and the year to be visualized.
