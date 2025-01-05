module Raindrops exposing (raindrops)


raindrops : Int -> String
raindrops number =
    let
        divBy =
            \x y -> modBy x y == 0
    in
    case ( divBy 3 number, divBy 5 number, divBy 7 number ) of
        ( False, False, False ) ->
            String.fromInt number

        ( True, False, False ) ->
            "Pling"

        ( False, True, False ) ->
            "Plang"

        ( False, False, True ) ->
            "Plong"

        ( True, True, False ) ->
            "PlingPlang"

        ( True, False, True ) ->
            "PlingPlong"

        ( False, True, True ) ->
            "PlangPlong"

        ( True, True, True ) ->
            "PlingPlangPlong"
