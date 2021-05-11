source("./src/server/pathway/GSEA.R")
source("./src/server/GSEA_SEA.R")

library(enrichplot)

pathway <-
  function(input,
           output,
           session,
           geneList) {
    ############################# GSEA
    
    KEGG_GSEA <- reactive({
      get_KEGG_GSEA(geneList$GSEA, input$espece)
    })
    
    output$KEGG_GSEA_table <- renderDataTable({
      render_result_table(KEGG_GSEA(),
                          "https://www.kegg.jp/kegg-bin/show_pathway?",
                          "gsea")
    }, escape = F)
    
    #ce que j'ai rajouté
    output$downloadData1 <-downloadHandler(
      filename= function(){
        paste("GSEA_pathway",".csv",sep="")
      },
      content=function(file){
        write.csv(KEGG_GSEA(),file,row.names=TRUE)
      }
    )
    # fin de ce que j'ai rajouté
    
    output$KEGG_GSEA_dotplot <- renderPlot({
      get_GSEA_dotplot(KEGG_GSEA(), 10, title="kegg dotplot")
    })
    
    output$KEGG_GSEA_ridgeplot <- renderPlot({
      get_GSEA_ridgeplot(KEGG_GSEA(), 10, title="kegg dotplot")
    })
    
    output$KEGG_GSEA_gseaplot <- renderPlot({
      get_GSEA_gseaplot(KEGG_GSEA(), title="kegg dotplot")
    })
    
    output$value <- renderPrint({
      input$GSEA_KEGG_selector
    })
    
    observeEvent(input$GSEA_KEGG_selector, {
      if (!is.null(input$GSEA_KEGG_selector)) {
        output$KEGG_GSEA_pathview <-
          renderImage({
            get_GSEA_pathway_image(geneList$GSEA, input$GSEA_KEGG_selector, input$espece)
          }, deleteFile = TRUE)
      }
    })
    
    observe({
      updateSelectInput(session,
                        "GSEA_KEGG_selector",
                        choices = KEGG_GSEA()@result$ID)
    })
    
    
    ############################## SEA
    
    KEGG_SEA <- reactive({
      get_SEA_KEGG(geneList$SEA, input$espece)
    })
    
    output$KEGG_SEA_table <- renderDataTable({
      render_result_table(KEGG_SEA(),
                          "https://www.kegg.jp/kegg-bin/show_pathway?",
                          "sea")
    }, escape = F)
    
    #ce que j'ai rajouté
    output$downloadData2 <-downloadHandler(
     filename= function(){
      paste("SEA_pathway",".csv",sep="")
      },
      content=function(file){
        write.csv(KEGG_SEA(),file,row.names=TRUE)
      }
    )
    # fin de ce que j'ai rajouté
    
    output$KEGG_SEA_upsetplot <- renderPlot({
      get_SEA_upsetplot(KEGG_SEA(), title="kegg upsetplot")
    })
    
    output$KEGG_SEA_barplot <- renderPlot({
      get_SEA_barplot(KEGG_SEA(), title="kegg barplot")
    })
    
    output$KEGG_SEA_dotplot <- renderPlot({
      get_SEA_dotplot(KEGG_SEA(), title="kegg dotplot")
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
            get_GSEA_pathway_image(geneList$SEA, input$SEA_KEGG_selector, input$espece)
          }, deleteFile = TRUE)
      }
    })
    
  }
