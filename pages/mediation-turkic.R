mediationTurkicUI <- function(id) {
  ns <- NS(id)
  
  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        id = "upset_plot",
        type = "tabs",
        tabPanel(
          "Settings",
          htmlOutput(ns("sets")),
          numericInput(
            ns("nintersections"),
            label = "Number of intersections to show",
            value = 30,
            min = 1,
            max = 60
          ),
          
          selectInput(
            ns("order"),
            label = "Order intersections by",
            choices = list("Degree" = "degree",
                           "Frequency" = "freq"),
            selected = "freq"
          ),
          selectInput(
            ns("decreasing"),
            label = "Increasing/Decreasing",
            choices = list("Increasing" = "inc",
                           "Decreasing" = "dec"),
            selected = "dec"
          ),
          
          selectInput(
            ns("scale.intersections"),
            label = "Scale intersections",
            choices = list(
              "Original" = "identity",
              "Log10" = "log10",
              "Log2" = "log2"
            ),
            selected = "identity"
          ),
          
          selectInput(
            ns("scale.sets"),
            label = "Scale sets",
            choices = list(
              "Original" = "identity",
              "Log10" = "log10",
              "Log2" = "log2"
            ),
            selected = "identity"
          ),
          
          
          sliderInput(
            ns("upset_width"),
            label = "Plot width",
            value = 650,
            min = 400,
            max = 1200,
            ticks = FALSE,
            step = 10
          ),
          
          sliderInput(
            ns("upset_height"),
            label = "Plot height",
            value = 400,
            min = 300,
            max = 1000,
            ticks = FALSE,
            step = 10
          ),
          
          sliderInput(
            ns("mbratio"),
            label = "Bar matrix ratio",
            value = 0.30,
            min = 0.20,
            max = 0.80,
            ticks = FALSE,
            step = 0.01
          ),
          
          checkboxInput(ns('show_numbers'), label = "Show numbers on bars", value = TRUE),
          
          sliderInput(
            ns("angle"),
            label = "Angle of number on the bar",
            min = -90,
            max = 90,
            value = 0,
            step = 1,
            ticks = F
          ),
          
          checkboxInput(ns('empty'), label = "Show empty intersections", value = FALSE),
          checkboxInput(ns('keep.order'), label = "Keep set order", value = FALSE),
          
          numericInput(
            ns("pointsize"),
            label = "Connecting point size",
            value = 2.5,
            min = 1,
            max = 10
          ),
          
          numericInput(
            ns("linesize"),
            label = "Connecting line size",
            value = 0.8,
            min = 0.5,
            max = 10
          )
        ),
        tabPanel(
          "Font & Colors",
          colourInput(ns("mbcolor"), "Select main bar colour", "#ea5d4e"),
          colourInput(ns("sbcolor"), "Select set bar colour", "#317eab"),
          
          numericInput(
            ns("intersection_title_scale"),
            label = "Font size of intersection size label",
            value = 1.8,
            min = 0.5,
            max = 100
          ),
          numericInput(
            ns("set_title_scale"),
            label = "Set size label font",
            value = 1.8,
            min = 0.5,
            max = 100
          ),
          numericInput(
            ns("intersection_ticks_scale"),
            label = "Intersection size ticks font",
            value = 1.2,
            min = 0.5,
            max = 100
          ),
          numericInput(
            ns("set_ticks_scale"),
            label = "Set Size ticks font",
            value = 1.5,
            min = 0.5,
            max = 100
          ),
          numericInput(
            ns("intersection_size_numbers_scale"),
            label = "Intersection Size Numbers font size",
            value = 1.2,
            min = 0.5,
            max = 100
          ),
          numericInput(
            ns("names_scale"),
            label = "Set Names font size",
            value = 1.5,
            min = 0.5,
            max = 100
          )
        ),
        tabPanel(
          HTML("<i class='fas fa-file-download'></i>"),
          radioButtons(
            inputId = ns("filetype"),
            label = "Choose file type to download:",
            inline = TRUE,
            choices = list("PDF", "PNG", "SVG", "TIFF")
          ),
          
          downloadButton(outputId = ns("download"), label = "Download Plot")
        )
      )
    ),
    mainPanel(
      id = "upsetplottab",
      plotOutput(ns('plot'))
    ))
}


mediationTurkic <- function(input, output, session) {
  
  all_turkic_wide <- spread(all_turkic, Lexeme, Present)
  all_turkic_wide <- ddply(all_turkic_wide,"Village",numcolwise(sum)) # sum all rows by Village
  all_turkic_wide[is.na(all_turkic_wide)] <- 0 
  all_turkic_wide[,-1] <- ifelse(all_turkic_wide[,-1] > 0, 1, 0) # normalize DF
  villages <- all_turkic_wide$Village # transpose DF to satisfy UpsetR
  all_turkic_wide <- as.data.frame(t(all_turkic_wide[,-1]))
  colnames(all_turkic_wide) <- villages
  
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
    startEnd <- FindStartEnd(all_turkic_wide)
  })
  
  output$sets <- renderUI({
    ns <- session$ns
    data <- all_turkic_wide[startEnd()[1]:startEnd()[2]]
    top <- colSums(data)
    top <- as.character(head(names(top[order(top, decreasing = T)]), 7))
    sets <- selectInput(ns('upset_sets'), label="Select villages (at least two) ",
                        choices = as.character(colnames(all_turkic_wide[ , startEnd()[1]:startEnd()[2]])),
                        multiple=TRUE, selectize=TRUE, selected = top)
    return(sets)
  })
  
  Specific_sets <- reactive({
    Specific_sets <- as.character(c(input$upset_sets))
  })
  
  output$plot <- renderPlot({ 
    upset(all_turkic_wide, 
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
      
      upset(all_turkic_wide,
            nintersects = input$nintersections,
            point.size = input$pointsize,
            line.size = line_size(),
            sets = colnames(all_turkic_wide),
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