module BlorkemonCards exposing
    ( Card
    , compareShinyPower
    , expectedWinner
    , isMorePowerful
    , maxPower
    , sortByCoolness
    , sortByMonsterName
    )


type alias Card =
    { monster : String, power : Int, shiny : Bool }


isMorePowerful : Card -> Card -> Bool
isMorePowerful card1 card2 =
    card1.power > card2.power


maxPower : Card -> Card -> Int
maxPower card1 card2 =
    max card1.power card2.power


sortByMonsterName : List Card -> List Card
sortByMonsterName =
    List.sortBy .monster


sortByCoolness : List Card -> List Card
sortByCoolness =
    List.sortWith
        (\c2 ->
            \c1 ->
                case compareShiny c1 c2 of
                    EQ ->
                        compare c1.power c2.power

                    res ->
                        res
        )


compareShiny : Card -> Card -> Order
compareShiny c1 c2 =
    case ( c1.shiny, c2.shiny ) of
        ( True, False ) ->
            GT

        ( False, True ) ->
            LT

        _ ->
            EQ


compareShinyPower : Card -> Card -> Order
compareShinyPower card1 card2 =
    case compare card1.power card2.power of
        EQ ->
            compareShiny card1 card2

        res ->
            res


expectedWinner : Card -> Card -> String
expectedWinner card1 card2 =
    case compareShinyPower card1 card2 of
        EQ ->
            "too close to call"

        GT ->
            card1.monster

        LT ->
            card2.monster
