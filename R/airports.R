#' Airport locations
#'
#' This function provides the Name, code and latitude and longitude (in degrees) of
#'     every airport in Australia or with a flight to Australia. Data is obtained from
#'     (\url{https://bitre.gov.au/statistics/aviation/}).
#'
#' @return Returns a dataframe of Australian airports with latitudes and longitude.
#' @export
#'
#' @examples
#' \dontrun{
#' airports()
#' }
airports  <-  function() {

  airports_raw  <- readr::read_csv("https://bitre.gov.au/statistics/aviation/files/australian_air_distances.csv",
                                   skip = 8)

  airports <- airports_raw %>%
    dplyr::filter(!is.na(CODE)) %>%
    dplyr::distinct(`AIRPORT NAME`, .keep_all = TRUE) %>%
    dplyr::select(
      `AIRPORT NAME`,
      CODE,
      DEG,
      MIN,
      SEC,
      DIR,
      DEG_1,
      MIN_1,
      SEC_1,
      DIR_1
    ) %>%
    dplyr::rename(
      airport      = `AIRPORT NAME`,
      airport_code = CODE,
      lat_deg      = DEG,
      lat_min      = MIN,
      lat_sec      = SEC,
      lat_dir      = DIR,
      long_deg     = DEG_1,
      long_min     = MIN_1,
      long_sec     = SEC_1,
      long_dir     = DIR_1
    ) %>%
    dplyr::transmute(
      airport = airport,
      airport_code = airport_code,
      lat = convert_latlong(lat_deg, lat_min, lat_sec, lat_dir),
      long = convert_latlong(long_deg, long_min, long_sec, long_dir))

  airports
}
