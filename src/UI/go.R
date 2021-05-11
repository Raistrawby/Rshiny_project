goUI <- function() {
  fluidPage(sidebarLayout(sidebarPanel(width = 2),
                          mainPanel(tabsetPanel(
                            tabPanel(
                              "GSEA",
                              column(6,
                                     plotOutput("goContent1")),
                              column(6,
                                     plotOutput("goContent2")),
                              column(4,
                                     plotOutput("goContent3")),
                              column(8,
                                     dataTableOutput("go_GSEA_table")),
                            ),
                            tabPanel(
                              "SEA",
                              column(6,
                                     plotOutput("goContent4")),
                              column(6,
                                     plotOutput("goContent5")),
                              column(6,
                                     plotOutput("goContent6")),
                              column(6,
                                     plotOutput("goContent7")),
                              dataTableOutput("go_SEA_table")
                            )
                          ))))
}