library(biomaRt)
source("./src/server/protein_domain/interpro.R")
source("./src/server/GSEA_SEA.R")

protein <-
  function(input,
           output,
           session,
           interpro_gsea,
           interpro_sea){
    ############################# INTERPRO
    # GSEA    
    output$interpro_GSEA_dotplot <- renderPlot({
      get_GSEA_dotplot(interpro_gsea(), "dotplot interpro", input$protein_gsea_pvalue)
    })
    
    output$interpro_GSEA_ridgeplot <- renderPlot({
      get_GSEA_ridgeplot(interpro_gsea(), title = "ridgeplot interpro", input$protein_gsea_pvalue)
    })
    
    output$interpro_GSEA_gseaplot <- renderPlot({
      get_GSEA_gseaplot(interpro_gsea(), title = "gseaplot interpro", input$protein_gsea_pvalue)
    })
    
    output$interpro_GSEA_table <- renderDataTable({
      render_result_table(interpro_gsea(),
                          "https://www.ebi.ac.uk/interpro/entry/InterPro/",
                          "gsea", input$protein_gsea_pvalue)
    }, escape = F)
    
    #ce que j'ai rajouté
    output$downloadData5 <-downloadHandler(
      filename= function(){
        paste("GSEA_domain",".csv",sep="")
      },
      content=function(file){
        write.csv(interpro_gsea(),file,row.names=TRUE)
      }
    )
    #fin de ce que j'ai add
    
    # SEA
    output$interpro_SEA_dotplot <- renderPlot({
      get_SEA_dotplot(interpro_sea(), "dotplot interpro", input$protein_sea_pvalue)
    })
    
    output$interpro_SEA_upsetplot <- renderPlot({
      get_SEA_upsetplot(interpro_sea(), title = "upsetplot interpro", input$protein_sea_pvalue)
    })
    
    output$interpro_SEA_barplot <- renderPlot({
      get_SEA_barplot(interpro_sea(), title = "barplot interpro", input$protein_sea_pvalue)
    })
    
    output$interpro_SEA_table <- renderDataTable({
      render_result_table(interpro_sea(),
                          "https://www.ebi.ac.uk/interpro/entry/InterPro/",
                          "sea", input$protein_sea_pvalue)
    }, escape = F)
    #ce que j'ai rajouté
    output$downloadData6 <-downloadHandler(
      filename= function(){
        paste("SEA_domain",".csv",sep="")
      },
      content=function(file){
        write.csv(interpro_sea(),file,row.names=TRUE)
      }
    )
  }
