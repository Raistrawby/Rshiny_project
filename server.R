library(shiny)

shinyServer(function(input, output) {
    output$contents <- renderDataTable({
        file <- input$input
        ext <- tools::file_ext(file$datapath)
        
        req(file)
        validate(need(ext == "csv", "Please upload a csv file"))
        
        read.csv(file$datapath, header = input$header)
    })
})