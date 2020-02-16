# R_plot
[TOC]
## Biological plot  with R!
Tidy the useful plots in biology research with R scripts.
Plot types including below described.

## Venn plot

input: differnt gene lists, up to 5 gene lists

method: VennDiagram

output: scaled or not scaled venn plots

## Volcano plot

input: omics data

method: ggplot2

output: Volcano or Volcano plot with all points or selected points labeled with gene symbols.

## Heatmap plot

heatmap with column and row cluster trees

Column cluster tree can be clustered in two level, namely two group condition.

## GO or KEGG enrichment plot

GO or KEGG enrichment plot including the enrichment analysis step and plot step. ClusterProfiler package combines these two steps into one step.

You can also do the enrichment analysis with DAVID web tools or KEGG web tools , then plot the result.

Recommend the clusterProfiler package written by Guangchuang Yu. He wrote a [book](https://yulab-smu.github.io/clusterProfiler-book/index.html) specifically talking about the enrichment analysis.

## enrichment_Bubble plot

input: GO or KEGG enrichment result by web-based applications or other softwares

plot method: ggplot2, bubble plot

output: enrichment bubble plot showing the Gene ontology terms, Gene hits ratio, Gene number count, adjusted p.value

## gsea_plot

input: dataframe with 2-columned data, Accession | log2FC

method: the clusterProfiler package written by Guangchuang Yu

output:  Gsea plot of the omics data.