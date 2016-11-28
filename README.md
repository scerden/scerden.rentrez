
<!-- README.md is generated from README.Rmd. Please edit that file -->
scerden.rentrez
===============

Very small wrapper around `rentrez` R pkg from ropensci.

install
-------

``` r
devtools::install_github("scerden/scerden.rentrez")
```

Pkg makes avaiable 2 functions:
1. `pubmed_search()` searches pubmed and returns a (character vector of) the matching db id(s).
2. `pubmed_summary()` returns a tibble of useful variables, one row per input id.

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

"topoisomerase" %>% pubmed_search(retmax = 10)
#>  [1] "27884651" "27879063" "27875523" "27872982" "27872075" "27871365"
#>  [7] "27871039" "27860204" "27856347" "27854277"
"topoisomerase" %>% pubmed_search(retmax = 10, verbose = T) # troubleshooting
#> # rentrez::entrez_search("pubmed", term = ., retmax = 10) 
#> # List of 5
#> #  $ ids             : chr [1:10] "27884651" "27879063" "27875523" "27872982" ...
#> #  $ count           : int 17171
#> #  $ retmax          : int 10
#> #  $ QueryTranslation: chr "topoisomerase[All Fields]"
#> #  $ file            :Classes 'XMLInternalDocument', 'XMLAbstractDocument' <externalptr> 
#> #  - attr(*, "class")= chr [1:2] "esearch" "list"
#>  [1] "27884651" "27879063" "27875523" "27872982" "27872075" "27871365"
#>  [7] "27871039" "27860204" "27856347" "27854277"
"topoisomerase" %>% pubmed_search(retmax = 10) %>% pubmed_summary()
#> # A tibble: 10 × 7
#>         uid      sortpubdate
#>       <chr>            <chr>
#> 1  27884651 2016/11/21 00:00
#> 2  27879063 2016/11/23 00:00
#> 3  27875523 2016/11/22 00:00
#> 4  27872982 2016/11/21 00:00
#> 5  27872075 2016/11/21 00:00
#> 6  27871365 2016/11/17 00:00
#> 7  27871039 2016/11/08 00:00
#> 8  27860204 2016/11/08 00:00
#> 9  27856347 2016/11/14 00:00
#> 10 27854277 2016/11/15 00:00
#> # ... with 5 more variables: elocationid <chr>, sortfirstauthor <chr>,
#> #   lastauthor <chr>, source <chr>, sorttile <chr>

series_ids <- c("GSE41494", "GSE68016", "GSE8305") # geo series ids for which you want to track down citing papers
res <- tibble(gse = series_ids, 
              pmid = map(gse, pubmed_search),
              psummary = map(pmid, pubmed_summary))
res
#> # A tibble: 3 × 3
#>        gse      pmid         psummary
#>      <chr>    <list>           <list>
#> 1 GSE41494 <chr [1]> <tibble [1 × 7]>
#> 2 GSE68016 <chr [2]> <tibble [2 × 7]>
#> 3  GSE8305 <chr [0]> <tibble [0 × 7]>
res %>% unnest()
#> # A tibble: 3 × 9
#>        gse     pmid      uid      sortpubdate
#>      <chr>    <chr>    <chr>            <chr>
#> 1 GSE41494 23158682 23158682 2012/11/18 00:00
#> 2 GSE68016 26586442 26586442 2015/11/24 00:00
#> 3 GSE68016 26119342 26119342 2015/07/02 00:00
#> # ... with 5 more variables: elocationid <chr>, sortfirstauthor <chr>,
#> #   lastauthor <chr>, source <chr>, sorttile <chr>
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
