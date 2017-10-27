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
    "year"
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

