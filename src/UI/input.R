inputUI <- function() {
  fluidPage(sidebarLayout(
    sidebarPanel(
      fileInput("input", "Choose CSV File", accept = c(".csv"), placeholder = "exemple.csv"),
      checkboxInput("exemple", "Exemple data", FALSE),
      selectInput("select", label = h3("Select box"), 
                  choices = list("Anophele" = 1, "Arabidopsis" = 2, "Bovine" = 3, "Worm" = 4,"Canine" = 5,"Fly" = 6, "ZebraFish" = 7, "Ecoli K12" = 8, "Ecoli Sakai" = 9, "Chicken" = 10, "Human" = 11, "Mouse" = 11,
                                 "Rhesus" = 12, "Myxococcus xanthus DK 1622" =13 , "Malaria" =14, "Chimp" =15, "Rat" =16, "Yeast" = 17, "Pig" = 19, "Xenopus" = 20), selected = 1),
      
      hr(),
      fluidRow(column(3, verbatimTextOutput("value"))),
    ),
    mainPanel(dataTableOutput("contents"))
  ))
}
