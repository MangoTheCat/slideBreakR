<!-- README.md is generated from README.Rmd. Please edit that file -->
This package is designed to make rendering long tables easier in slides.

The `splitTable` function does the actual splitting of a data.frame into a list of smaller data.frames.

The `writeRMDKable` will produce an .Rmd file with the results written as markdown, this can then be read into a presentation as knitr child item.

To install this package:

    if(!require(devtools)) install.packages("devtools")
    devtools::install_github("mangothecat/slideBreakR")
