module SqueakyClean exposing (clean, clean1, clean2, clean3, clean4)


clean1 : String -> String
clean1 =
    String.replace " " "_"


clean2 : String -> String
clean2 =
    let
        strReplaceAll : List String -> String -> String -> String
        strReplaceAll before after string =
            case before of
                [] ->
                    string

                b :: bs ->
                    String.replace b after string
                        |> strReplaceAll bs after
    in
    clean1
        >> strReplaceAll [ "\n", "\t", "\u{000D}" ] "[CTRL]"


clean3 : String -> String
clean3 =
    let
        strIter : String -> List Char -> String
        strIter out inp =
            case inp of
                [] ->
                    out

                '-' :: xs ->
                    case xs of
                        [] ->
                            out

                        n :: ns ->
                            strIter (String.cons (Char.toUpper n) out) ns

                x :: xs ->
                    strIter (String.cons x out) xs
    in
    clean2
        >> String.toList
        >> strIter ""
        >> String.reverse


clean4 : String -> String
clean4 =
    clean3
        >> String.filter (\c -> not <| Char.isDigit c)


clean : String -> String
clean =
    clean4
        >> String.filter
            (\c -> c < 'α' || c > 'ω')
