context("splitTable")

test_that("splitTable behaves as expected",{
  rows<-50
  result<-splitTable(airquality, maxRows = rows)
  
  # produces a list
  expect_is(result, "list")
  
  # produces expected number of elements in list
  check<-ceiling(nrow(airquality)/50)
  expect_equal(length(result), check)
  
  # produces a list of data.frames
  expect_true(unique(sapply(result,class))=="data.frame")
  
  # each data.frame has matching structure to original
  expect_true(unique(sapply(result,ncol))==ncol(airquality))
  expect_equal(sum(unlist(unique(lapply(result,colnames)))==colnames(airquality)),
              ncol(airquality))
})