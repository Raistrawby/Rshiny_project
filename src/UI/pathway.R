source("./src/UI/sidebar.R")

pathwayGSEA <- function() {
  fluidPage(
    sidebar("pathway_gsea_pvalue", "pathway_gsea_method"),
    box(plotOutput("KEGG_GSEA_dotplot"), width = 6),
    box(plotOutput("KEGG_GSEA_ridgeplot"), width = 6),
    box(plotOutput("KEGG_GSEA_gseaplot"), width = 12),
    box(
      selectInput(
        "GSEA_KEGG_selector",
        label = h4("KEGG pathway"),
        choices = list()
      ),
      imageOutput("KEGG_GSEA_pathview")
    ),
    box(
      downloadButton("downloadData1", "Download"),
      hr(),
      dataTableOutput("KEGG_GSEA_table")
    )
  )
}

pathwaySEA <- function() {
  fluidPage(
    sidebar("pathway_sea_pvalue", "pathway_sea_method"),
    box(plotOutput("KEGG_SEA_dotplot"), width = 6),
    box(plotOutput("KEGG_SEA_barplot"), width = 6),
    box(plotOutput("KEGG_SEA_upsetplot"), width = 12),
    box(
      selectInput(
        "SEA_KEGG_selector",
        label = h4("KEGG pathway"),
        choices = list()
      ),
      imageOutput("KEGG_SEA_pathview")
    ),
    box(
      downloadButton("downloadData2", "Download"),
      hr(),
      dataTableOutput("KEGG_SEA_table")
    )
  )
}