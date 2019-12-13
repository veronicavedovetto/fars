#' Create standardized filename
#'
#'  This function create a standard naming for a zipped csv file
#'
#'@param year a character/numeric value reporting the year of file
#'  that you want to read
#'
#'@return a character string with the name for zipped csv files
#'
#' @examples
#' make_filename("2010")
#' make_filename(2010)
#'
#'@export
make_filename <- function(year) {
  year <- as.integer(year)
  sprintf("accident_%d.csv.bz2", year)
}
