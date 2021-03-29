inputUI <- function() {
  fluidPage(sidebarLayout(sidebarPanel(
    fileInput(
      "input",
      "Choose CSV File",
      accept = c(".csv"),
      placeholder = "donnee2.csv"
    )
  ),
  mainPanel(dataTableOutput("contents"))))
}
