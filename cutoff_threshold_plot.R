rm(list = ls())
options(stringsAsFactors = F)

source("udf.R")
creDir("data")
creDir("res")
creDir("public")
dataDir = file.path('data')
resDir = file.path('res')
publicDir = file.path('public')

# library packages -------------------------------------------------------------

required_pkgs <-
  c("matrixStats",
    "ggplot2",
    "readxl",
    "tidyverse")
pkgCheck(required_pkgs)
dat <- read_excel(file.path(dataDir, "data_20200412.xlsx"))
colnames(dat) <- c("Accession", paste0('tmt_ratio', 1:3))
dat2 <- dat[, -1]
sum(is.na(dat2))
sel_col <- c(paste0('tmt_ratio', 1:3))
dat_relative_var <- dat2 %>%
  select(sel_col) %>%
  drop_na() %>%
  mutate(ratio_mean = round(rowMeans2(as.matrix(., na.rm = TRUE)), 2)) %>%
  mutate(ratio_sd = round(rowSds(as.matrix(., na.rm = TRUE)), 2)) %>%
  mutate(relative_var = round(ratio_sd / ratio_mean, 2))
rel_var <- cut(
  dat_relative_var$relative_var,
  breaks = c(seq(0, 0.9, 0.1), 10),
  include.lowest = TRUE,
  right = FALSE,
  ordered_result = TRUE
)
cutoff <- table(rel_var) %>%
  as.data.frame() %>%
  mutate(cum_sum = cumsum(.[, "Freq"])) %>%
  mutate(cum_coverage = round(.$cum_sum / sum(.$Freq), 2))
write.csv(cutoff, file.path(resDir, "Variation_cutoff.csv"), row.names = FALSE)
# rel_var:相对标准偏差，Freq:对应相对标准偏差区间中的蛋白数目，cum_sum:累计Freq，cum_coverage:累计覆盖率。
# plot
if (T) {
  gg <-
    ggplot(data = cutoff, aes(x = rel_var, y = Freq)) +
    geom_bar(stat = "identity", width = 0.8) +
    xlab("Relative variation") +
    ylab("Protein counts")
  gg
  
  gg <- gg + geom_point(
    data = cutoff,
    aes(
      x = rel_var,
      y = (cum_coverage) *  sum(cutoff$Freq),
      group = 1
    ),
    size = 0.9,
    color = "black",
    inherit.aes = TRUE
  )
  gg
  
  gg <- gg + geom_line(
    data = cutoff,
    aes(
      x = rel_var,
      y = (cum_coverage) * sum(cutoff$Freq),
      group = 1
    ),
    size = 0.7,
    color = "black",
    inherit.aes = TRUE
  )
  gg
  
  gg <- gg + scale_y_continuous(sec.axis = sec_axis(~ . /  sum(cutoff$Freq),
                                                    name = "Cumulative coverage"))
  gg
  
  gg <- gg + theme(
    plot.subtitle = element_text(vjust = 1),
    plot.caption = element_text(vjust = 1),
    axis.line = element_line(linetype = "solid", size = 1),
    axis.ticks = element_line(colour = "gray0"),
    axis.title = element_text(size = 12,
                              face = "bold"),
    axis.text = element_text(size = 12),
    axis.text.x = element_text(
      size = 12,
      angle = 90,
      vjust = 0.3,
      face = "bold"
    ),
    axis.text.y = element_text(size = 12, face = "bold"),
    panel.background = element_rect(fill = NA),
    legend.position = "none"
  ) + labs(size = 12)
  gg
  ggsave(file.path(resDir, "cutoff_threshold.jpeg"), height = 6, width = 6, units = "in")
  ggsave(file.path(resDir, "cutoff_threshold.png"))
  
}
