generalAnalysisUI <- function() {
  fluidPage(sidebarLayout(
    sidebarPanel(
      h3("Input:"),
      shinyWidgets::sliderTextInput(
        "pvalue",
        "Choose an adjusted p-value threshold:",
        choices = c(0.00001, 0.0001, 0.001, 0.01, 0.05, 0.1, 0.5, 1),
        selected = 0.05,
        grid = T
      ),
      
      hr(style = "border-top: 1px solid #cccccc;"),
      
      h3("Volcano Plot:"),
      sliderInput(
        "logFCFilter",
        label = "Threshold for Log2FoldChange:",
        min = 0,
        max = 5,
        value = 0.75,
        step = 0.05
      ),
      # je rajoute ici
      downloadButton("downloadData", "Download"),
      #je rajoute la
      width = 3
    ),
    mainPanel(
      column(6,
             plotOutput("volcanoPlot"),),
      column(6,
             plotOutput("MAPlot")),
      dataTableOutput("filteredDataTable")
    )
  ))
}