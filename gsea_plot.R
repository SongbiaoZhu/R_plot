# global setting ----------------------------------------------------------

rm(list = ls())
options(stringsAsFactors = F)
source(file = 'udf.R')
creDir("data")
creDir("res")
creDir("public")
dataDir = file.path(getwd(), 'data')
resDir = file.path(getwd(), 'res')
publicDir = file.path(getwd(), 'public')

# library packages -------------------------------------------------------------

required.pkgs <-
  c("GSEABase",
    "clusterProfiler",
    "org.Hs.eg.db",
    "enrichplot",
    "ggplot2")
pkgCheck(required.pkgs)

# load data -----------------------------------------------------------
## 2-column data, with headers Accession | log2FC
dat_gsea <-
  read.table(file = file.path(dataDir, 'dat_gsea.txt'), header = TRUE)
uniprot_id <- dat_gsea$Accession
entrez_id = bitr(uniprot_id,
                 fromType = "UNIPROT",
                 toType = "ENTREZID",
                 OrgDb = "org.Hs.eg.db")
head(entrez_id)
entrez_id$duplicate <- duplicated(entrez_id$ENTREZID)
summary(entrez_id$duplicate)
dat_gsea <-
  merge(dat_gsea, entrez_id, by.x = "Accession", by.y = "UNIPROT")
dat_gsea <-  subset(dat_gsea, duplicate == FALSE)
head(dat_gsea, 2)
# gsea plot and export graph ---------------------------------------------------
## feature 1: numeric vector
geneList = dat_gsea[, 2]
## feature 2: named vector
names(geneList) = as.character(dat_gsea[, 3])
## feature 3: decreasing order
geneList = sort(geneList, decreasing = TRUE)
head(geneList)

# 4. read .gmt, downloaded MSigDB gene set file
if (file.exists(file.path(publicDir, "c5.all.v6.2.entrez.gmt"))) {
  gmtfile <- file.path(publicDir, "c5.all.v6.2.entrez.gmt")
  dat_gmt <- read.gmt(gmtfile)
} else{
  stop("we can not find the .gmt file")
}

# 5. run GSEA
gsea_res <-
  GSEA(
    geneList,
    TERM2GENE = dat_gmt,
    verbose = FALSE,
    pvalueCutoff = 0.1
  )
# order GSEA result by enrichmentScore,save data
gsea_res_sort <-
  gsea_res[order(gsea_res$enrichmentScore, decreasing = T)]
head(gsea_res_sort$Description)
head(gsea_res_sort$ID)
dim(gsea_res_sort)
if (F) {
  openxlsx::write.xlsx(gsea_res_sort,
                       file.path(resDir, "gsea_res_sort.xlsx"),
                       row.names = FALSE)
}

# 6. Visualization, save plot
## plot top3 enriched signatures
gseaplot2(gsea_res, row.names(gsea_res_sort)[1:3], pvalue_table = TRUE)
ggsave(filename = file.path(resDir, 'gsea_top3_signature.png'),
       dpi = 'screen')
## plot INTERFERON related signatures
(index_1 <- which(grepl("INTERFERON", gsea_res_sort$ID)))
gsea_res_sort$ID[index_1]
gseaplot2(
  gsea_res,
  row.names(gsea_res_sort)[index_1[c(1, 5)]],
  pvalue_table = FALSE,
  color = c("red", "green"),
  base_size = 14,
  rel_heights = c(1.5, 0.5, 1),
  subplots = 1:3,
  ES_geom = "line"
)
ggsave(filename = file.path(resDir, 'interferon_Gsea.png'),
       dpi = 'screen')
