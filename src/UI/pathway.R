pathwayUI <- function() {
  fluidPage(tabsetPanel(
    type = "tabs",
    tabPanel(
      "GSEA",
      column(6,
             plotOutput("KEGG_GSEA_dotplot")),
      column(6,
             plotOutput("KEGG_GSEA_ridgeplot")),
      column(6,
             imageOutput("KEGG_GSEA_pathview")),
      column(6,
             dataTableOutput("KEGG_GSEA_table"))
    ),
    tabPanel("SEA", verbatimTextOutput("summary"))
  ))
}
