module Bob exposing (hey)


hey : String -> String
hey remark =
    let
        trimmed =
            String.trim remark

        isWhitespace =
            trimmed == ""

        isCaps =
            trimmed == String.toUpper trimmed && trimmed /= String.toLower trimmed

        isQuestion =
            String.right 1 trimmed == "?"
    in
    case ( isWhitespace, isCaps, isQuestion ) of
        ( True, _, _ ) ->
            "Fine. Be that way!"

        ( False, True, True ) ->
            "Calm down, I know what I'm doing!"

        ( False, True, False ) ->
            "Whoa, chill out!"

        ( False, False, True ) ->
            "Sure."

        ( False, False, False ) ->
            "Whatever."
