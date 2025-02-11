#Accumulate Function - Pascals Triangle

library(purrr)

letters

accumulate(letters, paste)
accumulate(1:10, ~ 2 * ., .init = 1)


#Pascal's Triangle

row <- c(1, 3, 3, 1)
c(0, row) + c(row, 0)

accumulate(1:6, ~c(0, .) + c(., 0), .init = 1)
