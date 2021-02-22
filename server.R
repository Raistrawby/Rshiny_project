source("./src/UI/export.R")

library(shiny)

shinyServer(function(input, output) {
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
    
    output$contents <-
        renderDataTable({
            geneExpression()
        })
    
    output$goContent <-
        renderDataTable({
            geneExpression()
        })
    
    output$volcanoPlot <- renderPlot({volcanoPlot(geneExpression(), 0.6, 0.05)})
})