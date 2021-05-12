proteinDomainUI <- function() {
  fluidPage(tabsetPanel(
    type = "tabs",
    tabPanel(
      "GSEA",
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