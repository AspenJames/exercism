module MagicianInTraining exposing (..)

import Array exposing (Array)


getCard : Int -> Array Int -> Maybe Int
getCard =
    Array.get


setCard : Int -> Int -> Array Int -> Array Int
setCard =
    Array.set


addCard : Int -> Array Int -> Array Int
addCard =
    Array.push


removeCard : Int -> Array Int -> Array Int
removeCard index deck =
    let
        len =
            Array.length deck
    in
    Array.append
        (Array.slice 0 index deck)
        (Array.slice (index + 1) len deck)


evenCardCount : Array Int -> Int
evenCardCount deck =
    deck
        |> Array.filter (\x -> remainderBy 2 x == 0)
        |> Array.length
