source("./src/UI/export.R")

library(shiny)

shinyServer(function(input, output, session) {
    # Input tab
    geneExpression <- reactive({
        file <- input$input
        if(is.null(file)) {
            data = read.csv("data/res_DE2.csv", header = input$header)
        } else {
            ext <- tools::file_ext(input$input$datapath)
            validate(need(ext == "csv", "Please upload a csv file"))
            data = read.csv(file$datapath, header = input$header)
        }
    })
    output$contents <- renderDataTable({
        geneExpression()
    })
    
    # WDI tab
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
        updateSliderInput(session, "slider1", max=log2Max)
    })
    output$value <- renderPrint({ input$slider1 })
    
    # GO tab
    output$goContent <- renderDataTable({
        geneExpression()
    })
})