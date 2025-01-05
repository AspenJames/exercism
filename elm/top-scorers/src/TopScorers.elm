module TopScorers exposing (..)

import Dict exposing (Dict)
import TopScorersSupport exposing (PlayerName)


updateGoalCountForPlayer : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
updateGoalCountForPlayer playerName playerGoalCounts =
    playerGoalCounts
        |> Dict.update playerName
            (\score ->
                case score of
                    Nothing ->
                        Just 1

                    Just s ->
                        Just (s + 1)
            )


aggregateScorers : List PlayerName -> Dict PlayerName Int
aggregateScorers =
    List.foldl updateGoalCountForPlayer Dict.empty


removeInsignificantPlayers : Int -> Dict PlayerName Int -> Dict PlayerName Int
removeInsignificantPlayers goalThreshold playerGoalCounts =
    playerGoalCounts
        |> Dict.filter (\_ goals -> goals >= goalThreshold)


resetPlayerGoalCount : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
resetPlayerGoalCount playerName playerGoalCounts =
    playerGoalCounts
        |> Dict.insert playerName 0


formatPlayer : PlayerName -> Dict PlayerName Int -> String
formatPlayer playerName playerGoalCounts =
    let
        score =
            Dict.get playerName playerGoalCounts
                |> Maybe.withDefault 0
    in
    playerName ++ ": " ++ String.fromInt score


formatPlayers : Dict PlayerName Int -> String
formatPlayers players =
    players
        |> Dict.keys
        |> List.map (\p -> formatPlayer p players)
        |> String.join ", "


combineGames : Dict PlayerName Int -> Dict PlayerName Int -> Dict PlayerName Int
combineGames game1 game2 =
    Dict.merge
        Dict.insert
        (\player score1 score2 acc -> acc |> Dict.insert player (score1 + score2))
        Dict.insert
        game1
        game2
        Dict.empty
