inputUI <- function() {
  fluidPage(sidebarLayout(
    sidebarPanel(
      fileInput("input", "Choose CSV File", accept = c(".csv")),
      checkboxInput("header", "Header", TRUE)
    ),
    mainPanel(dataTableOutput("contents"))
  ))
}
