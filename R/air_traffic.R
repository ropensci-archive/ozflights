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
#' \dontrun{
#' international_freight()
#' }
international_freight <-  function(){

  utils::download.file("https://www.bitre.gov.au/sites/default/files/WebAirport_CY_1985-2018.xlsx",
                mode = "wb",
                destfile = "temp-flights.xlsx")

  international_freight_raw <- readxl::read_xlsx("temp-flights.xlsx",
                                                sheet = 5,
                                                skip = 6
  )

  file.remove("temp-flights.xlsx")

  international_freight <- international_freight_raw
  colnames(international_freight) <- c("airport", "year",
                                       "freight_inbound", "freight_outbound",
                                       "int_freight_total",
                                       "mail_inbound", "mail_outbound",
                                       "int_mail_total")

  international_freight <- international_freight %>%
    dplyr::select(airport,
                  year,
                  freight_inbound,
                  freight_outbound,
                  mail_inbound,
                  mail_outbound) %>%
    tidyr::gather(key = direction, value= tonnage, -airport, -year) %>%
    dplyr::mutate(
      type = ifelse(grepl("freight_", direction), "Freight", "Mail"),
      direction = gsub("freight_", "", direction),
      direction = gsub("mail_", "", direction)
      )

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
#' \dontrun{
#' airport_passengers()
#' }
airport_passengers <- function() {

  utils::download.file("https://www.bitre.gov.au/sites/default/files/WebAirport_CY_1985-2018.xlsx",
              mode = "wb",
              destfile = "temp-flights.xlsx")


  airport_passengers_raw <- readxl::read_xlsx("temp-flights.xlsx",
                                           sheet = 3,
                                           skip = 6
                                           )
  file.remove("temp-flights.xlsx")

  airport_passengers_raw %>% cleaner()
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
#' \dontrun{
#' aircraft_movements()
#' }
aircraft_movements <-  function() {

  utils::download.file("https://www.bitre.gov.au/sites/default/files/WebAirport_CY_1985-2018.xlsx",
              mode = "wb",
              destfile = "temp-flights.xlsx")

  aircraft_movements_raw <- readxl::read_xlsx("temp-flights.xlsx",
                                           sheet = 4,
                                           skip = 6
                                           )

  file.remove("temp-flights.xlsx")

  aircraft_movements_raw %>% cleaner()

}
