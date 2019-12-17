#' Import yearly accident csv files
#'
#' This function takes one or more years as input, imports the related csv file(s)
#' creates a new column called year and returns MONTH and year variables as a tibble.
#'
#' @param years a character/numeric string, vector or list of years
#' @param demo logical if you want to use the function with demo data that comes with the package.
#'  Default to FALSE
#'
#' @return a list. Each element of the list could be a tibble if the function finds a csv corresponding to
#' the year, or NULL if the csv file is not present.
#'
#' @import magrittr
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#'
#' @examples
#' \dontrun{acc_list <- fars_read_years(2013:2015)
#' acc <- fars_read_years("2015")}
#'
#' @export
fars_read_years <- function(years, demo = FALSE) {
  lapply(years, function(year) {
    file <- make_filename(year, demo = demo)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate(dat, year = year) %>%
        dplyr::select(MONTH, year)
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}
