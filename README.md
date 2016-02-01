# slideBreakR
An R package for splitting tables up over multiple slides using knitr, rmarkdown and slidy.

This package was written to solve a small but frustrating problem when working with rmarkdown and slidy.  Typically when a table is too long for the slide it continues and you must scroll down to see the bottom.  This package enables a user to define a maximum number of rows to display on a slide and then automatically cuts the table up into separate slides and chunks.

## Installation

```r
devtools::install_github("mangothecat/slideBreakR")
```

## Usage

```r
library(slideBreakR)
```