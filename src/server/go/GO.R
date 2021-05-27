source("./src/server/GSEA_SEA.R")

library(clusterProfiler)
library(enrichplot)
library(ggplot2)
library(ggupset)

# OrgDb ##############################################################
org_to_db <- function(organism) {
  organisms <-
    c(
      "aga",
      "ath",
      "bta",
      "cel",
      "cfa",
      "dme",
      "dre",
      "eco",
      "ecs",
      "gga",
      "hsa",
      "mmu",
      "mcc",
      "mxa",
      "pfa",
      "ptr",
      "rno",
      "sce",
      "ssc",
      "xla"
    )
  orgdbs <-
    c(
      "org.Ag.eg.db",
      "org.At.tair.db",
      " org.Bt.eg.db",
      "org.Ce.eg.db",
      "org.Cf.eg.db",
      "org.Dm.eg.db",
      "org.Dr.eg.db",
      "org.EcK12.eg.db",
      "org.EcSakai.eg.db",
      "org.Gg.eg.db",
      "org.Hs.eg.db",
      "org.Mm.eg.db",
      " org.Mmu.eg.db",
      "org.Mxanthus.db",
      "org.Pf.plasmo.db",
      "org.Pt.eg.db",
      " org.Rn.eg.db",
      "org.Sc.sgd.db",
      "org.Ss.eg.db",
      "org.Xl.eg.db"
    )
  org <- grep(organism, organisms)
  db <- orgdbs[org]
  return(db)
}

install_orgDb <- function(OrgDb) {
  if (!requireNamespace(OrgDb, quietly = TRUE)) {
    #install.packages(OrgDb)
    BiocManager::install(OrgDb)
    library(OrgDb, character.only = TRUE)
  }
  else{
    library(OrgDb, character.only = TRUE)
  }
}

# GSEA ###############################################################
gse_analysis <- function(data, method, ontology_gse, OrgDb){
  gse <- gseGO(geneList=data$GSEA, 
               ont = ontology_gse, 
               keyType = "ENTREZID", 
               pvalueCutoff = 1,
               OrgDb = OrgDb,
               pAdjustMethod=method)
  return(gse)
}

# SEA ################################################################
sea_analysis <- function(data, method, ontology_sea, OrgDb){
  go_enrich <- enrichGO(gene = names(data$SEA),
                        OrgDb = OrgDb, 
                        keyType = "ENTREZID",
                        ont = ontology_sea,
                        pvalueCutoff = 1, 
                        qvalueCutoff = 1,
                        pAdjustMethod=method)
  return(go_enrich)
}

# PLOT ###############################################################
display_goplot <- function(result_object, title, padj) {
  result_object = filter_by_padj(result_object, padj)
  validate(
    need(nrow(result_object@result) > 0, "No Data to show")
  )
  goplot(result_object, showCategory = 10, title=title)
}
