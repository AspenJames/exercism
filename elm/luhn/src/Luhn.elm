module Luhn exposing (valid)


valid : String -> Bool
valid input =
    let
        digits =
            input |> String.filter Char.isDigit |> String.toList

        isValid =
            (List.length digits > 1)
                && (input
                        |> String.filter ((/=) ' ')
                        |> String.toList
                        |> List.all Char.isDigit
                   )

        charToInt c =
            Char.toCode c - Char.toCode '0'
    in
    isValid
        && (digits
                |> List.reverse
                |> List.indexedMap
                    (\i digit ->
                        let
                            double =
                                2 * charToInt digit

                            cappedDouble =
                                if double > 9 then
                                    double - 9

                                else
                                    double
                        in
                        if modBy 2 i == 1 then
                            cappedDouble

                        else
                            charToInt digit
                    )
                |> List.sum
                |> modBy 10
                |> (==) 0
           )
