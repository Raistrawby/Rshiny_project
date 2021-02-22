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
        tabPanel("Whole data inspection",
                 generalAnalysisUI()),
        tabPanel("GO terms enrichement",
                 goUI()),
        tabPanel("Pathway enrichment",
                 pathwayUI()),
        tabPanel("Protein Domain enrichment",
                 proteinDomainUI()),
        tabPanel("Export",
                 exportUI())
    )
)