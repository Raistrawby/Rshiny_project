library(biomaRt)
source("./src/server/protein_domain/SEA.R")

protein <-
  function(input,
           output,
           session,
           geneList) {
    ############################# GSEA
    
    INTERPRO_GSEA <- reactive({
      get_SEA_INTERPRO(geneList, input$espece)
    })
    
    output$INTERPRO_SEA_barplot <- renderPlot({
      get_INTERPRO_SEA_barplot(INTERPRO_GSEA(), 25)
    })
  }
