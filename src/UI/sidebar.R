sidebar <- function(pvalue, method_test, rest=NULL) {
  # Add rest to row if exists
  if (!is.null(rest)) {
    rest =
      column(
        width = 4,
        rest
      )
  }
  
  box(fluidRow(
    column(
      4,
      shinyWidgets::sliderTextInput(
        pvalue,
        "Choose an adjusted p-value threshold:",
        choices = c(0.00001, 0.0001, 0.001, 0.01, 0.05, 0.1, 0.5, 1),
        selected = 0.05,
        grid = T
      )
    ),
    column(
      4,
      selectInput(
        method_test,
        label = "Méthode d'ajustement de la p-valeur",
        choices = list(
          "FDR" = "fdr",
          "Bonferroni" = "bonferroni",
          "holm" = "holm",
          "hochberg" = "hochberg",
          "hommel" = "hommel",
          "BH" = "BH",
          "BY" = "BY",
          "Aucune" = "none"
        ),
        selected = "fdr"
      )
    ),
    rest
  ), 
  collapsible = TRUE,
  width = 12)
}