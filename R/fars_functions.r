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

#' Import yearly accident csv files
#'
#' This function takes one or more years as input, imports the related csv file(s)
#' creates a new column called year and returns MONTH and year variables as a tibble.  
#'
#' @param years a character/numeric string, vector or list of years
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
fars_read_years <- function(years) {
  lapply(years, function(year) {
    file <- make_filename(year)
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

#' Summary of the number of observations per month and year in the imported file/s
#' 
#' This function counts the number of observations by months for the specified file/s.
#' Files should be in working directory.
#' 
#' @param years a character or numeric value, a vector or a list of years
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
#' @export
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>% 
    dplyr::group_by(year, MONTH) %>% 
    dplyr::summarize(n = n()) %>%
    tidyr::spread(year, n)
}

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
