goUI <- function() {
  fluidPage(sidebarLayout(
    sidebarPanel(),
    mainPanel(dataTableOutput("goContent"))
  ))
}






