# Import libraries
library(shinythemes)
library(shinyjs)

# Import script about panel
tabPanelAbout=source("About.R")$value

# UI
navbarPage(title=HTML('<span style="font-size:120%;color:white;font-weight:bold;">Multiscale socio-ecological interactions&nbsp;&nbsp;</span></a>'),
           #strong("Multi-scale socio-ecological interactions"), 
           theme = shinytheme("cerulean"),
           windowTitle = "AHIA",
           header = "",

  ##### Network #####################################################################################
  tabPanel(strong("Network"),
    div(class="outer",     
      
      # Include custom CSS & logo   
      tags$head(
        includeCSS("styles.css"),
        tags$link(rel = "icon", type = "image/png", href = "images/Logo.jpg")
      ),
      
      # Map
      leafletOutput("mapnet", width = "100%", height = "100%"),
      
      # Panel              
      absolutePanel(id = "control1", class = "panel panel-default", fixed = TRUE,
                    draggable = TRUE, top = 80, left = "auto", right = 20, bottom = "auto",
                    width = 330, height = "auto",
                    
                    h2("Network explorer"),
                    
                    selectInput("CSnet",
                                label=strong("Case study"),
                                choices=list("All" = 0,
                                             "Barcelona" = 1,
                                             "Cairngorms" = 2,
                                             "Carpathians" = 3,
                                             "Costa Vicentina" = 4,
                                             "Danube" = 5,
                                             "De Cirkel" = 6,
                                             "Dovre" = 7,
                                             "French Alps" = 8,
                                             "Kainuu" = 9,
                                             "Kiskunsag" = 10,
                                             "Loch Leven" = 11,
                                             "Sierra Nevada" = 12,
                                             "Stubai valley" = 13,
                                             "Trnava" = 14,
                                             "Vinschgau" = 15,
                                             "Warwickshire" = 16),
                                selected=0),
                    
                    numericInput(inputId="W", 
                                 label=strong("Minimal number of interactions"), 
                                 value=1, 
                                 min = 1, 
                                 max = 100000, 
                                 step = 1),
                    
                    # Reset & default buttons
                    actionButton("reset_button_net", "Reset view"),
                    actionButton("default_values_net", "Default values"),
                    tags$style(type='text/css', "#reset_button_net {width:130px;float:left;}"),
                    tags$style(type='text/css', "#default_values_net {width:130px;float:right;}")
                   
                    
      ),
      
      # SK8 footer
      div(
        class="footer",
        includeHTML("footer.html")
      )
      
  )),
  
  ##### Spatial distribution ##########################################################################
  tabPanel(strong("Spatial distribution"),
    div(class="outer",     
      
      # Include custom CSS  
      tags$head(
        includeCSS("styles.css")
      ),
      
      # Map
      leafletOutput("mapsp", width = "100%", height = "100%"),
      
      # Panel
      absolutePanel(id = "control1", class = "panel panel-default", fixed = TRUE,
                    draggable = TRUE, top = 80, left = "auto", right = 20, bottom = "auto",
                    width = 330, height = 680,
                    
                    h2("Spatial distribution"),
                    
                    selectInput("CSsp",
                                label=strong("Case study"),
                                choices=list("Barcelona" = 1,
                                             "Cairngorms" = 2,
                                             "Carpathians" = 3,
                                             "Costa Vicentina" = 4,
                                             "Danube" = 5,
                                             "De Cirkel" = 6,
                                             "Dovre" = 7,
                                             "French Alps" = 8,
                                             "Kainuu" = 9,
                                             "Kiskunsag" = 10,
                                             "Loch Leven" = 11,
                                             "Sierra Nevada" = 12,
                                             "Stubai valley" = 13,
                                             "Trnava" = 14,
                                             "Vinschgau" = 15,
                                             "Warwickshire" = 16),
                                selected=1),
                    
                    selectInput("l", 
                                 label=strong("Cell size"), 
                                 choices=list("250 m" = 1,
                                              "500 m" = 2,
                                              "1000 m" = 3,
                                              "2000 m" = 4,
                                              "3000 m" = 5,
                                              "4000 m" = 6,
                                              "5000 m" = 7),
    
                                 selected=4),

                    selectInput("typesp", 
                                label=strong("Users"), 
                                choices=list("All" = 1,
                                             "Locals" = 2,
                                             "Visitors" = 3,
                                             "Locals/All" = 4),
                                
                                selected=1),
                    
                    # Histogram
                    plotOutput("hist", height = 200),
                    
                    # Reset & default buttons
                    div(" ", style="height:20px;"),
                    
                    actionButton("reset_button_sp", "Reset view"),
                    actionButton("default_values_sp", "Default values"),
                    tags$style(type='text/css', "#reset_button_sp {width:130px;float:left;}"),
                    tags$style(type='text/css', "#default_values_sp {width:130px;float:right;}"),
                    
                    # Heatmap
                    div(" ", style="height:40px;"),
                    checkboxInput("heatmap", "Display heatmap",value=FALSE),
                    
                    # 3D
                    div(" ", style="height:20px;"),
                    useShinyjs(),
                    actionButton("tdexplorer", "3D EXPLORER"),
                    tags$style(type='text/css', "#tdexplorer {width:285px;text-align:center;}")
                    
      ),
      
      div(
        class="footer",
        includeHTML("footer.html")
      )
      
  )),

  
  
  ##### Temporal distribution ##########################################################################
  tabPanel(strong("Temporal distribution"),
           
           # Plot
           plotOutput("plotemp",width="1100px",height = "484px"),
           tags$style(type="text/css",
                      "#plotemp img{display:block;margin-top:5%;margin-bottom:auto;margin-left:5%;margin-right:auto;}"),
           
           # Panel
           absolutePanel(id = "control2", class = "panel panel-default", fixed = TRUE,
                         draggable = FALSE, top = 80, left = "auto", right = 20, bottom = "auto",
                         width = 360, height = "auto",
                         
                         h2("Temporal distribution"),
                         
                         selectInput("CStemp",
                                     label=strong("Case study"),
                                     choices=list("All" =0,
                                                  "Barcelona" = 1,
                                                  "Cairngorms" = 2,
                                                  "Carpathians" = 3,
                                                  "Costa Vicentina" = 4,
                                                  "Danube" = 5,
                                                  "De Cirkel" = 6,
                                                  "Dovre" = 7,
                                                  "French Alps" = 8,
                                                  "Kainuu" = 9,
                                                  "Kiskunsag" = 10,
                                                  "Loch Leven" = 11,
                                                  "Sierra Nevada" = 12,
                                                  "Stubai valley" = 13,
                                                  "Trnava" = 14,
                                                  "Vinschgau" = 15,
                                                  "Warwickshire" = 16),
                                     selected=0),
                         
                         selectInput("dt", 
                                     label=strong("Temporal scale"), 
                                     choices=list("Hour" = 1,
                                                  "Month" = 2),
                                     
                                     selected=2),
                         
                         selectInput("typetemp", 
                                     label=strong("Users"), 
                                     choices=list("All" = 1,
                                                  "Locals/Visitors" = 2),
                                     selected=1)

                         
           ),
           
           div(
             class="footer",
             includeHTML("footer.html")
           )         
           
  ),
  
  ##### Interactions ######################################################################################
  tabPanel(strong("Interactions"),

           # Plot
           plotOutput("plotint",width="1100px",height = "484px"),
           tags$style(type="text/css",
                      "#plotint img{display:block;margin-top:5%;margin-bottom:auto;margin-left:5%;margin-right:auto;}"),

           # Panel
           absolutePanel(id = "control2", class = "panel panel-default", fixed = TRUE,
                         draggable = FALSE, top = 80, left = "auto", right = 20, bottom = "auto",
                         width = 345, height = "auto",

                         h2("Type of interactions"),

                         selectInput("CSint",
                                     label=strong("Case study"),
                                     choices=list("Barcelona" = 1,
                                                  "Cairngorms" = 2,
                                                  "Carpathians" = 3,
                                                  "Costa Vicentina" = 4,
                                                  "Danube" = 5,
                                                  "De Cirkel" = 6,
                                                  "Dovre" = 7,
                                                  "French Alps" = 8,
                                                  "Kainuu" = 9,
                                                  "Kiskunsag" = 10,
                                                  "Loch Leven" = 11,
                                                  "Sierra Nevada" = 12,
                                                  "Stubai valley" = 13,
                                                  "Trnava" = 14,
                                                  "Vinschgau" = 15,
                                                  "Warwickshire" = 16),
                                     selected=1),

                         selectInput("Catint",
                                     label=strong("CES category"),
                                     choices=list("Land Use / Land Cover" = 1,
                                                  "Recreational" = 2),
                                     selected=1)


           ),
           
           div(
             class="footer",
             includeHTML("footer.html")
           )

  ),
  
  ##### About ####################################################################################
  tabPanelAbout()
  
)


