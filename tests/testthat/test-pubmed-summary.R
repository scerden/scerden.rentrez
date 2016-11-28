context("retrieving pubmed summaries")

test_that("inputs and outputs consistent", {

    # 0length input
    x <- pubmed_summary(ids =vector("character",  0L))
    expect_length(x, 7)
    expect_equal(nrow(x) , 0L)
    # 1/2+ lenght
    x <- pubmed_summary("23158682")
    expect_equal(nrow(x), 1)
    x <- pubmed_summary(c("26586442", "26119342"))
    expect_equal(nrow(x), 2)
    # handle na
    x <- pubmed_summary(NA)
    expect_length(x, 7)
    expect_equal(nrow(x) , 1)
    x <- pubmed_summary(NA_character_)
    expect_length(x, 7)
    expect_equal(nrow(x) , 1)
    # error on null
    expect_error(pubmed_summary(NULL))

})
