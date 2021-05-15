filter_by_padj <- function(result_object, padj) {
  result_object@result = result_object@result[result_object@result$p.adjust < padj,]
  validate(
    need(nrow(result_object@result) > 0, "No Data to show")
  )
  return(result_object)
}

###########################################################
# GSEA
get_GSEA_dotplot <- function(result_object, title, padj, nbCat = 20) {
  result_object = filter_by_padj(result_object, padj)
  validate(
    need(nrow(result_object@result) > 0, "No Data to show")
  )
  return(dotplot(result_object, showCategory = nbCat) + ggtitle(title))
}

get_GSEA_ridgeplot <- function(result_object, title, padj, nbCat = 20) {
  result_object = filter_by_padj(result_object, padj)
  validate(
    need(nrow(result_object@result) > 0, "No Data to show")
  )
  return(ridgeplot(result_object, showCategory = nbCat) + ggtitle(title))
}

get_GSEA_gseaplot <- function(result_object, title, padj, nbCat = 20) {
  result_object = filter_by_padj(result_object, padj)
  validate(
    need(nrow(result_object@result) > 0, "No Data to show")
  )
  return(gseaplot2(result_object, geneSetID = 1, title = title))
}

########################################################@
# SEA
get_SEA_upsetplot <- function(result_object, padj, title) {
  result_object = filter_by_padj(result_object, padj)
  validate(
    need(nrow(result_object@result) > 0, "No Data to show")
  )
  upsetplot(result_object, n = 10) + ggtitle(title)
}

get_SEA_dotplot <- function(result_object, padj, title) {
  result_object = filter_by_padj(result_object, padj)
  validate(
    need(nrow(result_object@result) > 0, "No Data to show")
  )
  dotplot(result_object, showCategory = 15) + ggtitle(title)
}

get_SEA_barplot <- function(result_object, padj, title) {
  result_object = filter_by_padj(result_object, padj)
  validate(
    need(nrow(result_object@result) > 0, "No Data to show")
  )
  barplot(result_object, showCategory = 15) + ggtitle(title)
}

###########################################################
# TABLE
render_result_table <- function(result_object, url, exp, padj) {
  result_object = filter_by_padj(result_object, padj)
  validate(
    need(nrow(result_object@result) > 0, "No Data to show")
  )
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
