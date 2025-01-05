module SecureTreasureChest exposing (Password, SecureTreasureChest, createPassword, createTreasure, getTreasure)


type Password
    = Password String


type SecureTreasureChest treasure
    = SecureTreasureChest String treasure


createPassword : String -> Maybe Password
createPassword passwordCandidate =
    if String.length passwordCandidate >= 8 then
        Just (Password passwordCandidate)

    else
        Nothing


createTreasure : a -> Password -> SecureTreasureChest a
createTreasure treasure (Password password) =
    SecureTreasureChest password treasure


getTreasure : String -> SecureTreasureChest a -> Maybe a
getTreasure passwordAttempt (SecureTreasureChest password treasure) =
    if password == passwordAttempt then
        Just treasure

    else
        Nothing
