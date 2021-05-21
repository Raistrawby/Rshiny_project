library(tidyverse)

# load_data <- function() {
#   geneExpression = readFile("", T, "SYMBOL", org.Hs.eg.db)
#   geneList <- get_geneList(geneExpression, 0.75)
#   
#   go_gse <- gse_analysis(geneList, "SYMBOL")
#   go_sea <- sea_analysis(geneList, "SYMBOL")
#   
#   KEGG_GSEA <- get_KEGG_GSEA(geneList$GSEA, "hsa")
#   KEGG_SEA <- get_SEA_KEGG(geneList$SEA, "hsa")
#   
#   interpro_db <- get_interpro_db(names(geneList$GSEA), "hsa")
#   interpro_gsea <- get_interpro_gsea(geneList$GSEA, interpro_db)
#   interpro_sea <- get_interpro_sea(names(geneList$SEA), interpro_db)
#   
#   return(
#     list(
#       "go_gse" = go_gse,
#       "go_sea" = go_sea,
#       "KEGG_GSEA" = KEGG_GSEA,
#       "KEGG_SEA" = KEGG_SEA,
#       "interpro_gsea" = interpro_gsea,
#       "interpro_sea" = interpro_sea
#     )
#   )
# }

create_small_df <- function(result_obj, source, analysis) {
  filtered_df = data.frame(result_obj@result$pvalue, source, analysis)
  colnames(filtered_df) = c("p.adjust", "source", "analysis")
  return(filtered_df)
}

create_all_set_df <- function(data) {
  small_go_sea = create_small_df(data$go_sea, "GO", "SEA")
  small_go_gsea = create_small_df(data$go_gse, "GO", "GSEA")
  small_kegg_sea = create_small_df(data$KEGG_SEA, "KEGG", "SEA")
  small_kegg_gsea = create_small_df(data$KEGG_GSEA, "KEGG", "GSEA")
  small_ip_sea = create_small_df(data$interpro_sea, "INTERPRO", "SEA")
  small_ip_gsea = create_small_df(data$interpro_gsea, "INTERPRO", "GSEA")
  rbind(
    small_go_sea,
    small_go_gsea,
    small_kegg_sea,
    small_kegg_gsea,
    small_ip_sea,
    small_ip_gsea
  )
}

getManatthanPlot <- function(go_gse, go_sea, KEGG_GSEA, KEGG_SEA, interpro_gsea, interpro_sea){
  data = list(
          "go_gse" = go_gse,
          "go_sea" = go_sea,
          "KEGG_GSEA" = KEGG_GSEA,
          "KEGG_SEA" = KEGG_SEA,
          "interpro_gsea" = interpro_gsea,
          "interpro_sea" = interpro_sea
        )
  test = create_all_set_df(data)
  test$position = seq.int(nrow(test))
  test %>%
    group_by(source, analysis) %>%
    mutate(position = sample(position)) %>%
    mutate(test = paste(source, analysis)) %>%
    ggplot(aes(
      x = position,
      y = -log(p.adjust),
      color = paste(source, analysis)
    )) +
    geom_point(alpha = 0.7) +
    facet_grid(. ~ test,
               scales = "free_x",
               space = "free_x",
               switch = "x") +
    scale_y_continuous(limits = c(0, 20), expand = c(0, 0)) +
    labs(fill = "Source and analysis type") +
    theme_bw() +
    geom_hline(yintercept = -log(0.05), linetype = "dashed") +
    theme(
      axis.title.x = element_blank(),
      axis.text.x = element_blank(),
      axis.ticks.x = element_blank(),
      panel.grid = element_blank(),
      panel.grid.major = element_blank(),
      axis.line.y = element_blank(),
      panel.grid.minor = element_blank(),
      strip.background = element_blank(),
      panel.border = element_rect(fill = NA),
      strip.text = element_text(face = "bold"),
      strip.text.x = element_text(angle = 90, hjust = 1),
      legend.position = "none"
    )
}
