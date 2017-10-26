#' Australian international freight data
#'
#' Accesses Australian international freight data from
#'     (\url{https://bitre.gov.au/publications/ongoing/airport_traffic_data.aspx}).
#'     Contains inbound and outbound freight and mail in tonnes from Australian
#'     airports, indexed by year.
#'
#' @return A dataframe of international freight data through Australian airports
#' @export
#'
#' @examples
#' /dontrun{
#' international_freight()
#' }
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

#' Australian airport passenger traffic
#'
#' Accesses Australian airport passenger traffic data from
#'     (\url{https://bitre.gov.au/publications/ongoing/airport_traffic_data.aspx}).
#'     Contains the counts of inbound and outbound, domestic and international revenue
#'     passengers from Australian airports, indexed by year.
#'
#' @return A tidy data frame of passengers passing through Australian airports
#' @export
#'
#' @examples
#' /dontrun{
#' airport_passengers()
#' }
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

#' Australian aircraft movements
#'
#' Accesses Australian aircraft traffic data from
#'     (\url{https://bitre.gov.au/publications/ongoing/airport_traffic_data.aspx}).
#'     Contains the counts of inbound and outbound, domestic and international flights
#'     from Australian airports, indexed by year.
#'
#' @return A tidy data frame of flights passing through Australian airports
#' @export
#'
#' @examples
#' /dontrun{
#' aircraft_movements()
#' }
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
