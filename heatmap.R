
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

set.seed(1234)
datHeat = matrix(rnorm(200), 20, 10)
datHeat[1:10, seq(1, 10, 2)] = datHeat[1:10, seq(1, 10, 2)] + 3
datHeat[11:20, seq(2, 10, 2)] = datHeat[11:20, seq(2, 10, 2)] + 2
datHeat[15:20, seq(2, 10, 2)] = datHeat[15:20, seq(2, 10, 2)] + 4
colnames(datHeat) = paste("Sample", 1:10, sep = "")
rownames(datHeat) = paste("Gene", 1:20, sep = "")
annotation_col = data.frame(CellType = factor(rep(c("CT1", "CT2"), 5)),
                            Time = 1:5)
rownames(annotation_col) = paste("Sample", 1:10, sep = "")
annotation_row = data.frame(GeneClass = factor(rep(c(
  "Path1", "Path2", "Path3"
), c(10, 4, 6))))
rownames(annotation_row) = paste("Gene", 1:20, sep = "")

# plot and export graph ---------------------------------------------------

requiredPackages <- c("pheatmap", "ggplot2")
for (p in requiredPackages) {
  if (!require(p, character.only = TRUE))
    install.packages(p)
  library(p, character.only = TRUE)
}
colorName = colorRampPalette(c("blue", "white", "red"))(256)
picName = file.path(resDir, 'heatmap.png')
# Specify annotation colors
ann_colors = list(
  Time = c("white", "firebrick"),
  CellType = c(CT1 = "#1B9E77", CT2 = "#D95F02"),
  GeneClass = c(
    Path1 = "#7570B3",
    Path2 = "#E7298A",
    Path3 = "#66A61E"
  )
)
pheatmap(
	# https://rdrr.io/cran/pheatmap/man/pheatmap.html
  datHeat,
  cluster_rows = T,
  cluster_cols = T,
  annotation_col = annotation_col,
  annotation_row = annotation_row,
  border_color = "grey",
  cellwidth = 60,
  color = colorRampPalette(c("blue", "white", "red"))(256),
  # Change angle of text in the columns
  angle_col = "45",
  annotation_colors = ann_colors,
  filename = picName
)
