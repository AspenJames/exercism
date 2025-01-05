module PhoneNumber exposing (getNumber)


getNumber : String -> Maybe String
getNumber phoneNumber =
    let
        isValid n =
            n >= '2' && n <= '9'

        numberFromList l =
            case l of
                -- a  b
                -- NXXNXXXXXX
                a :: _ :: _ :: b :: _ ->
                    if isValid a && isValid b then
                        Just <| List.foldr String.cons "" l

                    else
                        Nothing

                _ ->
                    Nothing

        cleaned =
            phoneNumber
                |> String.filter Char.isDigit
                |> String.toList
    in
    case List.length cleaned of
        11 ->
            case cleaned of
                '1' :: xs ->
                    numberFromList xs

                _ ->
                    Nothing

        10 ->
            numberFromList cleaned

        _ ->
            Nothing
