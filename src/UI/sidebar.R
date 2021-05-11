sidebar <- function(pvalue, method_test, rest=NULL) {
  list(
    h3("Input:"),
    shinyWidgets::sliderTextInput(
      pvalue,
      "Choose an adjusted p-value threshold:",
      choices = c(0.00001, 0.0001, 0.001, 0.01, 0.05, 0.1, 0.5, 1),
      selected = 0.05,
      grid = T
    ),
    
    hr(style = "border-top: 1px solid #cccccc;"),
    
    h3("Volcano Plot:"),
    sliderInput(
      method_test,
      label = "Threshold for Log2FoldChange:",
      min = 0,
      max = 5,
      value = 0.75,
      step = 0.05
    ),
    rest,
    width = 3
  )
}