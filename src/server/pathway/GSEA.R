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

get_SEA_KEGG <- function(geneList, organism) {
  return(enrichKEGG(
    gene = names(geneList),
    organism = organism,
    pvalueCutoff = 0.05
  ))
}

get_GSEA_pathway_image <- function(geneList,
                                   pathwayid, organism) {
  pathview(gene.data  = geneList,
           pathway.id = pathwayid,
           species    = organism,)
  
  list(
    src = paste0(pathwayid, ".pathview.png"),
    contentType = 'image/png',
    width = "100%"
  )
}
