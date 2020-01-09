

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
# provide 3 numeric vectors, Accession|log2FC|ad.p.value
set.seed(1234)
Accession <- paste0('Ser.No', 1:6000)
log2FC <- rnorm(n = 6000, mean = 0, sd = 1)
ad.p.value <- runif(n = 6000, min = 0.001, max = 0.999)
datVolcano <- data.frame(Accession = Accession,
                         log2FC = log2FC,
                         ad.p.value = ad.p.value)
ifelse(!exists("p_cut"), p_cut <- 0.05, print(as.character(p_cut)))
ifelse(!exists("fc_cut"), fc_cut <-
         1.5, print(as.character(fc_cut)))
datVolcano$threshold = as.factor(datVolcano$ad.p.value < p_cut &
                                   (datVolcano$log2FC > log2(fc_cut) |
                                      (datVolcano$log2FC < log2(1 / fc_cut))))
datVolcano <- within(datVolcano, {
  regulation = as.factor (ifelse(threshold == FALSE, 0,
                                 ifelse(
                                   log2FC < log2(1 / fc_cut),-1,
                                   ifelse(log2FC > log2(fc_cut), 1, 0)
                                 )))
})
head(datVolcano)
summary(datVolcano$threshold)
summary(datVolcano$regulation)
summary(datVolcano$log2FC)

# plot and export graph ---------------------------------------------------

requiredPackages <- c("ggplot2", "ggThemeAssist")
for (p in requiredPackages) {
  if (!require(p, character.only = TRUE))
    install.packages(p)
  library(p, character.only = TRUE)
}
colorName = c("#0000FF", "grey15", "#FF0000")
picName = file.path(resDir, 'volcano.jpeg')
x_title <- expression('Log'[2] * ' Treated / Control')
y_title <- expression(paste("¨CLog " * italic("P"), " value"))

# Volcano plot without point symbol labels

x_limit <-
  c(floor(min(datVolcano$log2FC)), ceiling(max(datVolcano$log2FC)))
y_limit <-
  c(floor(min(-log10(
    datVolcano$ad.p.value
  ))), ceiling(max(-log10(
    datVolcano$ad.p.value
  ))))

volcano <-
  ggplot(data = datVolcano, aes(
    x = log2FC,
    y = -log10(ad.p.value),
    color = regulation
  )) +
  geom_point(size = 0.5) +
  scale_x_continuous(
    name = x_title,
    breaks = seq(x_limit[1], x_limit[2], 1),
    labels = seq(x_limit[1], x_limit[2], 1),
    limits = x_limit,
    expand = c(0, 0)
  ) +
  scale_y_continuous(
    name = y_title,
    breaks = seq(y_limit[1], y_limit[2], 1),
    labels = seq(y_limit[1], y_limit[2], 1),
    limits = y_limit,
    expand = c(0, 0)
  ) +
  geom_hline(
    yintercept = -log10(p_cut),
    linetype = "dashed",
    color = "grey",
    size = 0.5
  ) +
  geom_vline(
    xintercept = log2(fc_cut),
    linetype = "dashed",
    color = "grey",
    size = 0.5
  ) +
  geom_vline(
    xintercept = log2(1 / fc_cut),
    linetype = "dashed",
    color = "grey",
    size = 0.5
  )
# ggThemeAssistGadget(volcano)
volcano <- volcano + theme(
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
volcano_2 <- volcano +
  scale_color_manual(values = colorName,
                     guide = FALSE)
volcano_2
ggsave(
  filename = picName,
  plot = volcano_2,
  width = 6,
  height = 4.5,
  units = "in",
  dpi = 300
)