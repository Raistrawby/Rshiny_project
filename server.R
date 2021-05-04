source("./src/server/WDI.R")
source("./src/server/input.R")
source("./src/server/GO.R")

library(shiny)

shinyServer(function(input, output, session) {
    # Input tab ############################
    geneExpression <-
        reactive({
            readFile(input$input, input$exemple)
        })
    output$contents <- renderDataTable({
        geneExpression()
    })
    
    output$value1 <- renderPrint({ input$select1 }) # espece
    output$value2 <- renderPrint({ input$select2 }) # type ID
    
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
    # GSEA
    gse <- reactive ({
       gse <-  gse_analysis(geneExpression())
    })
    
    output$goContent1 <- renderPlot({
        display_dotplot(gse())
    })
    output$goContent2 <- renderPlot({
        display_ridgeplot(gse())
    })
    output$goContent3 <- renderPlot({
        display_gseplot(gse())
    })
    
    # SEA
})