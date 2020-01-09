# user defined functions

# check existence and creat floder
creDir <- function(folder) {
  ifelse(!dir.exists(file.path(getwd(),
                               folder)), dir.create(file.path(getwd(), folder)), FALSE)
}
# convert first letter to upper case
firstup <- function(x) {
  x = tolower(x)
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  x
}
