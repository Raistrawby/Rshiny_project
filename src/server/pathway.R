source("./src/server/pathway/GSEA.R")
source("./src/server/pathway/SEA.R")

library(enrichplot)

pathway <- function(input, output, data, org) {
  ############################# GSEA
  withProgress(message = "KEGG GSEA in progress", value = 0, {
    geneList = get_GSEA_genelist(data, "hsa", "SYMBOL", org)
    
    incProgress(1 / 3, detail = "Get KEGG GSEA results...")
    
    kegg_GSEA = get_KEGG_GSEA(geneList, 'hsa', pvalueCutoff = input$pvalue)
    
    incProgress(2 / 3, detail = "Render result...")
    
    output$KEGG_GSEA_table <- renderDataTable({
      get_KEGG_GSEA_table(kegg_GSEA)
    }, escape = F)
    
    output$KEGG_GSEA_dotplot <- renderPlot({
      get_KEGG_GSEA_dotplot(kegg_GSEA, 10)
    })
    
    output$KEGG_GSEA_ridgeplot <- renderPlot({
      get_KEGG_GSEA_ridgeplot(kegg_GSEA, 10)
    })
    
    output$KEGG_GSEA_gseaplot <- renderPlot({
      get_KEGG_GSEA_gseaPlot(kegg_GSEA)
    })
    
    incProgress(3 / 3, detail = "Render Pathview")
    output$KEGG_GSEA_pathview <-
      renderImage({
        get_GSEA_pathway_image(geneList, "hsa04621", 'hsa')
      }, deleteFile = TRUE)
  })
  
  ############################## SEA
  withProgress(message = "KEGG SEA in progress", value = 0, {
    geneListSEA = get_SEA_genelist(data, "hsa", "SYMBOL", org, 0.05)
    
    incProgress(1 / 3, detail = "Get KEGG SEA results...")
    kegg_SEA = get_SEA_KEGG(geneListSEA, 'hsa')
    
    incProgress(2 / 3, detail = "Render result...")
    output$KEGG_SEA_table <- renderDataTable({
      get_KEGG_SEA_table(kegg)
    }, escape = F)
    
    output$KEGG_SEA_upsetplot <- renderPlot({
      get_KEGG_SEA_upsetplot(kegg_SEA)
    })
    
    output$KEGG_SEA_barplot <- renderPlot({
      get_KEGG_SEA_barplot(kegg_SEA)
    })
    
    output$KEGG_SEA_dotplot <- renderPlot({
      get_KEGG_SEA_dotplot(kegg_SEA)
    })
  })
}