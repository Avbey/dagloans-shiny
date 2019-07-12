LexicalMap <- function(input, output, session, data_) {
  
  output$concepts <- renderUI({
    ns <- session$ns
    concept <- selectizeInput(ns("lexmap_set"), 
                              label = 'Concept', 
                              choices = unique(data_$Concept),
                              selected = "the pepper")
    return(concept)
  })
  
  Selected_concept <- reactive({
    data.frame(data_[(data_$Concept == input$lexmap_set),])
  })
  
  colorpal <- reactive({ 
    colorFactor(
      palette = "magma", 
      levels = data_$Set)
  })
  
  output$map <- renderLeaflet({
    leaflet(data = Selected_concept(), options = leafletOptions(minZoom = 4, maxZoom = 18)) %>% 
      setView(46.833793, 42.240031, 7) %>%
      addTiles()
  })
  
  observe({
    if(nrow(Selected_concept())==0) { leafletProxy("map") %>% clearShapes()} 
    else {
      pal = colorpal()
      leafletProxy("map", data = Selected_concept()) %>%
      clearShapes() %>% 
      addCircleMarkers(~Lon, ~Lat, color = ~pal(Set), radius = 6, stroke = FALSE, 
                       popup = ~as.character(Word), label = ~as.character(Language))
    }
  })
  
  observe({
    if(nrow(Selected_concept())==0) { leafletProxy("map") %>% clearShapes()} 
    else {
      pal = colorpal()
      proxy <- leafletProxy("map", data = Selected_concept())
      proxy %>% clearControls()
      if (input$legend) {
        proxy %>% addLegend(
          position = "bottomleft", 
          pal = pal, 
          values = ~Set,
          title = "Sets",
          opacity = 0.99
          )
      }
    }
  })
}
