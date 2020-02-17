# R_plot
[TOC]
## Biological plot  with R!
Tidy the useful plots in biology research with R scripts.
Plot types including below described.

## Venn plot

**input**: differnt gene lists, up to 5 gene lists

**method**: VennDiagram

**output**: scaled or not scaled venn plots

## Volcano plot

**input**: omics data

**method**: ggplot2

**output**: Volcano or Volcano plot with all points or selected points labeled with gene symbols.

## Heatmap plot

**input**: expression matrix of different samples

**method**: pheatmap package

**output**: heatmap with column and row cluster trees. Column cluster tree can be clustered in two level, namely two group condition.

## GO or KEGG enrichment plot

**input**: gene lists, for example from omics, up- or down-regulated protein lists

**method**: R clusterProfiler  package

**output**: GO or KEGG enrichment plot including the enrichment analysis step and plot step. ClusterProfiler package combines these two steps into one step.

You can also do the enrichment analysis with DAVID web tools or KEGG web tools , then plot the result.

Recommend the clusterProfiler package written by Guangchuang Yu. He wrote a [book](https://yulab-smu.github.io/clusterProfiler-book/index.html) specifically talking about the enrichment analysis.

## enrichment_Bubble plot

**input**: GO or KEGG enrichment result by web-based applications or other softwares

**method**: ggplot2, bubble plot

**output**: enrichment bubble plot showing the Gene ontology terms, Gene hits ratio, Gene number count, adjusted p.value

## gsea_plot

**input**: dataframe with 2-columned data, Accession | log2FC

**method**: the clusterProfiler package written by Guangchuang Yu

**output**:  Gsea plot of the omics data.

## Scatter plot showing the reproducibility

**input**: dataframe with 2-columned data,  log2FC_rep1 | log2FC_rep2

**method**: the ggplot2 and ggThemeAssist packages

**output**:  scatter plot showing the correlation between two groups of data, with or without showing the adjusted R squared value.

## Motif logo plot

**input**: dna or amino acid sequence list, Or frequency matrix of sequence

**method**: the ggplot2 and ggseqlogo packages

**output**:  logo plot showing the motif sequence.