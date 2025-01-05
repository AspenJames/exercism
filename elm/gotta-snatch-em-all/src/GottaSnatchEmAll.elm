module GottaSnatchEmAll exposing (..)

import Set exposing (Set)


type alias Card =
    String


newCollection : Card -> Set Card
newCollection =
    Set.singleton


addCard : Card -> Set Card -> ( Bool, Set Card )
addCard card collection =
    ( Set.member card collection, Set.insert card collection )


tradeCard : Card -> Card -> Set Card -> ( Bool, Set Card )
tradeCard yourCard theirCard collection =
    let
        canTradeCard yc tc c =
            Set.member yc c && not (Set.member tc c)
    in
    ( canTradeCard yourCard theirCard collection
    , collection |> Set.remove yourCard |> Set.insert theirCard
    )


removeDuplicates : List Card -> List Card
removeDuplicates =
    Set.fromList >> Set.toList


extraCards : Set Card -> Set Card -> Int
extraCards yourCollection theirCollection =
    Set.diff yourCollection theirCollection
        |> Set.size


boringCards : List (Set Card) -> List Card
boringCards collections =
    case collections of
        [] ->
            []

        x :: xs ->
            List.foldl Set.intersect x xs
                |> Set.toList


totalCards : List (Set Card) -> Int
totalCards collections =
    case collections of
        [] ->
            0

        x :: xs ->
            List.foldl Set.union x xs
                |> Set.size


splitShinyCards : Set Card -> ( List Card, List Card )
splitShinyCards collection =
    Set.partition (String.startsWith "Shiny") collection
        |> Tuple.mapBoth Set.toList Set.toList
