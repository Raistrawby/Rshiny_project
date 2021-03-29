goUI <- function() {
  fluidPage(sidebarLayout(
    sidebarPanel(),
    mainPanel(dataTableOutput("goContent"))
  ))
}

####

d <- read.csv("data/res_DE2.csv")

###



library(clusterProfiler)
d <- read.csv(your_csv_file)
## assume that 1st column is ID
## 2nd column is fold change

## feature 1: numeric vector
geneList <- d[,2]

## feature 2: named vector
names(geneList) <- as.character(d[,1])

## feature 3: decreasing order
geneList <- sort(geneList, decreasing = TRUE)

data(geneList, package="DOSE")
gene <- names(geneList)[abs(geneList) > 2]
gene.df <- bitr(gene, fromType = "ENTREZID",
                toType = c("ENSEMBL", "SYMBOL"),
                OrgDb = org.Hs.eg.db)
head(gene.df)

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


#### test emma

data <- read.csv("data/res_DE2.csv")
organism =hsa
id_source="SYMBOL"
OrgDb=org.Hs.eg
conv<-bitr(data$X,
           fromType = id_source,
           toType="ENTREZID",
           OrgDb=OrgDb)
mergedData<- merge(data,conv, by.xn=c("X"),
                   by.y=c("SYMBOL"))
mergedData<- 
  mergedData[order(mergedData$log2FoldChange,decreasing=T),]
geneList=mergedData$log2FoldChange
names(geneList)=mergedData$ENTREZID

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


