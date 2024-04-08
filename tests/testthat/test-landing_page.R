# library(testthat); source("test-landing_page.R")

test_that(".landing_page works", {
    out <- iSEElogin:::.landing_page()
    expect_type(out, "closure")
})

test_that(".create_persistent_objects works", {
    out <- iSEElogin:::.create_persistent_objects()
    expect_identical(ls(out), character(0))
})
