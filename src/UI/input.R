inputUI <- function() {
  fluidRow(box(
    div(
      fileInput(
        "input",
        "Ajoutez votre fichier CSV",
        accept = c(".csv"),
        placeholder = "exemple.csv"
      ),
      checkboxInput("exemple", "Exemple data", FALSE),
    ),
    selectInput(
      "espece",
      label = h4("Espèce :"),
      choices = list(
        "Anophele" = 1,
        "Arabidopsis" = 2,
        "Bovine" = 3,
        "Worm" = 4,
        "Canine" = 5,
        "Fly" = 6,
        "ZebraFish" = 7,
        "Ecoli K12" = 8,
        "Ecoli Sakai" = 9,
        "Chicken" = 10,
        "Human" = "hsa",
        "Mouse" = 11,
        "Rhesus" = 12,
        "Myxococcus xanthus DK 1622" = 13,
        "Malaria" = 14,
        "Chimp" = 15,
        "Rat" = 16,
        "Yeast" = 17,
        "Pig" = 19,
        "Xenopus" = 20
      ),
      selected = "hsa"
    ),
    
    selectInput(
      "id",
      label = h4("Type d'ID"),
      choices = list(
        "ENSEMBL" = "ENSEMBL",
        "ENTREZID" = "ENTREZID",
        "SYMBOL" = "SYMBOL",
        "UNIPROT" = "UNIPROT"
      ),
      selected = "SYMBOL"
    ),
    width = 3
  ),
  box(dataTableOutput("contents")), width=9)
}