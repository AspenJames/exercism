module Go exposing (..)

import GoSupport exposing (..)


applyRules : Game -> Rule -> NonValidatingRule -> Rule -> Rule -> Game
applyRules game oneStonePerPointRule captureRule libertyRule koRule =
    let
        result =
            game
                |> oneStonePerPointRule
                |> Result.map captureRule
                |> Result.andThen libertyRule
                |> Result.andThen koRule
    in
    case result of
        Ok g ->
            changePlayer g

        Err e ->
            { game | error = e }
