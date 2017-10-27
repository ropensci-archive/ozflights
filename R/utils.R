#' @importFrom magrittr %>%
NULL

globalVariables(
  c(
    "AIRPORT",
    "Year",
    "INBOUND",
    "OUTBOUND",
    "INBOUND__1",
    "OUTBOUND__1",
    "type",
    "count",
    "airport",
    "year",
    "AIRPORT NAME",
    "AIRPORT NAME_1",
    "CODE",
    "CODE_1",
    "DEG",
    "DEG_1",
    "DIR", "DIR_1", "KM", "MIN",
    "MIN_1", "NM", "SEC", "SEC_1", "SM", "airport_code", "direction", "freight_inbound",
    "freight_outbound", "lat_deg", "lat_dir", "lat_min", "lat_sec", "long_deg", "long_dir",
    "long_min", "long_sec", "mail_inbound", "mail_outbound", "tonnage"
  )
)

cleaner <- function(x){
  dplyr::select(x, AIRPORT, Year, INBOUND, OUTBOUND, INBOUND__1, OUTBOUND__1) %>%
    dplyr::filter(!is.na(AIRPORT)) %>%
    dplyr::rename(
      airport = AIRPORT,
      year = Year,
      dom_inbound     = INBOUND,
      dom_outbound    = OUTBOUND,
      int_inbound     = INBOUND__1,
      int_outbound    = OUTBOUND__1
    ) %>%
    tidyr::gather(type, count, -airport, -year) %>%
    dplyr::mutate(
      domest = grepl("dom_", type),
      type = gsub("dom_", "", type),
      type = gsub("int_", "", type)
    )
}

# function for converting dms to decimal degrees
convert_latlong <-  function(deg, min, sec, direction) {
   ifelse(direction == "W" | direction == "S",
          (deg + min/60 + sec/360)*-1,
          (deg + min/60 + sec/360)
          )

}

