# get_game_list

#' get_game_list
#'
#' This function fetches a basic list of games.
#' @keywords game
#' @export
#' @examples
#' get_game_list()

get_game_list <- function(){
  shorts <- get_fdr() %>% select(short_name)
  fixtures <- jsonlite::fromJSON("https://fantasy.premierleague.com/drf/fixtures/")
  data.frame(
    "GW"=fixtures$event,
    "id"=fixtures$id,
    "home"=fixtures$team_h,
    "away"=fixtures$team_a,
    "finished"=fixtures$finished,
    "kickoff"=fixtures$kickoff_time) %>%
    dplyr:: mutate(home = case_when(
      home == "1" ~ shorts[1,],
      home == "2" ~ shorts[2,],
      home == "3" ~ shorts[3,],
      home == "4" ~ shorts[4,],
      home == "5" ~ shorts[5,],
      home == "6" ~ shorts[6,],
      home == "7" ~ shorts[7,],
      home == "8" ~ shorts[8,],
      home == "9" ~ shorts[9,],
      home == "10" ~ shorts[10,],
      home == "11" ~ shorts[11,],
      home == "12" ~ shorts[12,],
      home == "13" ~ shorts[13,],
      home == "14" ~ shorts[14,],
      home == "15" ~ shorts[15,],
      home == "16" ~ shorts[16,],
      home == "17" ~ shorts[17,],
      home == "18" ~ shorts[18,],
      home == "19" ~ shorts[19,],
      home == "20" ~ shorts[20,]
    )) %>%
    dplyr:: mutate(away = case_when(
      away == "1" ~ shorts[1,],
      away == "2" ~ shorts[2,],
      away == "3" ~ shorts[3,],
      away == "4" ~ shorts[4,],
      away == "5" ~ shorts[5,],
      away == "6" ~ shorts[6,],
      away == "7" ~ shorts[7,],
      away == "8" ~ shorts[8,],
      away == "9" ~ shorts[9,],
      away == "10" ~ shorts[10,],
      away == "11" ~ shorts[11,],
      away == "12" ~ shorts[12,],
      away == "13" ~ shorts[13,],
      away == "14" ~ shorts[14,],
      away == "15" ~ shorts[15,],
      away == "16" ~ shorts[16,],
      away == "17" ~ shorts[17,],
      away == "18" ~ shorts[18,],
      away == "19" ~ shorts[19,],
      away == "20" ~ shorts[20,]
    ))
}

# get_game_stats

#' get_game_stats
#'
#' This function fetches detailed statistics for a game given the game ID. It fetches ten variables that are accessed as lists with home and away players, e.g. with '$': goals_scored, assists, own_goals, penalties_saved, yellow_cards, red_cards, saves, bonus, and bps.
#' @param gameid The game ID. Can be found with get_game_list().
#' @keywords game
#' @export
#' @examples
#' get_game_stats(20)

get_game_stats <- function(gameid = NULL){
  ifelse(
    is.null(gameid),
    return(print("You'll need to input a game ID, mate.")),
    ifelse(length(gameid) != 1,"One at a time, please",
           {
             fixtures <- jsonlite::fromJSON("https://fantasy.premierleague.com/drf/fixtures")
             return((fixtures %>% dplyr::filter(id %in% gameid))$stats[[1]])
           }
    ))
}
