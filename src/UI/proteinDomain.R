source("./src/UI/sidebar.R")

proteinGsea <- function() {
  fluidPage(tabPanel(
    "GSEA",
    sidebar("protein_gsea_pvalue", "protein_gsea_method"),
    box(plotOutput("interpro_GSEA_dotplot"), width = 6),
    box(plotOutput("interpro_GSEA_ridgeplot"), width = 6),
    box(plotOutput("interpro_GSEA_gseaplot"), width = 12),
    box(
      downloadButton("downloadData5", "Download"),
      hr(),
      dataTableOutput("interpro_GSEA_table"),
      width = 12
    )
  ))
}

proteinSea <- function() {
  fluidPage(
    sidebar("protein_sea_pvalue", "protein_sea_method"),
    box(plotOutput("interpro_SEA_dotplot"), width = 6),
    box(plotOutput("interpro_SEA_barplot"), width = 6),
    box(plotOutput("interpro_SEA_upsetplot"), width = 12),
    box(
      downloadButton("downloadData6", "Download"),
      hr(),
      dataTableOutput("interpro_SEA_table"),
      width = 12
    )
  )
}