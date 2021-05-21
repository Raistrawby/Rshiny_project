source("./src/server/pathway/GSEA.R")
source("./src/server/GSEA_SEA.R")
library(enrichplot)

go <- function(input,
           output,
           session,
           geneList) {
    # GSEA
    go_gse <- reactive({
      go_gse <- gse_analysis(geneList(), input$id, input$ontology)
    })
    
    output$goContent1 <- renderPlot({
      get_GSEA_dotplot(go_gse(), title = "go dotplot")
    })
    output$goContent2 <- renderPlot({
      get_GSEA_ridgeplot(go_gse(), title = "go ridgeplot")
    })
    output$goContent3 <- renderPlot({
      get_GSEA_gseaplot(go_gse(), title = "go gseaplot")
    })
    
    output$go_SEA_table <- renderDataTable({
      render_result_table(go_gse(),
                          "http://amigo.geneontology.org/amigo/term/",
                          "gsea")
    }, escape = F)
    
    # SEA
    go_sea <- reactive({
      go_sea <- sea_analysis(geneList(), input$id, input$ontology)
    })
    
    output$goContent4 <- renderPlot({
      get_SEA_dotplot(go_sea(), "go sea gotplot")
    })
    
    output$goContent5 <- renderPlot({
      get_SEA_barplot(go_sea(), title = "go sea barplot")
    })
    
    output$goContent6 <- renderPlot({
      get_SEA_upsetplot(go_sea(), title = "go sea upsetplot")
    })
    
    output$goContent7 <- renderPlot({
      display_goplot(go_sea(), title = "go sea goplot")
    })
    
    output$go_GSEA_table <- renderDataTable({
      render_result_table(go_sea(),
                          "http://amigo.geneontology.org/amigo/term/",
                          "sea")
    }, escape = F)
  }