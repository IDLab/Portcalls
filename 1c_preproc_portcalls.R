library(dplyr)

# Inladen data
load("Data/1_reading_cleaning/Portcalls_EU_1518_schoon.Rda")

# Bepaal vorige haven en vorig land waar het schip geweest is
portcalls <-
  portcalls %>%
  arrange(IMO.Number, ATA_LT) %>%
  mutate(Previous_port =
           if_else(IMO.Number == lag(IMO.Number),
                   lag(Port.Name),
                   "..."),
         Previous_country =
           if_else(IMO.Number == lag(IMO.Number),
                   lag(Country.Code),
                   "..."))
portcalls$Previous_port[portcalls$Previous_port == "..."] <- NA
portcalls$Previous_country[portcalls$Previous_country == "..."] <- NA

# Label voor portcalls waarbij volgende haven dezelfde is als de vorige haven
portcalls <-
  portcalls %>%
  arrange(IMO.Number, ATA_LT) %>%
  mutate(Return_to_same_port =
           if_else(IMO.Number == lag(IMO.Number),
                   if_else(Port.Location.Name == lag(Port.Location.Name),
                           "1",
                           "0"),
                   "..."))
portcalls$Return_to_same_port[portcalls$Return_to_same_port == "..."] <- NA

# Bereken tijd tussen opeenvolgende portcalls
portcalls <-
  portcalls %>%
  arrange(IMO.Number, Sent.At) %>%
  mutate(Time_lag_Sent_h =
           if_else(IMO.Number == lag(IMO.Number),
                   round((as.numeric(Sent.At) - as.numeric(lag(Sent.At))) / 3600),
                   as.numeric(NA)),
         Time_lag_Sent_d = round(Time_lag_Sent_h / 24))

# Bereken tijd tussen opeenvolgende arrivals
portcalls <-
  portcalls %>%
  arrange(IMO.Number, ATA_LT) %>%
  mutate(Time_lag_ATA_h =
           if_else(IMO.Number == lag(IMO.Number),
                   round((as.numeric(ATA_LT) - as.numeric(lag(ATA_LT))) / 3600),
                   as.numeric(NA)),
         Time_lag_ATA_d = round(Time_lag_ATA_h / 24))

# Bereken tijdsverschil departure vorige haven --> arrival volgende haven (hoe lang is het schip onderweg geweest?)
portcalls <-
  portcalls %>%
  arrange(IMO.Number, ATA_LT) %>%
  mutate(Time_travel_h =
           if_else(IMO.Number == lag(IMO.Number),
                   round((as.numeric(ATA_LT) - as.numeric(lag(ATD_LT))) / 3600),
                   as.numeric(NA)),
         Time_travel_d = round(Time_travel_h / 24))

# Bereken tijdsverschil arrival --> departure (hoe lang lag het schip in de haven?)  
portcalls <-
  portcalls %>%
  mutate(Time_in_port_h = round((as.numeric(ATD_LT) - as.numeric(ATA_LT)) / 3600),
         Time_in_port_d = round(Time_in_port_h / 24))

# Wegschrijven pre-processed databestand
save(portcalls, file="Data/1_reading_cleaning/Portcalls_EU_1518_preproc.Rda")
