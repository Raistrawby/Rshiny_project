library(clusterProfiler)
library(pathview)

get_KEGG_GSEA <- function(geneList, organism) {
  return(
    gseKEGG(
      geneList     = geneList,
      organism     = organism,
      nPerm        = 1000,
      minGSSize    = 120,
      pvalueCutoff = 0.05,
      verbose      = FALSE
    )
  )
}

get_KEGG_GSEA_table <- function(kegg) {
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
                       "enrichmentScore",
                       "pvalue",
                       "p.adjust",
                       "rank")
  return(kegg_result[, selected_columns])
}

get_GSEA_pathway_image <- function(geneList,
                                   pathwayid, organism) {
  pathview(
    gene.data  = geneList,
    pathway.id = pathwayid,
    species    = organism,
  )
  
  list(
    src = paste0(pathwayid, ".pathview.png"),
    contentType = 'image/png',
    width = "100%"
  )
}