context("searching pubmed")

test_that("inputs and outputs consistent", {

    # 0 length result
    expect_equal(pubmed_search("GSE8305"), vector("character", 0L))

    # length 1 result
    # "GSE41494" %>% pubmed_search() %>% str()

    # >= 2 results
    # "GSE68016" %>% pubmed_search() %>% str()

    # error on null
    expect_error(pubmed_search(NULL))
    # handles NA
    expect_equal(pubmed_search(NA), NA_character_)
    expect_equal(pubmed_search(NA_character_), NA_character_)

})
