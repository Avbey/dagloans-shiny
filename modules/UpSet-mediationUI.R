UpSetMediationUI <- function(id) {
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