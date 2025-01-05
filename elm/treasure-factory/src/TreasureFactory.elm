module TreasureFactory exposing (TreasureChest, getTreasure, makeChest, makeTreasureChest, secureChest, uniqueTreasures)


type TreasureChest treasure
    = TreasureChest String treasure


getTreasure : String -> TreasureChest a -> Maybe a
getTreasure passwordAttempt (TreasureChest password treasure) =
    if passwordAttempt == password then
        Just treasure

    else
        Nothing


type Chest treasure conditions
    = Chest (TreasureChest treasure)


makeChest : String -> treasure -> Chest treasure {}
makeChest password treasure =
    Chest (TreasureChest password treasure)


secureChest : Chest treasure conditions -> Maybe (Chest treasure { conditions | securePassword : () })
secureChest (Chest treasure) =
    let
        (TreasureChest password _) =
            treasure
    in
    if String.length password >= 8 then
        Just (Chest treasure)

    else
        Nothing


uniqueTreasures : List (Chest treasure conditions) -> List (Chest treasure { conditions | uniqueTreasure : () })
uniqueTreasures treasures =
    let
        onlyOne : Chest treasure conditions -> Bool
        onlyOne (Chest (TreasureChest _ treasure)) =
            let
                allTreasures : List treasure
                allTreasures =
                    treasures |> List.map (\(Chest (TreasureChest _ t)) -> t)
            in
            allTreasures |> List.filter (\t -> t == treasure) |> List.length |> (==) 1

        makeUnique : Chest treasure conditions -> Chest treasure { conditions | uniqueTreasure : () }
        makeUnique (Chest treasure) =
            Chest treasure
    in
    treasures
        |> List.filter onlyOne
        |> List.map makeUnique


makeTreasureChest : Chest treasure { conditions | securePassword : (), uniqueTreasure : () } -> TreasureChest treasure
makeTreasureChest (Chest treasure) =
    treasure
