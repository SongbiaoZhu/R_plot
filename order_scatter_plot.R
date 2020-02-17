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
  c("ggplot2",
    'ggrepel')
pkgCheck(required.pkgs)

# simulate , or load data -----------------------------------------------------------
set.seed(2020)
num <- 6000
Accession <- as.character(paste0('No.', 1:num))
Score <- round(runif(num, min = 2, max = 9000), 1)
Symbol <- as.character(paste0('Gene_', 1:num))
dat_scatter <- data.frame(Accession, Score, Symbol)
dat_scatter <-
  dat_scatter[order(dat_scatter$Score, decreasing = TRUE), ]
head(dat_scatter)

# plot and export graph ---------------------------------------------------

picName <- file.path(resDir, 'ordered_ratio.png')
picNameText <- file.path(resDir, 'ordered_ratio_symbol.png')
x_title <- 'A point is a protein'
y_title <- 'Sequest.HT Score of protein'
x_limit <- c(1, length(dat_scatter$Score))
y_limit <- c(min(dat_scatter$Score), max(dat_scatter$Score))
scatter <-
  ggplot(data = dat_scatter,
         mapping = aes(x = 1:length(dat_scatter$Score), y = Score)) +
  geom_point() +
  scale_x_continuous(
    name = x_title,
    limits = x_limit,
    breaks = seq(x_limit[1], x_limit[2], 1000),
    labels = seq(x_limit[1], x_limit[2], 1000)
  ) +
  scale_y_continuous(
    name = y_title,
    limits = y_limit,
    breaks = seq(y_limit[1], y_limit[2], 1000),
    labels = seq(y_limit[1], y_limit[2], 1000)
  )
scatter <- scatter + theme(
  plot.subtitle = element_text(vjust = 1),
  plot.caption = element_text(vjust = 1),
  axis.line = element_line(colour = "black"),
  axis.ticks = element_line(colour = "black", size = 1),
  axis.title = element_text(colour = "black", face = "bold"),
  axis.text = element_text(colour = "black", face = "bold"),
  plot.title = element_text(colour = "black", face = "bold"),
  panel.background = element_rect(fill = NA),
  legend.position = "none"
)
scatter
ggsave(picName,
       plot = scatter,
       dpi = 'screen')
## add gene symbol to selected points
lables <- head(dat_scatter$Symbol, 5)
datLabel <- subset(dat_scatter, Symbol %in% lables)
scatter_text <- scatter +
  geom_text_repel(
    data = datLabel,
    aes(
      x = match(lables, dat_scatter$Symbol),
      y = Score,
      label = Symbol
    ),
    size = 2.5,
    box.padding = unit(0.35, "lines"),
    point.padding = unit(0.3, "lines")
  )
scatter_text
ggsave(picNameText,
       plot = scatter,
       dpi = 'screen')