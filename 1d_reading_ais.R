library(dplyr)

# Data inladen
load("Data/1_reading_cleaning/Portcalls_EU_1518_preproc.Rda")

# Selecteren potentiële zeezwaaiers in Rotterdam, in mei 2017, en het tijdsinterval van de route Rotterdam --> Rotterdam berekenen
ships_rdam <-
  portcalls %>%
  filter(X.ATA..Ship.Type.Description %in%
           c("Chemical tanker", "Combination carrier", "MODU & FPSO", "NLS tanker", "Oil tanker"),
         Previous_port == "Rotterdam",
         Port.Name == "Rotterdam",
         year(ATA_LT) == 2017,
         month(ATA_LT) == 5,
         Time_travel_h < 48) %>%
  mutate(ATD_prev = ATA_LT - 3600 * Time_travel_h,
         t_imo = as.numeric(IMO.Number)) %>%
  select(t_imo, X.ATA..Ship.Type.Description, ATD_prev, ATA_LT)


# Inlezen AIS van geselecteerde schepen (zie Python-script)
AIS_selectie <- read.csv2("Data/1_reading_cleaning/AIS_selectie.csv", sep = ",", stringsAsFactors=FALSE)

# Lon/lat naar numeriek omzetten
AIS_selectie <- AIS_selectie %>% mutate(t_longitude = as.numeric(t_longitude), t_latitude = as.numeric(t_latitude))

# Tijdvariabele aanmaken
AIS_selectie <- AIS_selectie %>% mutate(t_updatetime = ISOdatetime(substr(t_updatetime,1,4),
                                                                   substr(t_updatetime,6,7),
                                                                   substr(t_updatetime,9,10),
                                                                   substr(t_updatetime,12,13),
                                                                   substr(t_updatetime,15,16),
                                                                   substr(t_updatetime,18,19)))

# Overbodige kolommen eruit en tijdsintervallen koppelen en selecteren
AIS_selectie <-
  AIS_selectie %>%
  left_join(ships_rdam, by=c("t_imo", "t_imo")) %>%
  filter(t_updatetime > ATD_prev - 3600,
         t_updatetime < ATA_LT + 3600) %>%
  select(t_imo, X.ATA..Ship.Type.Description, t_updatetime, t_longitude, t_latitude)

# Wegschrijven
save(AIS_selectie, file="Data/1_reading_cleaning/AIS_selectie.Rda")

