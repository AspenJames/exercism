module TwoFer exposing (twoFer)


twoFer : Maybe String -> String
twoFer name =
    let
        greeting =
            Maybe.withDefault "you" name
    in
    "One for " ++ greeting ++ ", one for me."
