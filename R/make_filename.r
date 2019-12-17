#' Create standardized filename
#'
#'  This function create a standard naming for a zipped csv file
#'
#'@param year a character/numeric value reporting the year of file
#'  that you want to read
#'
#'@param demo logical if you want to use the function with demo data that comes with the package.
#' Default to FALSE
#'
#'@return a character string with the name for zipped csv files
#'
#' @examples
#' make_filename("2010")
#' make_filename(2010)
#'
#'@export
make_filename <- function(year, demo = FALSE) {
  year <- as.integer(year)
  nome_file <- sprintf("accident_%d.csv.bz2", year)

  if (demo == TRUE) {
    return(system.file("extdata", nome_file, package="fars"))
  } else {
    return(nome_file)
  }
}
