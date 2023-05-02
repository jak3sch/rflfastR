#' Load RFL starter data from github
#'
#' @description Loads rfl-starter.csv files from github into a dataframe
#'
#' @param season: A numeric vector of 4-digit years
#' @return A tibble with the following columns:
#' * `season` (integer)
#' * `week` (integer)
#' * `franchise_id` (character)
#' * `starter_status` (character)
#' * `player_id` (integer)
#' * `player_name` (character)
#' * `pos` (character)
#' * `team` (character)
#' * `player_score` (double)
#' * `should_start` (integer)
#'
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' starter <- rflfastR::load_starter(2022)
#'
#' head(starter, 10)

load_starter <- function(seasons = 2016:nflreadr::most_recent_season()) {
  starter <- purrr::map_df(seasons, function(x) {
    readr::read_csv(
      glue::glue("https://raw.githubusercontent.com/jak3sch/rfl/main/data/starter/rfl-starter-{x}.csv"),
      col_types = "iicdiicccc"
    )
  }) %>%
    dplyr::select(season, week, franchise_id, starter_status, player_id, player_name, pos, team, player_score, should_start)

  return(starter)
}
