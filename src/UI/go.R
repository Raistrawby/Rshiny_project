source("./src/UI/sidebar.R")

goUI <- function() {
  tabsetPanel(
    tabPanel(
      "GSEA",
      sidebar(
        "go_gsea_pvalue",
        "go_gsea_method",
        rest = selectInput(
          # MARIE ! Passe ton bouton de sélecteur Go en remplaçant le bonton d'en dessous
          # Avec ton sélecteur ALL/BP etc il s'ajoutera à droite des 2 autres
          "test_2",
          label = "Choix Go GSEA",
          choices = list(
            "FDR" = "fdr",
            "Bonferroni" = "bonferroni"
          ),
          selected = "fdr"
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
    ),
    tabPanel(
      "SEA/ORA",
      sidebar(
        "go_sea_pvalue",
        "go_sea_method",
        rest = selectInput(
          # MARIE ! IDEM ICI
          "test_1",
          label = "Choix Go SEA",
          choices = list(
            "FDR" = "fdr",
            "Bonferroni" = "bonferroni"
          ),
          selected = "fdr"
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
        width = 12,
        height="1000px"
      )
    )
  )
}