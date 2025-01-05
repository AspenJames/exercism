module RunLengthEncoding exposing (decode, encode)


encode : String -> String
encode string =
    let
        compress : Int -> Char -> List Char -> ( String, List Char )
        compress n c xs =
            let
                str =
                    if n == 1 then
                        String.fromChar c

                    else
                        String.fromInt n ++ String.fromChar c
            in
            case xs of
                [] ->
                    ( str, xs )

                y :: ys ->
                    if y == c then
                        compress (n + 1) c ys

                    else
                        ( str, xs )

        encodeList : List Char -> String
        encodeList l =
            case l of
                [] ->
                    ""

                x :: xs ->
                    case compress 1 x xs of
                        ( str, [] ) ->
                            str

                        ( str, ys ) ->
                            str ++ encodeList ys
    in
    string |> String.toList |> encodeList


decode : String -> String
decode string =
    let
        charToInt : Char -> Int
        charToInt c =
            Char.toCode c - Char.toCode '0'

        decodeList : List Char -> String
        decodeList l =
            case extractDigit 0 l of
                ( _, [] ) ->
                    ""

                ( n, x :: xs ) ->
                    expand n x ++ decodeList xs

        expand : Int -> Char -> String
        expand n c =
            if n <= 1 then
                String.fromChar c

            else
                String.fromChar c |> String.repeat n

        extractDigit : Int -> List Char -> ( Int, List Char )
        extractDigit i l =
            case l of
                [] ->
                    ( i, [] )

                x :: xs ->
                    if Char.isDigit x then
                        extractDigit (10 * i + charToInt x) xs

                    else
                        ( i, l )
    in
    string |> String.toList |> decodeList
