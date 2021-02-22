library(ggplot2)

volcanoPlot <- function(data, logFilter, pvalueFilter) {
  data$diffexpdatased <- "NO"
  data$diffexpdatased[data$log2FoldChange > logFilter &
                        data$padj < pvalueFilter] <- "UP"
  data$diffexpdatased[data$log2FoldChange < -logFilter &
                        data$padj < pvalueFilter] <- "DOWN"
  
  ggplot(data, aes(
    x = log2FoldChange,
    y = -log10(padj),
    col = diffexpdatased
  )) +
    geom_point() +
    scale_color_manual(values = c("blue", "black", "red")) +
    geom_vline(xintercept = c(-logFilter, logFilter),
               col = "red") +
    geom_hline(yintercept = -log10(pvalueFilter), col = "red") +
    labs(
      colour = "Differencial expression",
      title = "Volcano plot",
      x = "log2(Fold Change)",
      y = "-log10(FDR)"
    ) +
    theme(plot.title = element_text(face = "bold"))
}

MAPlot <- function(data, pvalueFilter) {
  data$diffexpdatased <- "NO"
  data$diffexpdatased[data$padj < pvalueFilter] <- "YES"
  
  ggplot(data,
         aes(x = baseMean,
             y = log2FoldChange,
             col = diffexpdatased)) +
    geom_point() +
    scale_x_log10() +
    scale_color_manual(
      values = c("black", "darkgreen"),
      labels = c('Not significant', 'Significant')
    ) +
    labs(
      title = "MA plot",
      colour = "Significance",
      x = "Mean expression (log)",
      y = "log2(Fold Change)"
    ) +
    theme(plot.title = element_text(face = "bold"))
}