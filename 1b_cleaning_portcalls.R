library(dplyr)
library(lubridate)

# Ruwe bestand inladen
load("Data/1_reading_cleaning/Portcalls_EU_1518_ruw.Rda")

# Frequentietabellen van alle kolommen
if (FALSE) {
  kolommen <- names(portcalls)
  
  for (i in 1:length(kolommen)){
    
    if (i < 10) {
      j = paste0('00', i)
    }
    else if (i < 100) {
      j = paste0('0', i)
    }
    else {
      j = i
    }
    
    tabel <- table(portcalls[,i])
    
    assign(paste0("Tabel_", j), data.frame(tabel))
    
  }}

# NA's tellen (inclusief lege character-velden)
if (FALSE) {
  NA_count <- sapply(portcalls, function(y) sum(length(which(is.na(y) | y==""))))
  View(NA_count)
}

# Verwijderen van overbodig geachte kolommen
portcalls <-
  portcalls %>%
  select(-ATA.Is.Null,
         -ATD.Is.Null)

# Maak numerieke variabelen waar niet mee gerekend kan worden character
portcalls <- portcalls %>% mutate(Port.Call.ID = as.character(Port.Call.ID),
                                  X.ATA..Ship.Type.Code = as.character(X.ATA..Ship.Type.Code))

# Ontdubbelen op identieke regels (0,14% van het totale aantal regels)
portcalls <- unique(portcalls)

# Verwijder portcalls zonder verzenddatum en/of ETA (handjevol portcalls zonder ATA verdwijnt daarmee automatisch)
portcalls <- portcalls %>% filter(Sent.At != "") %>% filter(ETA_LT != "")

# Datum/tijdvelden aanmaken
portcalls <- portcalls %>% mutate(Sent.At = ISOdatetime(substr(Sent.At,7,10),
                                                        substr(Sent.At,4,5),
                                                        substr(Sent.At,1,2),
                                                        substr(Sent.At,12,13),
                                                        substr(Sent.At,15,16),
                                                        substr(Sent.At,18,19)))
portcalls <- portcalls %>% mutate(ETA_LT = ISOdatetime(substr(ETA_LT,7,10),
                                                       substr(ETA_LT,4,5),
                                                       substr(ETA_LT,1,2),
                                                       substr(ETA_LT,12,13),
                                                       substr(ETA_LT,15,16),
                                                       substr(ETA_LT,18,19)))
portcalls <- portcalls %>% mutate(ATA_LT = ISOdatetime(substr(ATA_LT,7,10),
                                                       substr(ATA_LT,4,5),
                                                       substr(ATA_LT,1,2),
                                                       substr(ATA_LT,12,13),
                                                       substr(ATA_LT,15,16),
                                                       substr(ATA_LT,18,19)))
portcalls <- portcalls %>% mutate(ETD_LT = ISOdatetime(substr(ETD_LT,7,10),
                                                       substr(ETD_LT,4,5),
                                                       substr(ETD_LT,1,2),
                                                       substr(ETD_LT,12,13),
                                                       substr(ETD_LT,15,16),
                                                       substr(ETD_LT,18,19)))
portcalls <- portcalls %>% mutate(ATD_LT = ISOdatetime(substr(ATD_LT,7,10),
                                                       substr(ATD_LT,4,5),
                                                       substr(ATD_LT,1,2),
                                                       substr(ATD_LT,12,13),
                                                       substr(ATD_LT,15,16),
                                                       substr(ATD_LT,18,19)))

# Verwijder 'onmogelijke' portcalls:
# - verzenddatum (Send.At) moet eerder zijn dan vertrektijd (ATD) (verzenddatum kan wel na ATA liggen)
# - aankomst (ATA) moet eerder zijn dan vertrek (ATD) (tenzij vertrek nog niet heeft plaatsgevonden)
# - verwijder portcalls waarbij de ATA buiten de jaren 2015 t/m 2018 valt
# - verwijder portcalls waarbij de ATD later is dan de eerstvolgende ATA
portcalls <- portcalls %>% filter(Sent.At < ATD_LT,
                                  (ATA_LT < ATD_LT) | is.na(ATD_LT),
                                  year(ATA_LT) %in% c(2015:2018)) %>%
                           arrange(IMO.Number, ATA_LT) %>%
                           filter(!((IMO.Number == lead(IMO.Number)) & (ATD_LT > lead(ATA_LT))))

# Wegschrijven opgeschoond databestand
save(portcalls, file="Data/1_reading_cleaning/Portcalls_EU_1518_schoon.Rda")
