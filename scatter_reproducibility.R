# global setting ----------------------------------------------------------

rm(list = ls())
options(stringsAsFactors = F)
source("udf.R")
creDir("data")
creDir("res")
creDir("public")
dataDir = file.path(getwd(), 'data')
resDir = file.path(getwd(), 'res')
publicDir = file.path(getwd(), 'public')

# library packages -------------------------------------------------------------

required.pkgs <-
  c("dplyr",
    "tidyr",
    "ggplot2",
    "stringr",
    "ggThemeAssist",
    "shiny")
pkgCheck(required.pkgs)
# simulate data -----------------------------------------------------------

# plot and export graph ---------------------------------------------------
