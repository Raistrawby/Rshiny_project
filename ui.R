source("./src/UI/input.R")
source("./src/UI/generalAnalysis.R")
source("./src/UI/go.R")
source("./src/UI/pathway.R")
source("./src/UI/proteinDomain.R")
source("./src/UI/export.R")

library(shiny)
library(shinyWidgets)

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