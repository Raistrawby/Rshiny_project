source("./src/inputUI.R")
source("./src/generalAnalysisUI.R")
source("./src/goUI.R")
source("./src/pathwayUI.R")
source("./src/proteinDomainUI.R")
source("./src/exportUI.R")

library(shiny)

shinyUI(
    navbarPage(
        "Notre superbe app avec Logo",
        tabPanel("Input",
                 inputUI()),
        tabPanel("General Analysis",
                 generalAnalysisUI()),
        tabPanel("Go Analysis",
                 goUI()),
        tabPanel("Pathway enrichment",
                 pathwayUI()),
        tabPanel("Protein Domain enrichment",
                 proteinDomainUI()),
        tabPanel("Export",
                 exportUI())
    )
)