#' Australian flight distances
#'
#' This function returns a data frame of flight distances to and from each airport in Australia
#'      (domestic and international). Data is obtained from
#'     (\url{https://bitre.gov.au/statistics/aviation/}).
#'
#' @return A dataframe of uplift and destination airports (with codes), and the great circle distances
#'     between them in kilometres (km), nautical miles (nm), and statuteiles (miles).
#' @export
#'
#' @examples
#' \dontrun{
#' flightdistances()
#' }
flightdistances  <-  function() {

  flight_distance_raw  <- readr::read_csv("https://bitre.gov.au/statistics/aviation/files/australian_air_distances.csv",
                                      skip = 8)

  flight_distance <- flight_distance_raw %>%
    dplyr::filter(!is.na(CODE)) %>%
    dplyr::select(
      `AIRPORT NAME`,
      CODE,
      `AIRPORT NAME_1`,
      CODE_1,
      KM,
      NM,
      SM
    ) %>%
    dplyr::rename(
      origin             = `AIRPORT NAME`,
      origin_code        = CODE,
      dest               = `AIRPORT NAME_1`,
      dest_code          = CODE_1,
      distance_km        = KM,
      distance_nautmile  = NM,
      distance_mile      = SM
    )

  flight_distance

}
