# library(testthat); source("test-iSEEindex.R")

# iSEEindex ----

test_that("iSEElogin works", {

    out <- iSEElogin()
    expect_s3_class(out, "shiny.appobj")

})
