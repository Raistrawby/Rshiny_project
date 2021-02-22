inputUI <- function() {
  fluidPage(sidebarLayout(
    sidebarPanel(
      fileInput("input", "Choose CSV File", accept = c(".csv"), placeholder = "res_DE2.csv"),
      checkboxInput("header", "Header", TRUE)
    ),
    mainPanel(dataTableOutput("contents"))
  ))
}
