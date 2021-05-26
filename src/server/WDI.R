library(ggplot2)

volcanoPlot <- function(data, logFilter, pvalueFilter) {
  data$diffexpdatased <- "NO"
  data$diffexpdatased[data$log2FoldChange > logFilter &
                        data$padj < pvalueFilter] <- "UP"
  data$diffexpdatased[data$log2FoldChange < -logFilter &
                        data$padj < pvalueFilter] <- "DOWN"
  
  v <- ggplot(data, aes(
    x = log2FoldChange,
    y = -log10(padj),
    col = diffexpdatased
  )) +
    geom_point() +
    scale_color_manual(values = c("blue", "black", "goldenrod")) +
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
  v_plot <- ggplotly(v)
  return(v_plot)
}

#data = read.csv("~/Bureau/M21/RShiny_project/Rshiny_project/data/GSE118431_e_cig_exposure_Pantanedione_100_ppm_vs_control_without_extreme_Log2FC.csv")
#volcanoPlot(data, 1, 0.05)

MAPlot <- function(data, logFilter, pvalueFilter) {
  data$diffexpdatased <- "NO"
  data$diffexpdatased[data$log2FoldChange > logFilter &
                        data$padj < pvalueFilter] <- "UP"
  data$diffexpdatased[data$log2FoldChange < -logFilter &
                        data$padj < pvalueFilter] <- "DOWN"
  
  ma <- ggplot(data,
         aes(x = baseMean,
             y = log2FoldChange,
             col = diffexpdatased)) +
    geom_point() +
    scale_x_log10() +
    scale_color_manual(
      values = c("blue", "black", "goldenrod")
    ) +
    labs(
      title = "MA plot",
      colour = "Significance",
      x = "Mean expression (log)",
      y = "log2(Fold Change)"
    ) +
    theme(plot.title = element_text(face = "bold"))
  ma_plot <- ggplotly(ma)
  return(ma_plot)
}
