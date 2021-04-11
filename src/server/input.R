library(clusterProfiler)

"%contain%" <- function(values, x) {
  tx <- table(x)
  tv <- table(values)
  z <- tv[names(tx)] - tx
  all(z >= 0 & !is.na(z))
}

readFile <- function(input, exemple, id_source, OrgDb) {
  file <- input
  if (exemple == TRUE) {
    data <- read.csv("data/donnee2.csv", header = TRUE)
  } else {
    ext <- tools::file_ext(input$datapath)
    validate(need(ext == "csv", "Please upload a csv file"))
    data <- read.csv(file$datapath, header = TRUE)
  }
  # Check header
  validate(
    need(
      colnames(data) %contain% c("X", "baseMean", "log2FoldChange", "padj"),
      "Error: Dataset should contains columns 'X', 'baseMean', 'log2FoldChange' and 'padj'"
    )
  )

  conv <- bitr(data$X,
               fromType = id_source,
               toType = "ENTREZID",
               OrgDb = OrgDb)
  
  data <- merge(data, conv, by.x = c("X"),
                      by.y = c("SYMBOL"))
  
  data <- data[c("X", "ENTREZID", "baseMean", "log2FoldChange", "padj")]
  data <- na.omit(data)
  return(data[order(data$padj), ])
}

get_geneList <- function(data) {
  data <-
    data[order(data$log2FoldChange, decreasing = T), ]
  
  geneList = data$log2FoldChange
  names(geneList) = data$ENTREZID
  
  return(geneList)
}