module LargestSeriesProduct exposing (largestProduct)


largestProduct : Int -> String -> Maybe Int
largestProduct length series =
    let
        inputSize =
            String.length series

        isValid =
            String.all Char.isDigit series
    in
    if not isValid || length < 1 || inputSize < 1 || length > inputSize then
        Nothing

    else
        List.range 0 (inputSize - length)
            |> List.map
                (\i ->
                    List.product
                        (series
                            |> String.dropLeft i
                            |> String.left length
                            |> String.toList
                            |> List.filterMap (String.fromChar >> String.toInt)
                        )
                )
            |> List.maximum
