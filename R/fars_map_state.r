#' Plot accidents happened in a certain State and year
#'
#' This function reads the correspondent file for the specified year
#' checks the specified State number and if it is present outputs the State map
#' and where the accidents have happened.
#' Files should be in working directory.
#'
#'  @param state.num a number/character string for the State you are looking for
#'  @param year a number/character string for the year
#'
#'  @return This function plots a map with points where accidents happened.
#'  Nothing is returned in the environment
#'
#'  @section Warning:
#'  The function checks for valid \code{state.num} otherwise it throws an error.
#'  The function doesn't accept more than one state number or year.
#'
#'  @importFrom dplyr filter
#'  @importFrom maps map
#'  @importFrom graphics points
#'
#'  @examples
#'  \dontrun{fars_map_state("1","2013")
#' fars_map_state("3","2014") #this shows the error}
#'
#' @export
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)

  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter(data, STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}
