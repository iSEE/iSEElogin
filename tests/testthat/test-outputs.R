# library(testthat); source("test-outputs.R")

# .render_login_form ----

test_that(".render_login_form works", {
    df <- data.frame()
    output <- new.env()
    pObjects <- new.env()
    rObjects <- new.env()

    out <- iSEElogin:::.render_login_form(output, pObjects, rObjects)

    expect_null(out)
    expect_named(output, "iSEElogin_form")
})
