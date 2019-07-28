library(UpSetR)

UpSetMediation <- function(input, output, session, data) {
  mat_prop <- reactive({
    mat_prop <- input$mbratio
  })
  
  upset_width <- reactive({
    return(input$upset_width)
  })
  
  upset_height <- reactive({
    return(input$upset_height)
  })
  
  bar_prop <- reactive({
    bar_prop <- (1 - input$mbratio)
  })
  
  orderdat <- reactive({
    orderdat <- as.character(input$order)
    if(orderdat == "degree"){
      orderdat <- c("degree")
    }
    else if(orderdat == "freq"){
      orderdat <- "freq"
    }
    return(orderdat)
  })
  
  show_numbers <- reactive({
    show_numbers <- input$show_numbers
    if(show_numbers){
      show_numbers <- "yes"
      return(show_numbers)
    }
    else{
      show_numbers <- FALSE
      return(show_numbers)
    }
    
  })
  
  main_bar_color <- reactive({
    mbcolor <- input$mbcolor
    return(mbcolor)
  })
  
  sets_bar_color <- reactive({
    sbcolor <- input$sbcolor
    return(sbcolor)
  })
  
  decrease <- reactive({
    decrease <- as.character(input$decreasing)
    if(decrease == "inc"){
      decrease <- FALSE
    }
    else if(decrease == "dec"){
      decrease <- TRUE
    }
    return(decrease)
  })
  
  number_angle <- reactive({
    angle <- input$angle
    return(angle)
  })
  
  line_size <- reactive({
    line_size <- input$linesize
    return(line_size)
  })
  
  emptyIntersects <- reactive({
    if(isTRUE(input$empty)){choice <- "on"
    return(choice)
    }
    else{
      return(NULL)
    }
  })
  
  scale.intersections <- reactive({
    return(input$scale.intersections)
  })
  
  scale.sets <- reactive({
    return(input$scale.sets)
  })
  
  keep.order <- reactive({
    return(input$keep.order)
  })
  
  FindStartEnd <- function(data){
    startend <- c()
    for(i in 1:ncol(data)){
      column <- data[, i]
      column <- (levels(factor(column)))
      if((column[1] == "0") && (column[2] == "1" && (length(column) == 2))){
        startend[1] <- i
        break
      }
      else{
        next
      }
    }
    for(i in ncol(data):1){
      column <- data[ ,i]
      column <- (levels(factor(column)))
      if((column[1] == "0") && (column[2] == "1") && (length(column) == 2)){
        startend[2] <- i
        break
      }
      else{
        next
      }
    }
    return(startend)
  }
  
  startEnd <- reactive({
    startEnd <- FindStartEnd(data)
  })
  
  output$sets <- renderUI({
    ns <- session$ns
    data <- data[startEnd()[1]:startEnd()[2]]
    top <- colSums(data)
    top <- as.character(head(names(top[order(top, decreasing = T)]), 7))
    sets <- selectInput(ns('upset_sets'), label="Select at least two",
                        choices = as.character(colnames(data[ , startEnd()[1]:startEnd()[2]])),
                        multiple=TRUE, selectize=TRUE, selected = top)
    return(sets)
  })
  
  Specific_sets <- reactive({
    Specific_sets <- as.character(c(input$upset_sets))
  })
  
  output$plot <- renderPlot({ 
    upset(data, 
          sets = Specific_sets(), 
          nintersects = input$nintersections,
          point.size = input$pointsize,
          line.size = line_size(),
          order.by = orderdat(),
          main.bar.color= main_bar_color(),
          sets.bar.color= sets_bar_color(),
          decreasing = c(decrease()),
          show.numbers = show_numbers(),
          number.angles = number_angle(),
          scale.intersections = scale.intersections(),
          scale.sets = scale.sets(),
          keep.order = keep.order(),
          mb.ratio = c(as.double(bar_prop()), as.double(mat_prop())),
          empty.intersections = emptyIntersects(),
          text.scale = c(input$intersection_title_scale, input$intersection_ticks_scale,
                         input$set_title_scale, input$set_ticks_scale, input$names_scale,
                         input$intersection_size_numbers_scale))
  }, width = upset_width, height = upset_height)
  
  output$download <- downloadHandler(
    filename = function(){
      paste("DagLoans_db_plot", tolower(input$filetype), sep =".")
    },
    content = function(file){
      width <- upset_width()
      height <- upset_height()
      pixelratio <- 2
      
      if(input$filetype == "PNG")
        png(file, width=width*pixelratio, height=height*pixelratio,
            res=72*pixelratio, units = "px")
      else if(input$filetype == "SVG")
        svg(file, width = width/100, height = height/100)
      else if(input$filetype == "TIFF")
        tiff(file, width=width*pixelratio, height=height*pixelratio, units = "px")
      else
        pdf(file, width = width/100, height = height/100, onefile=FALSE)
      
      upset(data,
            nintersects = input$nintersections,
            point.size = input$pointsize,
            line.size = line_size(),
            sets = colnames(data),
            order.by = orderdat(),
            main.bar.color= main_bar_color(),
            sets.bar.color= sets_bar_color(),
            decreasing = c(decrease()),
            number.angles = number_angle(),
            show.numbers = show_numbers(),
            scale.intersections = scale.intersections(),
            scale.sets = scale.sets(),
            keep.order = keep.order(),
            mb.ratio = c(as.double(bar_prop()), as.double(mat_prop())),
            empty.intersections = emptyIntersects(),
            text.scale = c(input$intersection_title_scale, input$intersection_ticks_scale,
                           input$set_title_scale, input$set_ticks_scale, input$names_scale,
                           input$intersection_size_numbers_scale))
      
      dev.off()
    }
  )
}