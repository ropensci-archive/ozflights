library(tidyverse)
library(readxl)

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

# Rename columns 

# TODO: tidy 
