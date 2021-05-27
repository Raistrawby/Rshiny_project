source("./src/server/pathway/GSEA.R")
source("./src/server/GSEA_SEA.R")
source("./src/server/go/GO.R")

library(enrichplot)

go <- function(input,
           output,
           session,
           go_gse,
           go_sea) {
    # GSEA
    output$goContent1 <- renderPlot({
      get_GSEA_dotplot(go_gse(), title = "Dotplot - GO GSEA analysis", input$go_gsea_pvalue)
    })
    output$goContent2 <- renderPlot({
      get_GSEA_ridgeplot(go_gse(), title = "Ridgeplot - GO GSEA analysis", input$go_gsea_pvalue)
    })
    output$goContent3 <- renderPlot({
      get_GSEA_gseaplot(go_gse(), title = "GSEAplot - GO GSEA analysis", input$go_gsea_pvalue)
    })
    output$goContent10 <- renderPlot({
      display_goplot(go_gse(), title = "Goplot - GO GSEA analysis", input$go_sea_pvalue)
    })
    
    output$go_SEA_table <- renderDataTable({
      render_result_table(
        go_gse(),
        "http://amigo.geneontology.org/amigo/term/",
        "gsea",
        input$go_gsea_pvalue
      )
    }, escape = F)
    #ce que j'ai rajouté
    output$downloadData3 <- downloadHandler(
      filename = function() {
        paste("GSEA_go", ".csv", sep = "")
      },
      content = function(file) {
        write.csv(go_gse(), file, row.names = TRUE)
      }
    )
    
    # SEA
    output$goContent4 <- renderPlot({
      get_SEA_dotplot(go_sea(), "Dotplot - GO SEA analysis", input$go_sea_pvalue)
    })
    
    output$goContent5 <- renderPlot({
      get_SEA_barplot(go_sea(), title = "Barplot - GO SEA analysis", input$go_sea_pvalue)
    })
    
    output$goContent6 <- renderPlot({
      get_SEA_upsetplot(go_sea(), title = "Upsetplot - GO SEA analysis", input$go_sea_pvalue)
    })
    
    output$goContent7 <- renderPlot({
      display_goplot(go_sea(), title = "Goplot - GO SEA analysis", input$go_sea_pvalue)
    })
    
    output$go_GSEA_table <- renderDataTable({
      render_result_table(
        go_sea(),
        "http://amigo.geneontology.org/amigo/term/",
        "sea",
        input$go_sea_pvalue
      )
    }, escape = F)
    #ce que j'ai rajouté
    output$downloadData4 <- downloadHandler(
      filename = function() {
        paste("SEA_go", ".csv", sep = "")
      },
      content = function(file) {
        write.csv(go_sea(), file, row.names = TRUE)
      }
    )
  }
