inputUI <- function() {
  fluidPage(# Application title
    titlePanel("Projet Rshiny"),
    
    sidebarLayout(
      sidebarPanel(
        fileInput("input", "Choose CSV File", accept = c(".csv")),
        checkboxInput("header", "Header", TRUE)
      ),
      mainPanel(dataTableOutput("contents"))
    ))
}
