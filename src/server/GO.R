library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)
library("pathview")
library(ggplot2)

get_genelist<-function(data, organism, id_source, OrgDb){
  conv<- bitr(data$X,
              fromType=id_source,
              toType= "ENTREZID",
              OrgDb=OrgDb)
  mergedData<-merge(data,conv,by.x=c("X"),
                    by.y=c("SYMBOL"))
  mergedData<- mergedData[order(mergedData$log2FoldChange,decreasing=T),]
  geneList = mergedData$log2FoldChange
  names(geneList) = mergedData$ENTREZID
  return(geneList)
}

gse_analysis<-function(data){
  gene_list =get_genelist(data, "dme", "SYMBOL", "org.Hs.eg.db")
  gse <- gseGO(geneList=gene_list, 
               ont ="CC", 
               keyType = "ENTREZID",
               minGSSize = 100, 
               maxGSSize = 500, 
               pvalueCutoff = 0.05, 
               verbose = FALSE, 
               OrgDb = org.Hs.eg.db, 
               pAdjustMethod = "none")
  return(gse)
}

display_dotplot<-function(gse){
  require(DOSE)
  dotplot(gse, showCategory=10, split=".sign") + facet_grid(.~.sign)
}

display_ridgeplot<-function(gse){
  ridgeplot(gse) + labs(x = "enrichment distribution")
}

display_gseplot<-function(gse){
  gseaplot(gse, by = "all", title = gse$Description[1], geneSetID = 1)
}
