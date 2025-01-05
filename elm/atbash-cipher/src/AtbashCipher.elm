module AtbashCipher exposing (decode, encode)


atbash : Char -> Char
atbash ch =
    if Char.isAlpha ch then
        Char.fromCode <| 122 - (Char.toCode ch - 97)

    else
        ch


encode : String -> String
encode plain =
    plain
        |> String.toLower
        |> String.toList
        |> List.filterMap
            (\c ->
                if Char.isAlphaNum c then
                    Just (atbash c)

                else
                    Nothing
            )
        |> List.indexedMap Tuple.pair
        |> List.map
            (\( i, c ) ->
                if i > 0 && modBy 5 i == 0 then
                    " " ++ String.fromChar c

                else
                    String.fromChar c
            )
        |> String.concat


decode : String -> String
decode cipher =
    cipher
        |> String.toList
        |> List.filterMap
            (\c ->
                if c == ' ' then
                    Nothing

                else
                    Just (atbash c)
            )
        |> List.foldr String.cons ""
