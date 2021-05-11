library(ggplot2)

##################
## Préparation des données pour l'enrichissement
##################
get_Gene_and_Bg_ratio = function(GeneList, GeneRef) {
  m = table(GeneRef$interpro)
  n = length(unique(GeneRef$interpro)) - m
  
  n = length(unique(GeneRef$entrezgene_id)) - m
  
  experience = merge(GeneList, GeneRef, by.x = "Gene", by.y = "entrezgene_id")
  x = table(factor(experience$interpro, rownames(m)))
  k = length(unique(GeneList$Gene))
  
  Term = unique(GeneRef$interpro)
  x = as.numeric(x)
  m = as.numeric(m)
  k = as.numeric(k)
  n = as.numeric(n)
  
  return(list(
    Term = Term,
    x = x,
    k = k,
    m = m,
    n = n
  ))
}

#######################
## Test hypergeometrique
#######################
hypergeom_test = function(x, k, m, n) {
  pvalue = phyper(x - 1, m, n, k, lower.tail = FALSE)
  padj = p.adjust(pvalue, n = length((pvalue)), method = "fdr")
  
  return (list(pvalue = pvalue, padj = padj))
}


########################################
## Creattion de la ltable des résultats
########################################
create_table_enrichment = function(GeneList, GeneRef) {
  ## Appel de la fct get_Gene_and_Bg_ratio() pour obtenir le BgRatio et le GeneRatio
  Gene.Bg.ratio = get_Gene_and_Bg_ratio(GeneList = GeneList, GeneRef = GeneRef)
  Bg.ratio = sprintf("%d/%d", Gene.Bg.ratio$m, Gene.Bg.ratio$m + Gene.Bg.ratio$n)
  Gene.ratio = sprintf("%d/%d", Gene.Bg.ratio$x, Gene.Bg.ratio$k)
  
  ## Appel de la fct hypergeom_test pour obtenir la pval et la padj
  test = hypergeom_test(
    x = Gene.Bg.ratio$x,
    k = Gene.Bg.ratio$k,
    m = Gene.Bg.ratio$m,
    n = Gene.Bg.ratio$n
  )
  
  ## création du data.frame
  table.enrich = data.frame(
    Term = Gene.Bg.ratio$Term,
    GeneRatio = Gene.ratio,
    BgRatio = Bg.ratio,
    pvalue = test$pvalue,
    padj = test$padj,
    count = Gene.Bg.ratio$x
  )
  
  return (table.enrich[order(table.enrich$pvalue), ])
  
}

load_data_for_biomaRt <- function() {
  library(org.Hs.eg.db)
  library(clusterProfiler)
  data = read.csv(
    "data/GSE118431_e_cig_exposure_Pantanedione_100_ppm_vs_control_without_extreme_Log2FC.csv"
  )
  conv = bitr(data$X,
              fromType = "SYMBOL",
              toType = "ENTREZID",
              OrgDb = org.Hs.eg.db)
  data = merge(data, conv, by.x = c("X"), by.y = c("SYMBOL"))
  data <- na.omit(data)
  return(data)
}

get_interpro_corr <- function(data, specie) {
  ensembl = useEnsembl(biomart = "ensembl")
  dataset = searchDatasets(mart = ensembl, pattern = specie)
  ensembl <-
    useEnsembl(biomart = "genes", dataset = dataset$dataset)
  
  BM_DB <-
    getBM(
      attributes = c('entrezgene_id', 'interpro', 'interpro_description'),
      mart = ensembl,
      filters = "entrezgene_id",
      values = data$ENTREZID,
      uniqueRows = TRUE
    )
  BM_DB = BM_DB[BM_DB$interpro != "", ]
  
  return(BM_DB)
}

get_SEA_INTERPRO <- function(data, specie) {
  data = data$all
  GeneList = rownames(data[which(data$padj <= 0.05),])
  GeneList = data.frame(Gene = GeneList)
  
  # Create table ENTREZIZ <=> InterproID
  GeneRef = get_interpro_corr(data, specie)
  
  # Run SEA analysis
  ORA = create_table_enrichment(GeneList = GeneList, GeneRef = GeneRef)
  full_ORA = distinct(merge(ORA, GeneRef[, c("interpro_description", "interpro")], by.x = "Term", by.y = "interpro"))
  
  return(full_ORA)
}

get_INTERPRO_SEA_barplot <- function(data, nb) {
  data = head(data[order(data$pvalue), ], nb)
  # data$interpro_description = factor(data$interpro_description, levels = data$interpro_description[order(data$pvalue)])
  print(data)
  ggplot(data,
         aes(
           x = interpro_description,
           y = count,
           fill = pvalue,
           order = pvalue
         )) +
    geom_bar(stat = "identity") +
    coord_flip() +
    scale_fill_gradient(low = "blue", high = "red") +
    theme_bw()
}

get_INTERPRO_SEA_barplot <- function(data, nb) {
  data = head(data[order(data$pvalue), ], nb)
  # data$interpro_description = factor(data$interpro_description, levels = data$interpro_description[order(data$pvalue)])
  ggplot(data,
         aes(
           x = interpro_description,
           y = count,
           fill = pvalue,
           order = pvalue
         )) +
    geom_bar(stat = "identity") +
    coord_flip() +
    scale_fill_gradient(low = "blue", high = "red") +
    theme_bw()
}

get_INTERPRO_SEA_dotplot <- function(data, nb) {
  data = head(data[order(data$pvalue), ], nb)
  # data$interpro_description = factor(data$interpro_description, levels = data$interpro_description[order(data$pvalue)])
  print(data)
  ggplot (mtcars,
          aes (x = interpro_description, y = gene_ratio, fill = pvalue)) +
    geom_point (stat = 'identity ', size = 6) +
    scale_color_manual (
      name = "Mileage ",
      labels = c ("Above of average ", " Below average "),
      values = c (" above " = " # 00ba38 ", " below " = " # f8766d ")
    ) + geom_text (color = "white ", size = 2) +
    labs (title = "Diverging Dot Plot ",
          subtitle = "Normalized mileage of 'mtcars ': Dotplot ") +
    ylim (-2.5, 2.5) +
    coord_flip ()
}