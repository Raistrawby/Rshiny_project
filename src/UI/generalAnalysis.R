generalAnalysisUI <- function() {
  fluidPage(sidebarLayout(
    sidebarPanel(
      shinyWidgets::sliderTextInput(
        "pvalue",
        "Choose an p-adjusted threshold:",
        choices = c(0.00001, 0.0001, 0.001, 0.01, 0.05, 0.1, 0.5, 1),
        selected = 0.05,
        grid = T
      ),
      hr(style = "border-top: 1px solid #cccccc;"),
      sliderInput(
        "logFCFilter",
        label = "Threshold for Log2FoldChange:",
        min = 0,
        max = 5,
        value = 1,
        step = 0.1
      ),
      hr(style = "border-top: 1px solid #cccccc;"),
      downloadButton("downloadData", "Download filtered data"),
      width = 3
    ),
    mainPanel(
      column(
        6,
        plotOutput("volcanoPlot"),
      ),
      column(
        6,
        plotOutput("MAPlot")
      ),
      dataTableOutput("filteredDataTable")
    )
  ))
}