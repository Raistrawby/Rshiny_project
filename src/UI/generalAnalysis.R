generalAnalysisUI <- function() {
  fluidPage(sidebarLayout(
    sidebarPanel(),
    mainPanel(plotOutput("volcanoPlot"))
  ))
}