proteinDomainUI <- function() {
  fluidPage(tabsetPanel(type = "tabs",
                        tabPanel("GSEA",),
                        tabPanel("SEA",
                                 column(
                                   4,
                                   plotOutput("INTERPRO_SEA_barplot")
                                 ))))
}