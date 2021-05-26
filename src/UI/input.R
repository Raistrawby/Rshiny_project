inputUI <- function() {
  fluidRow(box(
    div(
      fileInput(
        "input",
        "Choose a CSV File",
        accept = c(".csv"),
        placeholder = "exemple.csv"
      ),
      checkboxInput("exemple", "Or use an example dataset", FALSE),
    ),
    selectInput(
      "espece",
      label = h4("Specie:"),
      choices = list(
        "Anophele" = "aga",
        "Arabidopsis" = "ath",
        "Bovine" = "bta",
        "Worm" = "cel",
        "Canine" = "cfa",
        "Fly" = "dme",
        "ZebraFish" = "dre",
        "Ecoli K12" = "eco",
        "Ecoli Sakai" = "ecs",
        "Chicken" = "gga",
        "Human" = "hsa",
        "Mouse" = "mmu",
        "Rhesus" = "mcc",
        "Myxococcus xanthus DK 1622" = "mxa",
        "Malaria" = "pfa",
        "Chimpanzee" = "ptr",
        "Rat" = "rno",
        "Yeast" = "sce",
        "Pig" = "ssc",
        "Xenopus" = "xla"
      ),
      selected = "hsa"
    ),
    
    selectInput(
      "id",
      label = h4("ID source:"),
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