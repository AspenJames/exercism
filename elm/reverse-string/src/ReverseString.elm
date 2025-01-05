module ReverseString exposing (reverse)


reverse : String -> String
reverse str =
    -- String.reverse str exists, but also:
    String.foldl String.cons "" str
