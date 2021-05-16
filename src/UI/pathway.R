source("./src/UI/sidebar.R")

pathwayUI <- function() {
  fluidPage(tabsetPanel(
    type = "tabs",
    tabPanel(
      "GSEA",
      sidebar("pathway_gsea_pvalue", "pathway_gsea_method"),
      column(
        4,
        plotOutput("KEGG_GSEA_dotplot")
      ),
      column(
        4,
        plotOutput("KEGG_GSEA_ridgeplot")
      ),
      column(
        4,
        plotOutput("KEGG_GSEA_gseaplot")
      ),
      column(
        6,
        selectInput(
          "GSEA_KEGG_selector",
          label = h4("KEGG pathway"),
          choices = list()
        ),
        imageOutput("KEGG_GSEA_pathview")
      ),
      column(
        6,
        downloadButton("downloadData1", "Download"),
        dataTableOutput("KEGG_GSEA_table")
      )
    ),
    tabPanel(
      "SEA/ORA",
      sidebar("pathway_sea_pvalue", "pathway_sea_method"),
      column(
        4,
        plotOutput("KEGG_SEA_dotplot")
      ),
      column(
        4,
        plotOutput("KEGG_SEA_barplot")
      ),
      column(
        4,
        plotOutput("KEGG_SEA_upsetplot")
      ),
      column(
        6,
        selectInput(
          "SEA_KEGG_selector",
          label = h4("KEGG pathway"),
          choices = list()
        ),
        imageOutput("KEGG_SEA_pathview")
      ),
      column(
        6,
        # je rajoute ici
        downloadButton("downloadData2", "Download"),
        # je rajoute la)
        dataTableOutput("KEGG_SEA_table")
      )
    )
  ))
}