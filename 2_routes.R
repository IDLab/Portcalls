library(shiny)
library(dplyr)
library(leaflet)

load("Data/1_reading_cleaning/AIS_selectie.Rda")

ui <- fluidPage(
  sliderInput(inputId = "t_updatetime", label = "Time",
              min = min(AIS_selectie$t_updatetime), 
              max = max(AIS_selectie$t_updatetime),
              value = min(AIS_selectie$t_updatetime),
              step=3600,
              animate = T),
  selectInput(inputId = "t_imo",
              "Kies een IMO-nummer:",
              choices = sort(unique(AIS_selectie$t_imo))),
  leafletOutput("AIS_map")
)


server <- function(input, output, session) {
  points <- reactive({
    AIS_selectie %>% filter(t_updatetime == input$t_updatetime) %>% filter(t_imo == input$t_imo)
  })
  
  history <- reactive({
    AIS_selectie %>% filter(t_updatetime <= input$t_updatetime) #%>% filter(t_imo == input$t_imo)
  })
  
  output$AIS_map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(lng = ~t_longitude,
                 lat = ~t_latitude,
                 data = points()) %>%
      addMarkers(lng = ~t_longitude,
                 lat = ~t_latitude,
                 data = history())
  })
}

shinyApp(ui, server)
