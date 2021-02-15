library(shiny)

shinyServer(function(input, output) {
    geneExpression <- reactive({
        file <- input$input
        ext <- tools::file_ext(input$input$datapath)
        req(file)
        validate(need(input$input, ext == "csv", "Please upload a csv file"))
        data = read.csv(file$datapath, header = input$header)
    })

    output$contents <-
        renderDataTable({
            geneExpression()
        })
})