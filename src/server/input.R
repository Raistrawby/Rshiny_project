"%contain%" <- function(values, x) {
  tx <- table(x)
  tv <- table(values)
  z <- tv[names(tx)] - tx
  all(z >= 0 & !is.na(z))
}

readFile <- function(input, header) {
  file <- input
  if (is.null(file)) {
    data = read.csv("data/res_DE2.csv", header = header)
  } else {
    ext <- tools::file_ext(input$datapath)
    validate(need(ext == "csv", "Please upload a csv file"))
    data = read.csv(file$datapath, header = input$header)
  }
  # Check header
  validate(
    need(
      colnames(data) %contain% c("X", "baseMean", "log2FoldChange", "padj"),
      "Error: Dataset should contains columns 'X', 'baseMean', 'log2FoldChange' and 'padj'"
    )
  )
  data = data[c("X", "baseMean", "log2FoldChange", "padj")]
}