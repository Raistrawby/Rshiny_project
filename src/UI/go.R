goUI <- function() {
  fluidPage(sidebarLayout(
    sidebarPanel(),
    mainPanel(dataTableOutput("goContent"))
  ))
}

####
get_genelist<-function(data,organism,id_source,OrgDb){
  conv<- bitr(data$X,
              fromType=id_source,
              toType= "ENTREZID",
              OrgDb=OrgDb)
  mergedData<-merge(data,conv,by.x=c("X"),
                    by.y=c("SYMBOL"))
  mergedData<- mergedData[order(mergedData$log2FoldChange,decreasing=T),]
  geneList = mergeData$log2FoldChange
  names(geneList) = mergedData$ENTREZID
  return(geneList)
}
ggo <- groupGO(gene     = gene,
               OrgDb    = org.Hs.eg.db,
               ont      = "CC",
               level    = 3,
               readable = TRUE)

head(ggo)

ego3 <- gseGO(geneList     = geneList,
              OrgDb        = org.Hs.eg.db,
              ont          = "CC",
              nPerm        = 1000,
              minGSSize    = 100,
              maxGSSize    = 500,
              pvalueCutoff = 0.05,
              verbose      = FALSE)

data=read.csv("./data/donnee2.csv")
head(data)
geneList =get_genelist(data,"dme","SYMBOL","org.Dm.eg.db")

