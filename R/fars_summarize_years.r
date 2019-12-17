#' Summary of the number of observations per month and year in the imported file/s
#'
#' This function counts the number of observations by months for the specified file/s.
#' Files should be in working directory.
#'
#' @param years a character or numeric value, a vector or a list of years
#' @param demo logical if you want to use the function with demo data that comes with the package.
#'  Default to FALSE
#'
#' @return a tibble showing the number of observations by month for the imported files.
#'  Each file read is one column of the tibble.
#'
#' @import magrittr
#' @import dplyr
#' @importFrom tidyr spread
#'
#' @examples
#' \dontrun{acc_summ <- fars_summarize_years(2013:2015)
#' acc_2015 <- fars_summarize_years("2015")}
#'
#'#'@include make_filename.r fars_read.r fars_read_years.r
#' @export
fars_summarize_years <- function(years, demo = FALSE) {
  dat_list <- fars_read_years(years, demo = demo)
  dplyr::bind_rows(dat_list) %>%
    dplyr::group_by(year, MONTH) %>%
    dplyr::summarize(n = n()) %>%
    tidyr::spread(year, n)
}
