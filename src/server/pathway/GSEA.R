library(clusterProfiler)
library(pathview)

get_KEGG_GSEA <- function(geneList, organism, method) {
  return(
    gseKEGG(
      geneList     = geneList,
      organism     = organism,
      pvalueCutoff = 1,
      pAdjustMethod = method
    )
  )
}

get_SEA_KEGG <- function(geneList, organism, method) {
  return(enrichKEGG(
    gene = names(geneList),
    organism = organism,
    pvalueCutoff = 1,
    qvalueCutoff = 1,
    pAdjustMethod = method
  ))
}


get_GSEA_pathway_image <- function(geneList,
                                   pathwayid,
                                   organism
                                   ) {
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
