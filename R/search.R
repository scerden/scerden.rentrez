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
    out <- purrr::map(x, to_tibble.esummary)
    out <- dplyr::bind_rows(out)
    if(length(out) == 0L) {
        out <- to_tibble.default()
    }
    out
}

#' @rdname to_tibble
#' @export
to_tibble.default <- function(x) {
    # should only end up down here if
    # empty character or NA so:
    if(length(x) == 0){
        y <- vector("character", 0L)
    }else if(is.na(x)) {
        y <- NA_character_
    }
    tibble::tibble(
        uid = y,
        sortpubdate = y,
        elocationid = y,
        sortfirstauthor = y,
        lastauthor = y,
        source = y,
        sorttile = y
    )
}



#' search pubmed via rentrez
#'
#' this wrapper functions returns a tibble of the key variables
#' for each hit.
#'
#' @param term search term for pubmed
#' @param retmax integer Maximum number of hits returned by the search (passed down)
#' @param verbose logical, if T will display request and response via rentrez::entrez_search
#' @return
#'     a character vector of one or more ids matching search or NA
#' @examples
#'   # pubmed_search("GSE8305")
#' @export
pubmed_search <- function(term, retmax = "1000000", verbose = F) {
    # validate input
    if(is.null(term)) stop("term cannot be null.") # handle NULL
    if(is.na(term)) return(NA_character_) # handle NA

    esearch <- rentrez::entrez_search("pubmed", term = term, retmax = retmax)

    # verbose shows call and result str
    if(verbose) {
        cat("#", deparse(substitute(rentrez::entrez_search("pubmed", term = term, retmax = retmax))), '\n')
        cat(paste0("# ", capture.output(str(esearch)), collapse ='\n'))
    }

    # for consistent output type, if no ids found return empty 0L chr
    if(length(esearch$ids) == 0) {
        return(vector("character", 0L))
    }
    esearch$ids
}

#' get summary tibble matching one or more pubmed ids
#'
#'
#' @param ids character vector of pubmed db ids, such as returned from pubmed_search()
#' @return a tibble with uid, sortpubdate, elocationid, sortfirstauthor, lastauthot,
#'  source, and sorttitle vars of length(ids) observations.
#'
#' @export
pubmed_summary <- function(ids) {
    # validate input
    if(is.null(ids)) stop("ids cannot be null.") # handle NULL
    # NA handling built in
    res <- purrr::map_if(ids, ~!is.na(.x), ~rentrez::entrez_summary("pubmed", id = .x))
    # handle 0-length res (if ids is 0-length)
    if(length(res) == 0) {
        return(to_tibble(res))
    }
    # for when length ids >= 1
    res <- purrr::map(res, to_tibble)
    dplyr::bind_rows(res)
}
