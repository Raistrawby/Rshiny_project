###########################################################
# GSEA
get_GSEA_dotplot <- function(result_object, title, nbCat = 20) {
  return(dotplot(result_object, showCategory = nbCat) + ggtitle(title))
}

get_GSEA_ridgeplot <- function(result_object, title, nbCat = 20) {
  return(ridgeplot(result_object, showCategory = nbCat) + ggtitle(title))
}

get_GSEA_gseaplot <- function(result_object, title, nbCat = 20) {
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

###########################################################
# TABLE
render_result_table <- function(result_object, url, exp) {
  if (exp == "sea") {
    select_cols = c("URL",
                    "Description",
                    "GeneRatio",
                    "BgRatio",
                    "pvalue",
                    "p.adjust",
                    "qvalue")
  } else {
    select_cols = c("URL",
                    "Description",
                    "enrichmentScore",
                    "pvalue",
                    "p.adjust",
                    "rank")
  }
  result_object_result = result_object@result
  result_object_result$URL = paste0(
    "<a href=",
    url,
    result_object_result$ID,
    " target='_blank'>",
    result_object_result$ID,
    "</a>"
  )
  return(result_object_result[, select_cols])
}
