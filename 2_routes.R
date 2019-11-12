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


ui <- fluidPage(
  
  titlePanel("Op zoek naar zeezwaaiers"),
  
  fluidRow(
    
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
    
    column(4, offset = 1,
           
           fluidRow(leafletOutput("AIS_map"))
    )
  )
)

server <- function(input, output, session) {
  
  points <- reactive({
    AIS_selectie %>% filter(t_updatetime == input$t_updatetime)
  })
  
  output$AIS_map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addCircleMarkers(lng= c(2,4), lat=c(51.5,54), radius=1, stroke = F, fill = F)
      
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

