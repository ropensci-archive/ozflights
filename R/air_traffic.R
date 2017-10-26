library(tidyverse)
library(readxl)

cleaner <- function(x){ 
  #not functional
  rename( 
    airportyear = X__1,
    airport = AIRPORT,
    year = Year,
    rank = Rank,
    dom_inbound     = INBOUND,
    dom_outbound    = OUTBOUND,
    dom_total       = TOTAL,
    int_inbound     = INBOUND__1,
    int_outbound    = OUTBOUND__1,
    int_total       = TOTAL__1,
    total__inbound  = INBOUND__2,
    total__outbound = OUTBOUND__2,
    total__total    = TOTAL__2
  ) %>% 
    gather(airportyear, -c(airport, year, rank)) %>% 
    select(-c(airportyear, rank)) 
}

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

international_freight_raw <- readxl::read_xls("temp.xls",
                                           sheet = 5,
                                           skip = 6
)



aircraft_movements <-  aircraft_movements_raw %>% cleaner()

airport_passengers <- airport_passengers_raw %>% cleaner()
 
  
# Rename columns 

# TODO: tidy 
