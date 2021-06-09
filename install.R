#!/usr/bin/env Rscript

install_all_Db <- function(){
  Db_bio <- c("clusterProfiler", "pathview", "biomaRt")
  Db_other <- c("shiny", "shinyWidgets", "ggridges", "ggupset", "plotly", "tidyverse", "enrichplot", "shinydashboard")
  
  for( i in Db_bio ){
    if( ! require( i , character.only = TRUE ) ){
      BiocManager::install(i, ask = FALSE)
      require( i , character.only = TRUE )
      library(i, character.only = TRUE)
    }
  }
  for( j in Db_other ){
    if( ! require( j , character.only = TRUE ) ){
      install.packages( j , dependencies = TRUE )
      require( j , character.only = TRUE )
      library(j, character.only = TRUE)
    }
  }
}


install_all_Db()