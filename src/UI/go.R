goUI <- function() {
  fluidPage(sidebarLayout(
    sidebarPanel(),
    mainPanel(
      column(6,
             plotOutput("goContent1")),
      column(6,
             plotOutput("goContent2")),
      plotOutput('goContent3')
  ))
)}
