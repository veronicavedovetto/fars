#' Read external csv file
#'
#' This function check the existence of the csv file and if it exists read it into a tibble.
#' You need to specify the name of the file in the \code{filename} argument.
#' The function looks for the file in the wd.
#'
#' @param filename A character string giving the path to the csv file.
#'
#' @section Warning:
#' This function check for the existence of the specified file.
#' If the file doesn't exist it stops and throws an error.
#'
#' @return This function returns the csv file in tibble format.
#'
#' @examples
#' \dontrun{df <- fars_read("name_of_the_file.csv")}
#'
#' @importFrom readr read_csv
#' @importFrom dplyr tbl_df
#'
#' @export
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  dplyr::tbl_df(data)
}
