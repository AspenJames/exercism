module Yacht exposing (Category(..), score)

import Dict exposing (Dict)


type Category
    = Ones
    | Twos
    | Threes
    | Fours
    | Fives
    | Sixes
    | FullHouse
    | FourOfAKind
    | LittleStraight
    | BigStraight
    | Choice
    | Yacht


score : List Int -> Category -> Int
score dice category =
    let
        -- Transform a dice roll to a map of die to count.
        -- e.g. asMap [1, 1, 2, 3, 3] = Dict.fromList [(1,2),(2,1),(3,2)]
        asMap : List Int -> Dict Int Int
        asMap =
            List.foldl
                (\die map ->
                    Dict.update
                        die
                        (Maybe.withDefault 0 >> (+) 1 >> Just)
                        map
                )
                Dict.empty

        -- Score a single die.
        scoreDie : Int -> Int
        scoreDie i =
            dice
                |> asMap
                |> Dict.foldl
                    (\die count total ->
                        if die == i then
                            total + die * count

                        else
                            total
                    )
                    0

        -- Sum all the dice.
        scoreDice : List Int -> Int
        scoreDice =
            asMap >> Dict.foldl (\die count total -> total + die * count) 0

        -- Retrieve list of counts of unique dice.
        dieCounts : List Int -> List Int
        dieCounts =
            asMap >> Dict.values >> List.sort

        -- Retrieve list of unique dice.
        dieValues : List Int -> List Int
        dieValues =
            asMap >> Dict.keys
    in
    case category of
        Ones ->
            scoreDie 1

        Twos ->
            scoreDie 2

        Threes ->
            scoreDie 3

        Fours ->
            scoreDie 4

        Fives ->
            scoreDie 5

        Sixes ->
            scoreDie 6

        FullHouse ->
            case dice |> dieCounts of
                [ 2, 3 ] ->
                    dice |> scoreDice

                _ ->
                    0

        FourOfAKind ->
            dice
                |> asMap
                |> Dict.foldl
                    (\die count total ->
                        if count >= 4 then
                            total + die * 4

                        else
                            total
                    )
                    0

        LittleStraight ->
            case dice |> dieValues of
                [ 1, 2, 3, 4, 5 ] ->
                    30

                _ ->
                    0

        BigStraight ->
            case dice |> dieValues of
                [ 2, 3, 4, 5, 6 ] ->
                    30

                _ ->
                    0

        Choice ->
            dice |> scoreDice

        Yacht ->
            case dice |> dieCounts of
                [ 5 ] ->
                    50

                _ ->
                    0
