
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

# simulate data -----------------------------------------------------------

fullList <- paste0('gName', 1:6000)
geneList1 <- fullList[1:2000]
geneList2 <- fullList[500:2500]
geneList3 <- fullList[1800:1900]
geneList4 <- fullList[1950:2100]
geneList5 <- fullList[c(1700:1900,3000:4000)]

# plot and export graph ---------------------------------------------------

requiredPackages <- c("VennDiagram")
for(p in requiredPackages){
  if(!require(p,character.only = TRUE)) install.packages(p)
  library(p,character.only = TRUE)
}
# Pairwise Venn diagram
pairList = list(geneList1, geneList2)
picName = file.path(resDir, 'pairwiseVenn.tiff')
catName = c('List1', 'List2')
colorName = c('#FF3F40', '#4040FF')
venn.diagram(
  # https://rdrr.io/cran/VennDiagram/man/venn.diagram.html
  x = pairList,
  filename = picName,
  height = 3000,
  width = 3000,
  resolution =
    500,
  imagetype = "tiff",
  units = "px",
  compression =
    "lzw",
  na = "remove",
  main = NULL,
  sub = NULL,
  main.pos
  = c(0.5, 1.05),
  main.fontface = "plain",
  main.fontfamily = "serif",
  main.col = "black",
  main.cex = 1,
  main.just = c(0.5, 1),
  sub.pos = c(0.5,
              1.05),
  sub.fontface = "plain",
  sub.fontfamily =
    "serif",
  sub.col = "black",
  sub.cex = 1,
  sub.just =
    c(0.5, 1),
  category.names = catName,
  force.unique =
    TRUE,
  print.mode = "raw",
  sigdigs = 3,
  direct.area =
    FALSE,
  area.vector = 0,
  hyper.test = FALSE,
  total.population = NULL,
  lower.tail = TRUE,
  # parameters adjustment
  fill = colorName
)
# Triple Venn diagram
tripleList = list(geneList1, geneList2, geneList3)
picName = file.path(resDir, 'tripleVenn.tiff')
catName = c('List1', 'List2', 'List3')
colorName = c('#9796FE', '#FE9695', '#96FC8F')
venn.diagram(
  # https://rdrr.io/cran/VennDiagram/man/venn.diagram.html
  x = tripleList,
  filename = picName,
  height = 3000,
  width = 3000,
  resolution =
    500,
  imagetype = "tiff",
  units = "px",
  compression =
    "lzw",
  na = "remove",
  main = NULL,
  sub = NULL,
  main.pos
  = c(0.5, 1.05),
  main.fontface = "plain",
  main.fontfamily = "serif",
  main.col = "black",
  main.cex = 1,
  main.just = c(0.5, 1),
  sub.pos = c(0.5,
              1.05),
  sub.fontface = "plain",
  sub.fontfamily =
    "serif",
  sub.col = "black",
  sub.cex = 1,
  sub.just =
    c(0.5, 1),
  category.names = catName,
  force.unique =
    TRUE,
  print.mode = "raw",
  sigdigs = 3,
  direct.area =
    FALSE,
  area.vector = 0,
  hyper.test = FALSE,
  total.population = NULL,
  lower.tail = TRUE,
  # parameters adjustment
  fill = colorName
)
# Quad Venn diagram with four sets
quadList = list(geneList1, geneList2, geneList3, geneList4)
picName = file.path(resDir, 'quadVenn.tiff')
catName = c('List1', 'List2', 'List3', 'List4')
colorName = c('#FFD280', '#FF8080', '#80FF80', '#8080FF')
venn.diagram(
  # https://rdrr.io/cran/VennDiagram/man/venn.diagram.html
  x = quadList,
  filename = picName,
  height = 3000,
  width = 3000,
  resolution =
    500,
  imagetype = "tiff",
  units = "px",
  compression =
    "lzw",
  na = "remove",
  main = NULL,
  sub = NULL,
  main.pos
  = c(0.5, 1.05),
  main.fontface = "plain",
  main.fontfamily = "serif",
  main.col = "black",
  main.cex = 1,
  main.just = c(0.5, 1),
  sub.pos = c(0.5,
              1.05),
  sub.fontface = "plain",
  sub.fontfamily =
    "serif",
  sub.col = "black",
  sub.cex = 1,
  sub.just =
    c(0.5, 1),
  category.names = catName,
  force.unique =
    TRUE,
  print.mode = "raw",
  sigdigs = 3,
  direct.area =
    FALSE,
  area.vector = 0,
  hyper.test = FALSE,
  total.population = NULL,
  lower.tail = TRUE,
  # parameters adjustment
  fill = colorName
)
# Quintuple Venn diagram with four sets
quadList = list(geneList1, geneList2, geneList3, geneList4, geneList5)
picName = file.path(resDir, 'quintupleVenn.tiff')
catName = c('List1', 'List2', 'List3', 'List4', 'List5')
colorName = c('#90C8FF', '#FFDE94', '#FFBF82', '#A2E6BD', '#E6B4E6')
venn.diagram(
  # https://rdrr.io/cran/VennDiagram/man/venn.diagram.html
  x = quadList,
  filename = picName,
  height = 3000,
  width = 3000,
  resolution =
    500,
  imagetype = "tiff",
  units = "px",
  compression =
    "lzw",
  na = "remove",
  main = NULL,
  sub = NULL,
  main.pos
  = c(0.5, 1.05),
  main.fontface = "plain",
  main.fontfamily = "serif",
  main.col = "black",
  main.cex = 1,
  main.just = c(0.5, 1),
  sub.pos = c(0.5,
              1.05),
  sub.fontface = "plain",
  sub.fontfamily =
    "serif",
  sub.col = "black",
  sub.cex = 1,
  sub.just =
    c(0.5, 1),
  category.names = catName,
  force.unique =
    TRUE,
  print.mode = "raw",
  sigdigs = 3,
  direct.area =
    FALSE,
  area.vector = 0,
  hyper.test = FALSE,
  total.population = NULL,
  lower.tail = TRUE,
  # parameters adjustment
  fill = colorName,
  cat.pos = c(0, 20, 0, 0, -20),
  cat.dist = 0.05
)
