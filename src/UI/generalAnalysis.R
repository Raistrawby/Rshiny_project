generalAnalysisUI <- function() {
  fluidPage(
    box(fluidRow(
      column(
        width = 4,
        shinyWidgets::sliderTextInput(
          "pvalue",
          "Adjusted p-value threshold:",
          choices = c(0.00001, 0.0001, 0.001, 0.01, 0.05, 0.1, 0.5, 1),
          selected = 0.05,
          grid = T
        ),
      ),
      column(
        width = 3,
        sliderInput(
          "logFCFilter",
          label = "Threshold for Log2FoldChange:",
          min = 0,
          max = 5,
          value = 1,
          step = 0.1
        ),
      )
    ),
    width = 12),
    box(plotOutput("volcanoPlot")),
    box(plotOutput("MAPlot")),
    box(
      downloadButton("downloadData", "Download filtered data"),
      hr(),
      dataTableOutput("filteredDataTable"),
      width = 12
    )
  )
}