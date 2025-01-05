module TisburyTreasureHunt exposing (..)


type alias Place =
    ( String, PlaceLocation )


type alias PlaceLocation =
    ( Char, Int )


type alias Treasure =
    ( String, TreasureLocation )


type alias TreasureLocation =
    ( Int, Char )


placeLocationToTreasureLocation : PlaceLocation -> TreasureLocation
placeLocationToTreasureLocation placeLocation =
    ( Tuple.second placeLocation, Tuple.first placeLocation )


treasureLocationMatchesPlaceLocation : PlaceLocation -> TreasureLocation -> Bool
treasureLocationMatchesPlaceLocation placeLocation treasureLocation =
    treasureLocation == placeLocationToTreasureLocation placeLocation


countPlaceTreasures : Place -> List Treasure -> Int
countPlaceTreasures place treasures =
    let
        isHere : TreasureLocation -> Bool
        isHere =
            treasureLocationMatchesPlaceLocation (Tuple.second place)

        countIfHere : Treasure -> Int -> Int
        countIfHere ( _, treasureLocation ) count =
            if isHere treasureLocation then
                count + 1

            else
                count
    in
    treasures
        |> List.foldl countIfHere 0


specialCaseSwapPossible : Treasure -> Place -> Treasure -> Bool
specialCaseSwapPossible ( foundTreasure, _ ) ( place, _ ) ( desiredTreasure, _ ) =
    case ( foundTreasure, place, desiredTreasure ) of
        ( "Brass Spyglass", "Abandoned Lighthouse", _ ) ->
            True

        ( "Amethyst Octopus", "Stormy Breakwater", t ) ->
            t == "Crystal Crab" || t == "Glass Starfish"

        ( "Vintage Pirate Hat", "Harbor Managers Office", t ) ->
            t == "Model Ship in Large Bottle" || t == "Antique Glass Fishnet Float"

        _ ->
            False
