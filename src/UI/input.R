inputUI <- function() {
  fluidPage(sidebarLayout(
    sidebarPanel(
      fileInput("input", "Choose CSV File", accept = c(".csv"), placeholder = "exemple.csv"),
      checkboxInput("exemple", "Exemple data", FALSE),
      selectInput("select", label = h3("Select box"), 
                  choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3), 
                  selected = 1),
      
      hr(),
      fluidRow(column(3, verbatimTextOutput("value")))
    ),
    mainPanel(dataTableOutput("contents"))
  ))
}
