#' convert esummary like object into tibble
#'
#' @param x esummary object
#' @export
to_tibble <- function(x) UseMethod("to_tibble")

#' @rdname to_tibble
#' @export
to_tibble.esummary <- function(x) {
    tibble::tibble(
        uid = x$uid,
        sortpubdate = x$sortpubdate,
        elocationid = x$elocationid,
        sortfirstauthor = x$sortfirstauthor,
        lastauthor = x$lastauthor,
        source = x$source,
        sorttile = x$sorttitle
    )
}

#' @rdname to_tibble
#' @export
to_tibble.esummary_list <- function(x) {
    out <- purrr::map(x, as_tibble.esummary)
    out <- dplyr::bind_rows(out)
    if(length(out) == 0L) {
        out <- to_tibble.default()
    }
    out
}

#' @rdname to_tibble
#' @export
to_tibble.default <- function(x) {
    tibble::tibble(
        uid = "NA",
        sortpubdate = "NA",
        elocationid = "NA",
        sortfirstauthor = "NA",
        lastauthor = "NA",
        source = "NA",
        sorttile = "NA"
    )
}



#' search pubmed via rentrez
#'
#' this wrapper functions returns a tibble of the key variables
#' for each hit.
#'
#' @param term search term for pubmed
#' @param retmax integer Maximum number of hits returned by the search (passed down)
#' @examples
#'   # search_pubmed("GSE8305")
#' @export
search_pubmed <- function(term, retmax = 20) {
    # fetch ids of matches
    ids <- rentrez::entrez_search("pubmed", term = term, retmax = retmax)[["ids"]]
    # fetch esummaries
    res <- purrr::map(ids, ~rentrez::entrez_summary("pubmed", id = .x))
    # parse results
    res <- purrr::map(res, to_tibble)
    if(length(res) == 0) {
        res <- list(to_tibble.default(res))
    }
    res <- dplyr::bind_rows(res)
    res <- dplyr::mutate(res, term = term)
    dplyr::select(res, term, dplyr::everything())
}

