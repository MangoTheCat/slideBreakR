#' Table splitter
#'
#' Splits a large table into smaller tables based on a maximum number of rows
#' @param df Data frame to split
#' @param maxRows The maximum number of rows for the new table(s)
#' @return A list of tables.
#' @export
#' @examples splitTable(airquality, maxRows = 50)
splitTable <- function(df, maxRows = 74){
  totalRows <- nrow(df)

  # Tables and lengths
  nFullTables <- floor(totalRows / maxRows)
  lengthLastTable <- totalRows %% maxRows

  # Create vector of assignment to tables
  fullTableRows <- NULL
  if(nFullTables > 0){
    fullTableRows <- rep(1:nFullTables, each = maxRows)
  }
  partialTableRows <- rep(nFullTables + 1, lengthLastTable)
  rowSplit <- c(fullTableRows, partialTableRows)

  # Split data
  split(df, rowSplit)

}


#' rmarkdown Kable Writer
#'
#' Wrapper to `splitTable` that splits a data frame into a a list and writes out markdown slides to be read in as a child document ot main markdown file
#' @param df A data.frame to split and write out
#' @param maxRows The maximum number of rows for the new table(s)
#' @param filename The filename of the rmarkdown document including extension.
#' @param slideTitle Slide Title
#' @param otherText Sub text prior to table
#' @param repeatOther Logical. If `TRUE` the sub text will be repeated on each slide
#' @param silent Logical. If `TRUE` reporting of the filename is suppressed.
#' @param ... Other arguments to `kable`
#' @return Nothing in R.  A markdown documner with the specified file name.
#' @export
#' @examples {
#'   writeRMDKable(airquality, maxRows = 50, slideTitle = "Slide title", 
#'                 otherText = "Extra information")
#'   writeRMDKable(airquality, maxRows = 50, slideTitle = "Slide title", 
#'                 otherText = "Extra information",
#'                 col.names = names(airquality))
#' }
writeRMDKable <- function(df, 
                          maxRows = 50, 
                          filename = tempfile(), 
                          slideTitle = "Table",
                          otherText = NULL, 
                          repeatOther = TRUE, 
                          silent = TRUE, 
                          ...){
  # Start new file
  sink(filename)

  # Write out section heading
  cat("#", slideTitle, "\n\n")
  if (!is.null(otherText)) cat(otherText, "\n\n")
  cat("```{r, echo=FALSE, results='asis'}\n")

  # Handle other arguments passed to kable
  ellipsis <- list(...)
  otherArgs <- NULL
  if(length(ellipsis) > 0){
    otherArgs <- paste(names(ellipsis), "=", ellipsis, collapse = ",")
    otherArgs <- paste(",", otherArgs)
  }

  # Generate expression then call (for the upcoming loop) and write to Rmd
  splitTableExpr <- paste0("dfList <- splitTable(", deparse(substitute(df)), ", maxRows = ", maxRows, ")\n")
  cat(splitTableExpr)
  eval(parse(text = splitTableExpr))
  cat("```\n\n")

  # Loop around each table and write new Rmd piece
  for (i in seq_along(dfList)){
    if(i > 1)  cat("#", slideTitle, "\n\n")
    if (i > 1 & !is.null(otherText) & repeatOther) cat(otherText, "\n\n")
    cat("```{r, echo=FALSE, results='asis'}\n")
    cat("knitr:::kable(dfList[[", i, "]], row.names=FALSE", otherArgs, ")\n", sep = "")
    cat("```\n\n")
  }

  # No return, close file
  sink()
  if (silent) invisible()
  else{
    cat("File written to: \"", filename, "\"\n", sep = "")
  }
}


