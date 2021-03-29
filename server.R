source("./src/server/WDI.R")
source("./src/server/input.R")
source("./src/server/KEGG.R")

library(shiny)
library(org.Hs.eg.db)

shinyServer(function(input, output, session) {
    # Input tab ############################
    geneExpression <-
        reactive({
            readFile(input$input, input$exemple)
        })
    output$contents <- renderDataTable({
        geneExpression()
    })
    
    # WDI tab ##############################
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
        updateSliderInput(session, "slider1", max = log2Max)
    })
    output$value <- renderPrint({
        input$slider1
    })
    output$filteredDataTable <-
        renderDataTable({
            subset(geneExpression(), padj < input$pvalue)
        })
    # GO tab ################################
    
    
    # KEGG tab ##############################
    output$KEGG_Selector <- renderPrint({
        input$KEGG_Selector
    })
    # GSEA
    observe({
        geneList = get_genelist(geneExpression(), "hsa", "SYMBOL", org.Hs.eg.db)
        kegg = get_KEGG_GSEA(geneList, 'hsa', pvalueCutoff = input$pvalue)
        output$KEGG_GSEA_table <- renderDataTable({
            get_KEGG_table(kegg)
        }, escape = F)
        output$KEGG_GSEA_dotplot <- renderPlot({
            get_KEGG_dotplot(kegg, 10)
        })
        output$KEGG_GSEA_ridgeplot <- renderPlot({
            get_KEGG_ridgeplot(kegg, 10)
        })
        output$KEGG_GSEA_pathview <-
            renderImage({
                get_pathway_image(geneList, "hsa04621", 'hsa')
            }, deleteFile = TRUE)
    })
    
    
})