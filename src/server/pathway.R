source("./src/server/pathway/GSEA.R")
source("./src/server/GSEA_SEA.R")

library(enrichplot)

pathway <-
  function(input,
           output,
           session,
           KEGG_GSEA,
           KEGG_SEA,
           geneList) {
    ############################# GSEA
    output$KEGG_GSEA_table <- renderDataTable({
      render_result_table(KEGG_GSEA(),
                          "https://www.kegg.jp/kegg-bin/show_pathway?",
                          "gsea", input$pathway_gsea_pvalue)
    }, escape = F)
    
    output$downloadData1 <- downloadHandler(
      filename = function() {
        paste("GSEA_pathway", ".csv", sep = "")
      },
      content = function(file) {
        write.csv(KEGG_GSEA(), file, row.names = TRUE)
      }
    )
    
    output$KEGG_GSEA_dotplot <- renderPlot({
      get_GSEA_dotplot(KEGG_GSEA(), title = "Dotplot - KEGG GSEA", input$pathway_gsea_pvalue)
    })
    
    output$KEGG_GSEA_ridgeplot <- renderPlot({
      get_GSEA_ridgeplot(KEGG_GSEA(), title = "Ridgeplot - KEGG GSEA", input$pathway_gsea_pvalue)
    })
    
    output$KEGG_GSEA_gseaplot <- renderPlot({
      get_GSEA_gseaplot(KEGG_GSEA(), title = "GSEAplot - KEGG GSEA", input$pathway_gsea_pvalue)
    })
    
    output$value <- renderPrint({
      input$GSEA_KEGG_selector
    })
    
    observeEvent(input$GSEA_KEGG_selector, {
      if (!is.null(input$GSEA_KEGG_selector)) {
        output$KEGG_GSEA_pathview <-
          renderImage({
            get_GSEA_pathway_image(geneList()$GSEA,
                                   input$GSEA_KEGG_selector,
                                   input$espece)
          }, deleteFile = TRUE)
      }
    })
    
    observe({
      updateSelectInput(session,
                        "GSEA_KEGG_selector",
                        choices = KEGG_GSEA()@result$ID)
    })
    
    
    ############################## SEA
    output$KEGG_SEA_table <- renderDataTable({
      render_result_table(KEGG_SEA(),
                          "https://www.kegg.jp/kegg-bin/show_pathway?",
                          "sea", input$pathway_sea_pvalue)
    }, escape = F)
    
    output$downloadData2 <- downloadHandler(
      filename = function() {
        paste("SEA_pathway", ".csv", sep = "")
      },
      content = function(file) {
        write.csv(KEGG_SEA(), file, row.names = TRUE)
      }
    )
    
    output$KEGG_SEA_upsetplot <- renderPlot({
      get_SEA_upsetplot(KEGG_SEA(), title = "Upsetplot - KEGG SEA", input$pathway_sea_pvalue)
    })
    
    output$KEGG_SEA_barplot <- renderPlot({
      get_SEA_barplot(KEGG_SEA(), title = "Barplot - KEGG SEA", input$pathway_sea_pvalue)
    })
    
    output$KEGG_SEA_dotplot <- renderPlot({
      get_SEA_dotplot(KEGG_SEA(), title = "Dotplot - KEGG SEA", input$pathway_sea_pvalue)
    })
    
    output$value <- renderPrint({
      input$SEA_KEGG_selector
    })
    
    observe({
      updateSelectInput(session,
                        "SEA_KEGG_selector",
                        choices = KEGG_SEA()@result$ID)
    })
    
    
    observeEvent(input$SEA_KEGG_selector, {
      if (!is.null(input$SEA_KEGG_selector)) {
        output$KEGG_SEA_pathview <-
          renderImage({
            get_GSEA_pathway_image(geneList()$SEA,
                                   input$SEA_KEGG_selector,
                                   input$espece)
          }, deleteFile = TRUE)
      }
    })
    
  }
