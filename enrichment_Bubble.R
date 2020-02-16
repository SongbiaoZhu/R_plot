# global settings ---------------------------------------------------------

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

# simulate data -------------------------------------

termNumber <- 15
Term <- paste0('GO_or_pathway_', LETTERS[1:termNumber])
geneRatio <- round(runif(termNumber, 3.5, 9.5),2)
Count <-  floor(runif(termNumber, 8, 14)) 
p.value <- round(c(runif(round(termNumber*0.5), 0.01, 0.049),
             runif(termNumber - round(termNumber*0.5), 0.0001, 0.01)
             ),5)
datBubble <- data.frame(Term, geneRatio, Count, p.value)

# draw bubble plot --------------------------------------------------------

x_title <- NULL
y_title <- "Gene ratio (%)"
y_limit <-
  c(floor(min(datBubble$geneRatio)), ceiling(max(datBubble$geneRatio)))
ind <- rev(datBubble[, "Term"])
datBubble$Term <- factor(datBubble$Term, levels = ind)
bubblePlot <- ggplot(datBubble,
                     aes(
                       x = Term,
                       y = geneRatio,
                       size = Count,
                       color = p.value
                     )) +
  geom_point(alpha = 0.7) +
  scale_y_continuous(
    name = y_title,
    breaks = seq(y_limit[1], y_limit[2], 1),
    labels = seq(y_limit[1], y_limit[2], 1),
    limits = y_limit
  ) +
  labs(x = x_title) +
  guides(size = guide_legend(order = 1),
         colour = guide_colourbar(order = 2)) +
  scale_color_gradient2(
    low = 'darkblue',
    mid = 'blue',
    high = 'lightblue',
    midpoint = 0.01
  ) +
  coord_flip()
# ggThemeAssistGadget(bubblePlot)
bubblePlot <- bubblePlot + theme(
  plot.subtitle = element_text(vjust = 1),
  plot.caption = element_text(vjust = 1),
  axis.line = element_line(colour = "black"),
  axis.ticks = element_line(colour = "black", size = 1),
  axis.title = element_text(colour = "black", face = "bold"),
  axis.text = element_text(colour = "black", face = "bold"),
  plot.title = element_text(colour = "black", face = "bold"),
  panel.background = element_rect(fill = NA),
  legend.background = element_rect(fill = "white"),
  legend.key = element_rect(fill = "white", color = NA)
)
bubblePlot
picName <- 'enrich_bubble_plot.png'
ggsave(
  plot = bubblePlot,
  filename = file.path(resDir, picName),
  width = 6,
  height = 4.5,
  units = c('in')
)

