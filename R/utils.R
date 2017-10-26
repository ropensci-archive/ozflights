#' @importFrom magrittr %>%
NULL

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
