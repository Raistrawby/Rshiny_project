inputUI <- function() {
  fluidPage(sidebarLayout(
    sidebarPanel(
      fileInput("input", "Choose CSV File", accept = c(".csv"), placeholder = "exemple.csv"),
      checkboxInput("exemple", "Exemple data", FALSE)
    ),
    mainPanel(dataTableOutput("contents"))
  ))
}