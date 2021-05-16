source("./src/UI/sidebar.R")

proteinDomainUI <- function() {
  tabsetPanel(
    type = "tabs",
    tabPanel(
      "GSEA",
      sidebar("protein_gsea_pvalue", "protein_gsea_method"),
      box(plotOutput("interpro_GSEA_dotplot"), width=4),
      box(plotOutput("interpro_GSEA_ridgeplot"), width=4),
      box(plotOutput("interpro_GSEA_gseaplot"), width=4),
      box(
        downloadButton("downloadData5", "Download"),
        hr(),
        dataTableOutput("interpro_GSEA_table"),
        width = 12,
        height="1000px"
      )
    ),
    tabPanel(
      "SEA/ORA",
      sidebar("protein_sea_pvalue", "protein_sea_method"),
      box(plotOutput("interpro_SEA_dotplot"), width=4),
      box(plotOutput("interpro_SEA_barplot"), width=4),
      box(plotOutput("interpro_SEA_upsetplot"), width=4),
      box(
        downloadButton("downloadData6", "Download"),
        hr(),
        dataTableOutput("interpro_SEA_table"),
        width = 12,
        height="1000px"
      )
    )
  )
}