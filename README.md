
<!-- README.md is generated from README.Rmd. Please edit that file -->
scerden.rentrez
===============

Very small wrapper around `rentrez` R pkg from ropensci.

install
-------

``` r
devtools::install_github("scerden/scerden.rentrez")
```

demo
----

``` r
library(scerden.rentrez)
library(tidyverse)
#> Loading tidyverse: ggplot2
#> Loading tidyverse: tibble
#> Loading tidyverse: tidyr
#> Loading tidyverse: readr
#> Loading tidyverse: purrr
#> Loading tidyverse: dplyr
#> Conflicts with tidy packages ----------------------------------------------
#> filter(): dplyr, stats
#> lag():    dplyr, stats
search_pubmed(term = "topoisomerase")
#> # A tibble: 20 × 8
#>             term      uid      sortpubdate
#>            <chr>    <chr>            <chr>
#> 1  topoisomerase 27879063 2016/11/23 00:00
#> 2  topoisomerase 27875523 2016/11/22 00:00
#> 3  topoisomerase 27872982 2016/11/21 00:00
#> 4  topoisomerase 27872075 2016/11/21 00:00
#> 5  topoisomerase 27871365 2016/11/17 00:00
#> 6  topoisomerase 27871039 2016/11/08 00:00
#> 7  topoisomerase 27860204 2016/11/08 00:00
#> 8  topoisomerase 27856347 2016/11/14 00:00
#> 9  topoisomerase 27854277 2016/11/15 00:00
#> 10 topoisomerase 27852319 2016/11/16 00:00
#> 11 topoisomerase 27852227 2016/11/16 00:00
#> 12 topoisomerase 27840583 2016/11/06 00:00
#> 13 topoisomerase 27837087 2016/11/11 00:00
#> 14 topoisomerase 27836599 2016/11/04 00:00
#> 15 topoisomerase 27836197 2016/11/03 00:00
#> 16 topoisomerase 27834128 2016/11/09 00:00
#> 17 topoisomerase 27830758 2016/11/10 00:00
#> 18 topoisomerase 27829297 2016/11/10 00:00
#> 19 topoisomerase 27825925 2016/11/05 00:00
#> 20 topoisomerase 27825797 2016/11/05 00:00
#> # ... with 5 more variables: elocationid <chr>, sortfirstauthor <chr>,
#> #   lastauthor <chr>, source <chr>, sorttile <chr>
series_ids <- c("GSE41494", "GSE68016", "GSE8305") # geo series ids for which you want to track down citing papers
map_df(series_ids, search_pubmed)
#> # A tibble: 4 × 8
#>       term      uid      sortpubdate                       elocationid
#>      <chr>    <chr>            <chr>                             <chr>
#> 1 GSE41494 23158682 2012/11/18 00:00   doi: 10.1186/gb-2012-13-11-r106
#> 2 GSE68016 26586442 2015/11/24 00:00 doi: 10.1016/j.celrep.2015.10.030
#> 3 GSE68016 26119342 2015/07/02 00:00   doi: 10.1016/j.cell.2015.05.048
#> 4  GSE8305       NA               NA                                NA
#> # ... with 4 more variables: sortfirstauthor <chr>, lastauthor <chr>,
#> #   source <chr>, sorttile <chr>
```

pkg creation:
-------------

-   Prelims

``` r
use_readme_rmd()
use_data_raw()
```

-   when writing `./R` fxns

``` r
use_package("tibble")
use_package("rentrez")
use_package("dplyr")
use_package("purrr")
```
