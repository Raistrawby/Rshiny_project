source("./src/server/pathway/GSEA.R")
source("./src/server/pathway/SEA.R")

library(enrichplot)

pathway <-
  function(input,
           output,
           session,
           geneList,
           org) {
    ############################# GSEA
    
    KEGG_GSEA <- reactive({
      get_KEGG_GSEA(geneList, org, pvalueCutoff = input$pvalue)
    })
    
    output$KEGG_GSEA_table <- renderDataTable({
      get_KEGG_GSEA_table(KEGG_GSEA())
    }, escape = F)
    
    
    output$KEGG_GSEA_dotplot <- renderPlot({
      get_KEGG_GSEA_dotplot(KEGG_GSEA(), 10)
    })
    
    output$KEGG_GSEA_ridgeplot <- renderPlot({
      get_KEGG_GSEA_ridgeplot(KEGG_GSEA(), 10)
    })
    
    output$KEGG_GSEA_gseaplot <- renderPlot({
      get_KEGG_GSEA_gseaPlot(KEGG_GSEA())
    })
    
    output$value <- renderPrint({
      input$GSEA_KEGG_selector
    })
    
    observeEvent(input$GSEA_KEGG_selector, {
      if (!is.null(input$GSEA_KEGG_selector)) {
        output$KEGG_GSEA_pathview <-
          renderImage({
            get_GSEA_pathway_image(geneList, input$GSEA_KEGG_selector, org)
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
      get_SEA_KEGG(geneList, org)
    })
    
    output$KEGG_SEA_table <- renderDataTable({
      get_KEGG_SEA_table(KEGG_SEA())
    }, escape = F)
    
    output$KEGG_SEA_upsetplot <- renderPlot({
      get_KEGG_SEA_upsetplot(KEGG_SEA())
    })
    
    output$KEGG_SEA_barplot <- renderPlot({
      get_KEGG_SEA_barplot(KEGG_SEA())
    })
    
    output$KEGG_SEA_dotplot <- renderPlot({
      get_KEGG_SEA_dotplot(KEGG_SEA())
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
            get_GSEA_pathway_image(geneList, input$SEA_KEGG_selector, org)
          }, deleteFile = TRUE)
      }
    })
    
    
    
    
  }
