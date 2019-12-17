## Test for package fars
library(testthat)
expect_that(class(make_filename(2013, demo = TRUE)), is_a("character"))
expect_that(class(fars_read(make_filename(2013, demo = TRUE))), is_a("tbl_df"))
