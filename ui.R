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
                     "Go Terms Enrichment",
                     menuSubItem("GSEA", tabName = "goGsea"),
                     menuSubItem("SEA/ORA", tabName = "goSea")),
            
            menuItem(tabName = "kegg",
                     "Pathway Enrichment",
                     menuSubItem("GSEA", tabName = "keggGsea"),
                     menuSubItem("SEA/ORA", tabName = "keggSea")),
            
            menuItem(tabName = "protein",
                     "Protein Domain Enrichment",
                     menuSubItem("GSEA", tabName = "proteinGsea"),
                     menuSubItem("SEA/ORA", tabName = "proteinSea")),
            
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
            
            tabItem(tabName = "goGsea",
                    goGsea()),
            tabItem(tabName = "goSea",
                    goSea()),
            
            tabItem(tabName = "keggGsea",
                    pathwayGSEA()),
            tabItem(tabName = "keggSea",
                    pathwaySEA()),
            
            tabItem(tabName = "proteinGsea",
                    proteinGsea()),
            tabItem(tabName = "proteinSea",
                    proteinSea()),
            
            tabItem(tabName = "manhattan",
                    exportUI())
        )
    )
)