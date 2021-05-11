goUI <- function() {
  fluidPage(sidebarLayout(
    sidebarPanel(
      width = 2,
      selectInput(
        "ontology",
        label = h4("Ontologie"),
        choices = list(
          "Molecular Function" = "MF",
          "Cellular Component" = "CC",
          "Biological Process" = "BP",
          "All" = "ALL"
        ),
        selected = "CC"
      ),
      verbatimTextOutput("ontology")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(
          "GSEA",
          column(
            6,
            plotOutput("goContent1")
          ),
          column(
            6,
            plotOutput("goContent2")
          ),
          plotOutput("goContent3")
        ),
        tabPanel(
          "SEA",
          column(
            6,
            plotOutput("goContent4")
          ),
          column(
            6,
            plotOutput("goContent5")
          ),
          column(
            6,
            plotOutput("goContent6")
          ),
          column(
            6,
            plotOutput("goContent7")
          )
        )
      )
    )
  ))
}