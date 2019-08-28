library(dplyr)

# Inlezen data
portcalls_BE <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_BE.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_BG <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_BG.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_CA <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_CA.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_CY <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_CY.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_DE <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_DE.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_DK <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_DK.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_EE <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_EE.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_ES15 <- read.csv2("Bronnen/Report_PortCalls__2015_v2_ES.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_ES16 <- read.csv2("Bronnen/Report_PortCalls__2016_v2_ES.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_ES17 <- read.csv2("Bronnen/Report_PortCalls__2017_v2_ES.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_ES18 <- read.csv2("Bronnen/Report_PortCalls__2018_v2_ES.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_FI <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_FI.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_FR <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_FR.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_GB15 <- read.csv2("Bronnen/Report_PortCalls__2015_v2_GB.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_GB16 <- read.csv2("Bronnen/Report_PortCalls__2016_v2_GB.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_GB17 <- read.csv2("Bronnen/Report_PortCalls__2017_v2_GB.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_GB18 <- read.csv2("Bronnen/Report_PortCalls__2018_v2_GB.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_GR15 <- read.csv2("Bronnen/Report_PortCalls__2015_v2_GR.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_GR16 <- read.csv2("Bronnen/Report_PortCalls__2016_v2_GR.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_GR17 <- read.csv2("Bronnen/Report_PortCalls__2017_v2_GR.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_GR18 <- read.csv2("Bronnen/Report_PortCalls__2018_v2_GR.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_HR <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_HR.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_IE <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_IE.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_IS <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_IS.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_IT15 <- read.csv2("Bronnen/Report_PortCalls__2015_v2_IT.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_IT16 <- read.csv2("Bronnen/Report_PortCalls__2016_v2_IT.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_IT17 <- read.csv2("Bronnen/Report_PortCalls__2017_v2_IT.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_IT18 <- read.csv2("Bronnen/Report_PortCalls__2018_v2_IT.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_LT <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_LT.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_LV <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_LV.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_ME <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_ME.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_MT <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_MT.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_NL <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_NL.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_NO <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_NO.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_PL <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_PL.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_PT <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_PT.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_RO <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_RO.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_RU <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_RU.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_SE <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_SE.csv", sep = ",", stringsAsFactors=FALSE)
portcalls_SI <- read.csv2("Bronnen/Report_PortCalls_2015tm2018_v2_SI.csv", sep = ",", stringsAsFactors=FALSE)

# Specifieke aanpassingen kolomtypen om bestanden koppelbaar te maken
portcalls_BG   <- portcalls_BG   %>% mutate(Port.Call.ID = as.numeric(Port.Call.ID))
portcalls_ES15 <- portcalls_ES15 %>% mutate(Port.Call.ID = as.numeric(Port.Call.ID))
portcalls_BE <- portcalls_BE %>% mutate(IMO.Number = as.character(IMO.Number))
portcalls_BG <- portcalls_BG %>% mutate(IMO.Number = as.character(IMO.Number))
portcalls_CY <- portcalls_CY %>% mutate(IMO.Number = as.character(IMO.Number))
portcalls_IE <- portcalls_IE %>% mutate(IMO.Number = as.character(IMO.Number))
portcalls_IS <- portcalls_IS %>% mutate(IMO.Number = as.character(IMO.Number))
portcalls_ME <- portcalls_ME %>% mutate(IMO.Number = as.character(IMO.Number))
portcalls_PT <- portcalls_PT %>% mutate(IMO.Number = as.character(IMO.Number))
portcalls_RO <- portcalls_RO %>% mutate(IMO.Number = as.character(IMO.Number))
portcalls_SI <- portcalls_SI %>% mutate(IMO.Number = as.character(IMO.Number))
portcalls_SI <- portcalls_SI %>% mutate(External.System.ID = as.character(External.System.ID))

# Alle ingelezen data samenvoegen tot een bestand
portcalls <-
  bind_rows(
    portcalls_BE,
    portcalls_BG,
    portcalls_CA,
    portcalls_CY,
    portcalls_DE,
    portcalls_DK,
    portcalls_EE,
    portcalls_ES15,
    portcalls_ES16,
    portcalls_ES17,
    portcalls_ES18,
    portcalls_FI,
    portcalls_FR,
    portcalls_GB15,
    portcalls_GB16,
    portcalls_GB17,
    portcalls_GB18,
    portcalls_GR15,
    portcalls_GR16,
    portcalls_GR17,
    portcalls_GR18,
    portcalls_HR,
    portcalls_IE,
    portcalls_IS,
    portcalls_IT15,
    portcalls_IT16,
    portcalls_IT17,
    portcalls_IT18,
    portcalls_LT,
    portcalls_LV,
    portcalls_ME,
    portcalls_MT,
    portcalls_NL,
    portcalls_NO,
    portcalls_PL,
    portcalls_PT,
    portcalls_RO,
    portcalls_RU,
    portcalls_SE,
    portcalls_SI
    )

# Nu samengestelde dataset gemaakt is, de originelen verwijderen
rm(portcalls_BE,
   portcalls_BG,
   portcalls_CA,
   portcalls_CY,
   portcalls_DE,
   portcalls_DK,
   portcalls_EE,
   portcalls_ES15,
   portcalls_ES16,
   portcalls_ES17,
   portcalls_ES18,
   portcalls_FI,
   portcalls_FR,
   portcalls_GB15,
   portcalls_GB16,
   portcalls_GB17,
   portcalls_GB18,
   portcalls_GR15,
   portcalls_GR16,
   portcalls_GR17,
   portcalls_GR18,
   portcalls_HR,
   portcalls_IE,
   portcalls_IS,
   portcalls_IT15,
   portcalls_IT16,
   portcalls_IT17,
   portcalls_IT18,
   portcalls_LT,
   portcalls_LV,
   portcalls_ME,
   portcalls_MT,
   portcalls_NL,
   portcalls_NO,
   portcalls_PL,
   portcalls_PT,
   portcalls_RO,
   portcalls_RU,
   portcalls_SE,
   portcalls_SI)

# Wegschrijven databestand met ruwe data (voor opschoning)
save(portcalls, file="Data/1_reading_cleaning/Portcalls_EU_1518_ruw.Rda")
