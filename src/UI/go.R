source("./src/UI/sidebar.R")

goGsea <- function() {
  fluidPage(
    sidebar(
      "go_gsea_pvalue",
      "go_gsea_method",
      rest = selectInput(
        "ontology_gse",
        label = "GO sub-ontology:",
        choices = list("Biological Process" = "BP",
                       "Cellular Component" = "CC",
                       "Molecular Function" = "MF",
                       "ALL" = "ALL"),
        selected = "ALL"
      )
    ),
    box(plotOutput("goContent1"), width = 4),
    box(plotOutput("goContent2"), width = 4),
    box(plotOutput("goContent3"), width = 4),
    box(
      downloadButton("downloadData3", "Download"),
      hr(),
      dataTableOutput("go_GSEA_table"),
      width = 12
    ),
  )
}

goSea <- function() {
  fluidPage(
    sidebar(
      "go_sea_pvalue",
      "go_sea_method",
      rest = selectInput(
        # MARIE ! IDEM ICI
        "ontology_sea",
        label = "GO sub-ontology:",
        choices = list("Biological Process" = "BP",
                       "Cellular Component" = "CC",
                       "Molecular Function" = "MF",
                       "ALL" = "ALL"),
        selected = "CC"
      )
    ),
    box(plotOutput("goContent4"), width = 4),
    box(plotOutput("goContent5"), width = 4),
    box(plotOutput("goContent6"), width = 4),
    box(plotOutput("goContent7"), width = 12),
    box(
      downloadButton("downloadData4", "Download"),
      hr(),
      dataTableOutput("go_SEA_table"),
      width = 12
    )
  )
}
