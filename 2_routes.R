library(shiny)
library(dplyr)
library(leaflet)

load("Data/1_reading_cleaning/AIS_selectie.Rda")

# Selecteer IMO-nummer om de route van te bekijken
AIS_selectie <-
  AIS_selectie %>%
  filter(t_imo %in% c(9114244,    # Zeezwaaien
                      9216470,    # Zeezwaaien
                      9034731,    # Zeezwaaien           
                      9402677,    # Zeezwaaien
                      9553048,    # Zeezwaaien
                      9122112,    # Zeezwaaien
                      9400356,    # Zeezwaaien
                      9518804,    # Zeezwaaien
                      8920581     # Zeezwaaien
                     #9283978
                     #9395367
                     #9753674
                     #9439151
                     #9246918
                     #9594834
                     #9301873
                     #9308900         
                     #9259991
  )
  )

min_lon = min(AIS_selectie$t_longitude)
max_lon = max(AIS_selectie$t_longitude)
min_lat = min(AIS_selectie$t_latitude)
max_lat = max(AIS_selectie$t_latitude)

ui <- fluidPage(
  
  titlePanel("Zeezwaaien"),
  
  fluidRow(
    
    column(4, offset = 1,
           
           fluidRow(selectInput("ship",
                                "Kies een schip:",
                                choices = sort(unique(AIS_selectie$ship))))
    ),
    
    column(4, offset = 1,
           
           sliderInput(inputId = "t_updatetime", label = "Datum en tijd",
                       min = min(AIS_selectie$t_updatetime), 
                       max = max(AIS_selectie$t_updatetime),
                       value = min(AIS_selectie$t_updatetime),
                       step=60,
                       animate = animationOptions(interval = 1))
    )
    
  ),
  
  fluidRow(
    
    column(12,
           
           fluidRow(leafletOutput("AIS_map"))
    )
  )
)

server <- function(input, output, session) {

  output$AIS_map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addCircleMarkers(lng=min_lon, lat=min_lat, radius=1, stroke = F, fill = F) %>%
      addCircleMarkers(lng=max_lon, lat=max_lat, radius=1, stroke = F, fill = F)
  })
    
  observeEvent(input$ship, {
    leafletProxy("AIS_map") %>%
      clearMarkers()
  })
  
  observe({
    sel <- AIS_selectie %>% filter(ship == input$ship)
    val <- min(sel$t_updatetime)
    min_val <- min(sel$t_updatetime)
    max_val <- max(sel$t_updatetime)
    updateSliderInput(session, "t_updatetime", value = val, min = min_val, max = max_val)
  })
  
  points <- reactive({
    AIS_selectie %>%
      filter(t_updatetime == input$t_updatetime,
             ship == input$ship)
  })
  
  observeEvent(input$t_updatetime, {
    leafletProxy("AIS_map") %>%
      addCircleMarkers(lng = ~t_longitude,
                       lat = ~t_latitude,
                       data = points(),
                       radius = 1)
  })
  
}

shinyApp(ui, server)

