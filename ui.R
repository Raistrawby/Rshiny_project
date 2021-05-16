source("./src/UI/input.R")
source("./src/UI/generalAnalysis.R")
source("./src/UI/go.R")
source("./src/UI/pathway.R")
source("./src/UI/proteinDomain.R")
source("./src/UI/export.R")

library(shiny)
library(shinyWidgets)
library(shinydashboard)

dashboardPage(
    dashboardHeader(title = "Notre superbe app"),
    dashboardSidebar(
        sidebarMenu(
            menuItem(tabName = "input",
                     "Input"),
            menuItem(tabName = "wdi",
                     "Whole Data Inspection"),
            menuItem(tabName = "go",
                     "Go Terms Enrichment"),
            menuItem(tabName = "kegg",
                     "Pathway Enrichment"),
            menuItem(tabName = "protein",
                     "Protein Domain Enrichment"),
            menuItem(tabName = "manhattan",
                     "Manhattan Plot")
        )
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName = "input",
                    inputUI()),
            tabItem(tabName = "wdi",
                    generalAnalysisUI()),
            tabItem(tabName = "go",
                    goUI()),
            tabItem(tabName = "kegg",
                    pathwayUI()),
            tabItem(tabName = "protein",
                    proteinDomainUI()),
            tabItem(tabName = "manhattan",
                    exportUI())
        )
    )
)