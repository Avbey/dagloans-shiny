ViewDatabase <- function(input, output, session) {
  ns <- session$ns
  
  observe({
    villages <- if (is.null(input$districts)) character(0) else {
      filter(words_meta, District %in% input$districts) %>%
        `$`('Village') %>%
        unique() %>%
        sort()
    }
    stillSelected <- isolate(input$villages[input$villages %in% villages])
    updateSelectInput(session, "villages", choices = villages,
                      selected = stillSelected)
  })
  
  observe({
    languages <- if (is.null(input$districts)) character(0) else {
      words_meta %>%
        filter(District %in% input$districts,
               is.null(input$villages) | Village %in% input$villages) %>%
        `$`('Language') %>%
        unique() %>%
        sort()
    }
    stillSelected <- isolate(input$languages[input$languages %in% languages])
    updateSelectInput(session, "languages", choices = languages,
                      selected = stillSelected)
  })
  
  observe({
    families <- if (is.null(input$districts)) character(0) else {
      words_meta %>%
        filter(District %in% input$districts,
               (is.null(input$villages) | Village %in% input$villages) & (is.null(input$languages) | Language %in% input$languages)) %>%
        `$`('Family') %>%
        unique() %>%
        sort()
    }
    stillSelected <- isolate(input$families[input$families %in% families])
    updateSelectInput(session, "families", choices = families,
                      selected = stillSelected)
  })
  
  observe({
    groups <- if (is.null(input$districts)) character(0) else {
      words_meta %>%
        filter(District %in% input$districts,
               (is.null(input$villages) | Village %in% input$villages) & (is.null(input$languages) | Language %in% input$languages) & (is.null(input$families) | Family %in% input$families)) %>%
        `$`('Group') %>%
        unique() %>%
        sort()
    }
    stillSelected <- isolate(input$groups[input$groups %in% groups])
    updateSelectInput(session, "groups", choices = groups,
                      selected = stillSelected)
  })
  
  
  output$basictable <- DT::renderDataTable({
    df <- database
    DT::datatable(df, 
                  filter = 'top', 
                  extensions = 'Buttons',
                  options = list(
                    autoWidth = TRUE,
                    columnDefs = list(list(width = '50px', targets = c(1, 5))),
                    pageLength = 100,
                    dom = 'lBfrtip',
                    scrollX = TRUE,
                    buttons = c('copy', 'csv')),
                  escape = FALSE)
  })
  
  output$advancedtable <- DT::renderDataTable({
    df <- words_meta %>%
      filter(
        is.null(input$districts) | District %in% input$districts,
        is.null(input$villages) | Village %in% input$villages,
        is.null(input$languages) | Language %in% input$languages,
        is.null(input$families) | Family %in% input$families,
        is.null(input$groups) | Group %in% input$groups
      )
    df_result <- df[,which(colnames(df) %in% c("Code", "Word", "Concept"))] %>%
    ddply(.(Code, Concept), summarize, Wordc=paste(Word,collapse=", ")) %>%
    spread(Code, Wordc)
    
    DT::datatable(df_result, 
                  extensions = 'Buttons',
                  options = list(
                    lengthMenu = list(c(10, 50, -1), c('10', '50', 'All')),
                    searching = FALSE,
                    dom = 'lBfrtip',
                    scrollX = TRUE,
                    buttons = c('copy', 'csv')),
                  escape = FALSE)
  })
}
