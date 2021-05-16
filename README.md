# Rshiny_project
Master Rshiny project.
Development of a processing chain and a web application for the analysis of functional enrichment in RNA-Seq

## Installation 
### Requirements
- Clusterprofiler
- Pathview
- biomaRt
- shinyWidgets: `install.packages("shinyWidgets")`
- ggridges : `install.packages("ggridges")`
- ggupset: `install.packages("ggupset")`
- msigdbr `install.packages("msigdbr")`
- plotly `install.packages("plotly")`


## Usage
### Input :
A csv file including in order:
- The protein identifier (it can be in different formats such as "ENSEMBL", "ENTREZID", "SYMBOL", "UNIPROT"),
- a column named "baseMean"
- a column named "log2FoldChange"
- a column named "padj" containing the adjusted p-values
They will be convert in ENTREZID thanks to DESeq2 package

The application makes it possible to process different species, the databases implemented are those of:
- Anophele,
- Arabidopsis,
- Bovine,
- Worm,
- Canine,
- Fly,
- ZebraFish,
- EcoliK12,
- Ecoli Sakai,
- Chicken,
- Human,
- Mouse,
- Rhesus,
- Myxococcus Xanthus DK 1622,
- Malaria,
- Chimp,
- Rat,
- Yeast,
- Pig,
- Xenopus.

### Whole data inspection 
You are able to reduce your data before the functional analysis part.
You can put a threshold both in adjust pvalue and log2FoldChange. 
Moreover 2 interactives graph are available and a dowloadable table is present.

### GO term Enrichissment 
GSEA analysis and SEA analysis are avalaible.

GSEA :
pvalue is set to 0.05
Developped with gse_go() is an overreppresenation test and gene set enrichissment analysis.
This is based on differential expressed genes present in the dataset. GSEA doesn't take the log2FoldChange as an information. So gene with large difference are represented however small difference are only detected with SEA. IF a group of gene aggregate small difference, they will be set together. 
In this tab you will find 3 graph and a downloadable table.
The 3 graphes are :
- go dotplot
- go ridgeplot
- go gsea plot 
This graph are creat with goplot()

SEA :
pvalue and log2FoldChange are set to 0.05 and 0.1 
This function is code by enrichGo()
Whereas GSEA, the SEA (also called ORA) take in consideration both pvalue and log2foldchange. 

### Pathway enrichment
As before 2 tabs are avalaible for GSEA analysis and SEA analysis.


## Support 
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
If you have more question please contact us :
- mathias.lorthiois@univ-rouen.fr
- manea.meslin@univ-rouen.fr
- marie.lahaye@univ-rouen.fr
- emma.corre@univ-rouen.fr

## Roadmap
for the future

## Authors and acknowledgment
A big thanks for the developpement Team that had never give up during a pandemic (not append every day guys)

## Project status
It will not be maintain after june 2021 



http://yulab-smu.top/clusterProfiler-book/chapter12.html