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
    "ggThemeAssist")
pkgCheck(required.pkgs)

# simulate data -----------------------------------------------------------

set.seed(1234)
num <- 6000
base <- rnorm(n = num, mean = 0, sd = 0.5)
eps <- rnorm(n = num, mean = 0, sd = 0.1)
log2FC_rep1 <- base + eps
log2FC_rep2 <- base - eps
datScatter <- data.frame(log2FC_rep1, log2FC_rep2)

# plot and export graph ---------------------------------------------------

axis_limit <- c(floor(min(
  c(datScatter$log2FC_rep1, datScatter$log2FC_rep2)
)), ceiling(max(
  c(datScatter$log2FC_rep1, datScatter$log2FC_rep1)
)))
psingle <-
  ggplot(data = datScatter, aes(x = log2FC_rep1, y = log2FC_rep2)) +
  geom_point() +
  scale_x_continuous(
    name = "Replicate 1",
    breaks = seq(axis_limit[1], axis_limit[2], 0.5),
    labels = seq(axis_limit[1], axis_limit[2], 0.5),
    limits = axis_limit,
    expand = c(0, 0)
  ) +
  scale_y_continuous(
    name = "Replicate 2",
    breaks = seq(axis_limit[1], axis_limit[2], 0.5),
    labels = seq(axis_limit[1], axis_limit[2], 0.5),
    limits = axis_limit,
    expand = c(0, 0)
  ) +
  geom_smooth(
    method = "lm",
    formula = y ~ x,
    color = "blue",
    se = FALSE
  )
# ggThemeAssistGadget(psingle)
psingle <- psingle + theme(
  plot.subtitle = element_text(vjust = 1),
  plot.caption = element_text(vjust = 1),
  axis.line = element_line(linetype = "solid", size = 1),
  axis.ticks = element_line(colour = "black", size = 1),
  axis.title = element_text(face = "bold", size = 18),
  axis.text = element_text(
    face = "bold",
    colour = 'black',
    size = 14
  ),
  plot.title = element_text(face = "bold"),
  panel.background = element_rect(fill = NA),
  legend.position = "none"
)
psingle
if (F) {
  ggsave(
    filename = "scatter_correlation.jpeg",
    plot = psingle,
    width = 6,
    height = 6,
    units = "in",
    dpi = 300
  )
}
ggsave(
  filename = file.path(resDir, "scatter_correlation.png"),
  plot = psingle,
  dpi = 'screen'
)
## scatter plot showing the adj.R2.squared
fit <- lm(log2FC_rep1 ~ log2FC_rep2)
adj.r.squared <- signif(summary(fit)$adj.r.squared, 2)
psingle_r2 <- psingle + labs(title = bquote(paste('R'^2*' = ', .(adj.r.squared))))
psingle_r2
ggsave(
  filename = file.path(resDir, "scatter_correlation_R2.png"),
  plot = psingle_r2,
  dpi = 'screen'
)
