source("./src/UI/sidebar.R")

proteinDomainUI <- function() {
  fluidPage(tabsetPanel(
    type = "tabs",
    tabPanel(
      "GSEA",
      sidebar("protein_gsea_pvalue", "protein_gsea_method"),
      column(4,
             plotOutput("interpro_GSEA_dotplot")),
      column(4,
             plotOutput("interpro_GSEA_ridgeplot")),
      column(4,
             plotOutput("interpro_GSEA_gseaplot")),
      downloadButton("downloadData5", "Download"),
      dataTableOutput("interpro_GSEA_table")
    ),
    tabPanel(
      "SEA",
      sidebar("protein_sea_pvalue", "protein_sea_method"),
      column(4,
             plotOutput("interpro_SEA_dotplot")),
      column(4,
             plotOutput("interpro_SEA_barplot")),
      column(4,
             plotOutput("interpro_SEA_upsetplot")),
      downloadButton("downloadData6", "Download"),
      dataTableOutput("interpro_SEA_table")
    )
  ))
}