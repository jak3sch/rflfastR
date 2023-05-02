#' Load RFL players via mfl api
#'
#' @description Loads league players via mfl players API endpoint
#'
#' @param season: A numeric vector of 4-digit years
#' @return A tibble with the following columns:
#' * `player_name` (character)
#' * `team` (character)
#' * `pos` (character)
#' * `player_id` (integer)
#' * `status` (character)
#'
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' players <- rflfastR::load_players()
#'
#' head(players, 10)

load_players <- function() {
  players <- jsonlite::read_json("https://www45.myfantasyleague.com/2023/export?TYPE=players&L=63018&APIKEY=aRNp3s%2BWvuWsx12mPlrBYDoeErox&DETAILS=&SINCE=&PLAYERS=&JSON=1")$players$player %>%
    dplyr::tibble() %>%
    tidyr::unnest_wider(1) %>%
    dplyr::rename(
      player_name = name,
      pos = position,
      player_id = id
    ) %>%
    dplyr::mutate(
      player_id = as.integer(player_id)
    )

  return(players)
}
