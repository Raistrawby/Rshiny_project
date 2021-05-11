# GSEA
get_GSEA_dotplot <- function(result_object, title, nbCat=20) {
  return(dotplot(result_object, showCategory = nbCat) + ggtitle(title))
}

get_GSEA_ridgeplot <- function(result_object, title, nbCat=20) {
  return(
    ridgeplot(result_object, showCategory = nbCat) + ggtitle(title)
  )
}

get_GSEA_gseaplot <- function(result_object, title, nbCat=20) {
  return(gseaplot2(result_object, geneSetID = 1, title = title))
}

########################################################@
# SEA
get_SEA_upsetplot <- function(result_object, title) {
  upsetplot(result_object, n = 10) + ggtitle(title)
}

get_SEA_dotplot <- function(result_object, title) {
  dotplot(result_object, showCategory = 15) + ggtitle(title)
}

get_SEA_barplot <- function(result_object, title) {
  barplot(result_object, showCategory = 15) + ggtitle(title)
}

