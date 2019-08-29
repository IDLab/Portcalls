library(shiny)
library(dplyr)
library(leaflet)

load("Data/1_reading_cleaning/AIS_selectie.Rda")

# Selecteer IMO-nummer om de route van te bekijken; de bovenste IMO-nrs zijn de 'mooiste' routes
AIS_selectie <-
  AIS_selectie %>%
  filter(t_imo == 9216470
                  #9395367
                  #9404364
                  #9753674
                  #9114244
                  #9402677
                  #9518804
                  #9400356
                  #9439151
                  #8920581
                  #9122112
  )
         
ui <- fluidPage(
  sliderInput(inputId = "t_updatetime", label = "Time",
              min = min(AIS_selectie$t_updatetime), 
              max = max(AIS_selectie$t_updatetime),
              value = min(AIS_selectie$t_updatetime),
              step=3600,
              animate = T),
  leafletOutput("AIS_map")
)

server <- function(input, output, session) {
  points <- reactive({
    AIS_selectie %>% filter(t_updatetime == input$t_updatetime)
  })
  
  history <- reactive({
    AIS_selectie %>% filter(t_updatetime <= input$t_updatetime)
  })
  
  output$AIS_map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addCircleMarkers(lng = ~t_longitude,
                       lat = ~t_latitude,
                       data = points(),
                       radius = 3) %>%
      addCircleMarkers(lng = ~t_longitude,
                       lat = ~t_latitude,
                       data = history(),
                       radius = 3,
                       label = ~t_updatetime)
  })
}

shinyApp(ui, server)

