library(tidyverse)
library(readxl)
library(tidyselect)

# define helper
cleaner <- function(x){
  select(x, AIRPORT, Year, INBOUND, OUTBOUND, INBOUND__1, OUTBOUND__1) %>% 
    filter(!is.na(AIRPORT)) %>%
    rename( 
    airport = AIRPORT,
    year = Year,
    dom_inbound     = INBOUND,
    dom_outbound    = OUTBOUND,
    int_inbound     = INBOUND__1,
    int_outbound    = OUTBOUND__1
    ) %>% 
    gather(type, count, -airport, -year) %>% 
    mutate(
      domest = grepl("dom_", type),
      type = gsub("dom_", "", type),
      type = gsub("int_", "", type)
    ) 
}

international_freight <-  function(){
  
  download.file("https://bitre.gov.au/publications/ongoing/files/WebAirport_CY_1985-2016.xls",
                mode = "wb",
                destfile = "temp.xls")

  international_freight_raw <- readxl::read_xls("temp.xls",
                                                sheet = 5,
                                                skip = 6
  )
  
  international_freight <- international_freight_raw
  colnames(international_freight) <- c("airport", "year",
                                       "int_freight_inbound", "int_freight_outbound",
                                       "int_freight_total",
                                       "int_mail_inbound", "int_mail_outbound",
                                       "int_mail_total")
  international_freight
  
}

airport_passengers <- function() {

  download.file("https://bitre.gov.au/publications/ongoing/files/WebAirport_CY_1985-2016.xls",
              mode = "wb",
              destfile = "temp.xls")


  airport_passengers_raw <- readxl::read_xls("temp.xls",
                                           sheet = 3,
                                           skip = 6
                                           )

  airport_passengers <- airport_passengers_raw %>% cleaner()
}

aircraft_movements <-  function() {

  download.file("https://bitre.gov.au/publications/ongoing/files/WebAirport_CY_1985-2016.xls",
              mode = "wb",
              destfile = "temp.xls")


  airport_passengers_raw <- readxl::read_xls("temp.xls",
                                           sheet = 3,
                                           skip = 6
                                           )

  aircraft_movements_raw <- readxl::read_xls("temp.xls",
                                           sheet = 4,
                                           skip = 6
                                           )

  aircraft_movements_raw %>% cleaner()

}
