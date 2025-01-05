module Series exposing (slices)


slices : Int -> String -> Result String (List (List Int))
slices size input =
    let
        inputSize =
            String.length input
    in
    if inputSize == 0 then
        Err "series cannot be empty"

    else if size > inputSize then
        Err "slice length cannot be greater than series length"

    else if size == 0 then
        Err "slice length cannot be zero"

    else if size < 0 then
        Err "slice length cannot be negative"

    else
        Ok
            (List.range 0 (inputSize - size)
                |> List.map
                    (\i ->
                        input
                            |> String.dropLeft i
                            |> String.left size
                            |> String.toList
                            |> List.map (String.fromChar >> String.toInt >> Maybe.withDefault 0)
                    )
            )
