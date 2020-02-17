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
    "ggseqlogo")
pkgCheck(required.pkgs)

# simulate, or load data -----------------------------------------------------------
## example data with package
## seqs_dna:12种转录因子的结合位点序列
## seqs_aa:一组激动酶底物磷酸化位点序列
## pfms_dna:四种转录因子的位置频率矩阵
data(ggseqlogo_sample)
head(seqs_dna)[1]
head(seqs_aa)[1]
head(pfms_dna)[1]

# plot and export graph ---------------------------------------------------

ggplot() + geom_logo(seqs_dna$MA0001.1) + theme_logo()
## same as the code below with ggseqlogo function
## ggseqlogo支持以下几种类型数据输入：序列， 频率矩阵
ggseqlogo(seqs_dna$MA0001.1)
ggsave(filename = file.path(resDir, 'motif_logo_dna.png'),
       dpi = 'screen')
ggseqlogo(pfms_dna$MA0018.2)
ggsave(filename = file.path(resDir, 'motif_logo_bindingSite.png'),
       dpi = 'screen')
## ggseqlogo支持aa、DNA, RNA序列类型，默认ggseqlogo会自动识别，也可用seq_type指定
ggseqlogo(seqs_aa$AKT1, seq_type = "aa")
ggsave(filename = file.path(resDir, 'motif_logo_protein.png'),
       dpi = 'screen')
## ggseqlogo通过method选项支持两种序列标志生成方法：bits和probability
p1 <- ggseqlogo(seqs_dna$MA0001.1, method = "bits")
p2 <- ggseqlogo(seqs_dna$MA0001.1, method = "prob")
gridExtra::grid.arrange(p1, p2)

## 通过namespace选项来定义自己想要的字母类型
#用数字来代替碱基
seqs_numeric <- chartr("ATGC", "1234", seqs_dna$MA0001.1)
ggseqlogo(seqs_numeric, method = "prob", namespace = 1:4)
