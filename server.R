source("./src/server/WDI.R")
source("./src/server/input.R")
source("./src/server/pathway.R")
source("./src/server/protein_domain.R")
source("./src/server/GO.R")

library(shiny)
library(org.Hs.eg.db)

shinyServer(function(input, output, session) {
    # Input tab ############################
    geneExpression <-
        reactive({
            readFile(input$input, input$exemple, input$id, org.Hs.eg.db)
        })

    geneList <- reactive({
        geneList <- get_geneList(geneExpression(), input$pvalue)
    })

    output$contents <- renderDataTable({
        geneExpression()
    })

    output$espece <- renderPrint({
        input$espece
    }) # espece
    output$id <- renderPrint({
        input$id
    }) # type ID

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
        log2Max <-
            ceiling(max(geneExpression()$log2FoldChange) * 2) / 2
        updateSliderInput(session, "slider1", max = log2Max)
    })

    output$value <- renderPrint({
        input$slider1
    })

    output$filteredDataTable <-
        renderDataTable({
            subset(geneExpression(), padj < input$pvalue)
        })

    output$downloadData <- downloadHandler(
        filename = function() {
            paste(input$pvalue, ".csv", sep = "")
        },
        content = function(file) {
            write.csv(subset(geneExpression(), padj < input$pvalue), file, row.names = TRUE)
        }
    )

    # GO tab ################################
    go_gse <- reactive({
        go_gse <- gse_analysis(geneList(), input$id)
    })
    go_sea <- reactive({
        go_sea <- sea_analysis(geneList(), input$id)
    })
    go(input, output, session, go_gse, go_sea)

    # Pathway tab ###########################
    KEGG_GSEA <- reactive({
        get_KEGG_GSEA(geneList()$GSEA, input$espece)
    })
    KEGG_SEA <- reactive({
        get_SEA_KEGG(geneList()$SEA, input$espece)
    })
    pathway(
        input,
        output,
        session,
        KEGG_GSEA,
        KEGG_SEA
    )

    # Protein domains #######################
    interpro_db <- reactive({
        get_interpro_db(names(geneList()$GSEA), input$espece)
    })
    interpro_gsea <- reactive({
        get_interpro_gsea(geneList()$GSEA, interpro_db())
    })
    interpro_sea <- reactive({
        get_interpro_sea(names(geneList()$SEA), interpro_db())
    })
    protein(
        input,
        output,
        session,
        interpro_gsea,
        interpro_sea
    )

    # Manhattan #############################
})