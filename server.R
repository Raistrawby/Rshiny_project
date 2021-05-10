source("./src/server/WDI.R")
source("./src/server/input.R")
source("./src/server/pathway.R")
source("./src/server/protein_domain/protein_domain.R")

library(shiny)
library(org.Hs.eg.db)
library(plotly)

shinyServer(function(input, output, session) {
    # Input tab ############################
    geneExpression <-
        reactive({
            readFile(input$input, input$exemple, input$id, org.Hs.eg.db)
        })
    
    geneList <- reactive({
        geneList <- get_geneList(geneExpression(), input$pvalue)
    })
    
    output$contents <- renderDataTable({
        # Render table without ENTREZID col
        geneExpression()[,-2]
    })
    
    output$espece <- renderPrint({ input$espece }) # espece
    output$id <- renderPrint({ input$id }) #type ID
    
    # WDI tab ##############################
    output$volcanoPlot <-
        renderPlot({
            volcanoPlot(geneExpression(), input$logFCFilter, input$pvalue)
        })
    
    output$MAPlot <-
        renderPlot({
            MAPlot(geneExpression(), input$pvalue)
        })
    
    observe({
        # Rounded to 0 or 0.5
        log2Max = ceiling(max(geneExpression()$log2FoldChange) * 2) / 2
        updateSliderInput(session, "slider1", max = log2Max)
    })
    
    output$value <- renderPrint({
        input$slider1
    })
    
    output$filteredDataTable <-
        renderDataTable({
            subset(geneExpression(), padj < input$pvalue)
        })
    # GO tab ################################
    
    
    # Pathway tab ###########################
    pathway(input,
            output,
            session,
            geneList())
    
    # Protein domains #######################
    protein(input,
            output,
            session,
            geneList())
})