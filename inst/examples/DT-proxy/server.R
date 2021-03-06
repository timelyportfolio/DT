library(shiny)
library(DT)

shinyServer(function(input, output, session) {

  # using server = FALSE mainly for addRow(); server = TRUE works for
  # selectRows() and selectColumns()
  output$foo = DT::renderDataTable(
    iris, server = FALSE, selection = list(target = 'row+column')
  )

  proxy = dataTableProxy('foo')

  observeEvent(input$select1, {
    selectRows(proxy, as.numeric(input$rows))
  })

  observeEvent(input$select2, {
    selectColumns(proxy, input$col)
  })

  observeEvent(input$clear1, {
    selectRows(proxy, NULL)
  })

  observeEvent(input$clear2, {
    selectColumns(proxy, NULL)
  })

  observeEvent(input$add, {
    addRow(proxy, iris[sample(nrow(iris), 1), , drop = FALSE])
  })

  output$info = renderPrint({
    list(rows = input$foo_rows_selected, columns = input$foo_columns_selected)
  })

})
