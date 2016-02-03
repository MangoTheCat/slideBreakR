#' Table splitter
#'
#' Splits a large table into smaller tables based on a maximum number of rows
#' 
#' @param df Data frame to split
#' @param maxRows The maximum number of rows for the new table(s)
#' 
#' @return A list of tables
#' 
#' @export
#' 
#' @examples splitTable(airquality, maxRows = 50)
#' 
splitTable <- function(df, maxRows = 74) {
  totalRows <- nrow(df)
  
  # Tables and lengths
  nFullTables <- floor(totalRows / maxRows)
  lengthLastTable <- totalRows %% maxRows
  
  # Create vector of assignment to tables
  fullTableRows <- NULL
  if (nFullTables > 0) {
    fullTableRows <- rep(1:nFullTables, each = maxRows)
  }
  partialTableRows <- rep(nFullTables + 1, lengthLastTable)
  rowSplit <- c(fullTableRows, partialTableRows)
  
  # Split data
  split(df, rowSplit)
  
}