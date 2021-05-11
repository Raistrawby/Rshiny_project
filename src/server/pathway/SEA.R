library(clusterProfiler)
library(pathview)


get_SEA_KEGG <- function(geneList, organism) {
  return(enrichKEGG(
    gene = names(geneList),
    organism = organism,
    pvalueCutoff = 0.05
  ))
}

get_KEGG_SEA_table <- function(kegg) {
  kegg_result = kegg@result
  kegg_result$URL = paste0(
    "<a href=https://www.kegg.jp/kegg-bin/show_pathway?",
    kegg_result$ID,
    " target='_blank'>",
    kegg_result$ID,
    "</a>"
  )
  selected_columns = c("URL",
                       "Description",
                       "GeneRatio",
                       "BgRatio",
                       "pvalue",
                       "p.adjust",
                       "qvalue")
  return(kegg_result[, selected_columns])
}