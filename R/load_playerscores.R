#' Load RFL player score data from github
#'
#' @description Loads rfl-playerscores.rds files from github into a dataframe
#'
#' @param season: A numeric vector of 4-digit years
#' @return A tibble with the following columns:
#' * `season` (integer)
#' * `week` (integer)
#' * `player_id` (integer)
#' * `player_name` (character)
#' * `pos` (character)
#' * `team` (character)
#' * `points` (double)
#'
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' starter <- rflfastR::load_playerscores(2022)
#'
#' head(starter, 10)

load_playerscores <- function(seasons = 2016:nflreadr::most_recent_season()) {
  playerscores_list <- list()

  for (season in seasons) {
    df <- readRDS(url(paste0("https://github.com/jak3sch/rfl/blob/main/data/playerscores/rfl-playerscores-", season, ".rds?raw=true")))
    playerscores_list[[season]] <- df
  }

  playerscores <- do.call(rbind, playerscores_list) %>%
    dplyr::mutate(
      season = as.integer(season),
      week = as.integer(week),
      player_id = as.integer(player_id),
      points = as.double(points)
    )

  return(playerscores)
}
