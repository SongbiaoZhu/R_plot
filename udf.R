# user defined functions

creDir <- function(folder) {
  # check existence and creat floder
  ifelse(!dir.exists(file.path(getwd(),
                               folder)), dir.create(file.path(getwd(), folder)), FALSE)
}

firstup <- function(x) {
  # convert first letter to upper case
  x = tolower(x)
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  x
}

pkgCheck <- function(required.pkgs){
  # check installation, install or library required packages
  for(p in required.pkgs){
    if(!require(p,character.only = TRUE)) install.packages(p)
    library(p,character.only = TRUE)
  }
}