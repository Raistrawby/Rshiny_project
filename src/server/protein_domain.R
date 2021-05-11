library(biomaRt)
source("./src/server/protein_domain/interpro.R")
source("./src/server/GSEA_SEA.R")

protein <-
  function(input,
           output,
           session,
           geneList) {
    ############################# INTERPRO
    interpro_db <- reactive({
      get_interpro_db(names(geneList$GSEA), input$espece)
    })
    
    # GSEA
    interpro_gsea <- reactive({
      get_interpro_gsea(geneList$GSEA, interpro_db())
    })
    
    output$interpro_GSEA_dotplot <- renderPlot({
      get_GSEA_dotplot(interpro_gsea(), 1, "dotplot interpro")
    })
    
    output$interpro_GSEA_ridgeplot <- renderPlot({
      get_GSEA_ridgeplot(interpro_gsea(), nbCat = 1, title = "ridgeplot interpro")
    })
    
    output$interpro_GSEA_gseaplot <- renderPlot({
      get_GSEA_gseaplot(interpro_gsea(), title = "gseaplot interpro")
    })
    
    output$interpro_GSEA_table <- renderDataTable({
      render_result_table(interpro_gsea(),
                         "https://www.ebi.ac.uk/interpro/entry/InterPro/",
                         "gsea")
    }, escape = F)
    
    # SEA
    interpro_sea <- reactive({
      get_interpro_sea(names(geneList$SEA), interpro_db())
    })
    
    output$interpro_SEA_dotplot <- renderPlot({
      get_SEA_dotplot(interpro_sea(), "dotplot interpro")
    })
    
    output$interpro_SEA_upsetplot <- renderPlot({
      get_SEA_upsetplot(interpro_sea(), title = "upsetplot interpro")
    })
    
    output$interpro_SEA_barplot <- renderPlot({
      get_SEA_barplot(interpro_sea(), title = "barplot interpro")
    })
    
    output$interpro_SEA_table <- renderDataTable({
      render_result_table(interpro_sea(),
                         "https://www.ebi.ac.uk/interpro/entry/InterPro/",
                         "sea")
    }, escape = F)
  }
