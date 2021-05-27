source("./src/server/WDI.R")
source("./src/server/input.R")
source("./src/server/pathway.R")
source("./src/server/protein_domain.R")
source("./src/server/GO.R")
source("./src/server/manhattan.R")

library(shiny)
library(plotly)

shinyServer(function(input, output, session) {
    
    # Organisme DB #########################
    OrgDb <-
        reactive({
            org <- org_to_db(input$espece)            
            install_orgDb(org)
            return(eval(parse(text = org)))
        })
    
    # Input tab ############################
    geneExpression <-
        reactive({
            readFile(input$input, input$exemple, input$id, OrgDb())
        })

    geneList <- reactive({
        geneList <- get_geneList(geneExpression(), input$logFCFilter)
    })

    output$contents <- renderDataTable({
        geneExpression()
    })

    # WDI tab ##############################
    output$volcanoPlot <-
        renderPlotly({
            volcanoPlot(geneExpression(), input$logFCFilter, input$pvalue)
        })

    output$MAPlot <-
        renderPlotly({
            MAPlot(geneExpression(), input$logFCFilter, input$pvalue)
        })

    observe({
        # Rounded to 0 or 0.5
        log2Max <-
            ceiling(max(geneExpression()$log2FoldChange) * 2) / 2
        updateSliderInput(session, "slider1", max = log2Max)
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
        go_gse <- gse_analysis(geneList(), input$go_gsea_method, input$ontology_gse, OrgDb())
    })
    go_sea <- reactive({
        go_sea <- sea_analysis(geneList(), input$go_sea_method, input$ontology_sea, OrgDb())
    })
    go(input, output, session, go_gse, go_sea)

    # Pathway tab ###########################
    KEGG_GSEA <- reactive({
        get_KEGG_GSEA(geneList()$GSEA, input$espece, input$pathway_gsea_method)
    })
    KEGG_SEA <- reactive({
        get_SEA_KEGG(geneList()$SEA, input$espece, input$pathway_sea_method)
    })
    pathway(
        input,
        output,
        session,
        KEGG_GSEA,
        KEGG_SEA,
        geneList
    )

    # Protein domains #######################
    interpro_db <- reactive({
        get_interpro_db(names(geneList()$GSEA), input$espece)
    })
    interpro_gsea <- reactive({
        get_interpro_gsea(geneList()$GSEA, interpro_db(), input$protein_gsea_method)
    })
    interpro_sea <- reactive({
        get_interpro_sea(names(geneList()$SEA), interpro_db(), input$protein_sea_method)
    })
    protein(
        input,
        output,
        session,
        interpro_gsea,
        interpro_sea
    )

    # Manhattan #############################
    output$manhattan <- renderPlot({
        getManatthanPlot(go_gse(), go_sea(), KEGG_GSEA(), KEGG_SEA(), interpro_gsea(), interpro_sea())
    })
})