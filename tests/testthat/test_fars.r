expect_that(make_filename(2013, demo = TRUE), is_a("character"))
expect_that(fars_read(make_filename(2013, demo = TRUE)), is_a("tbl_df"))
