module Allergies exposing (Allergy(..), isAllergicTo, toList)


type Allergy
    = Eggs
    | Peanuts
    | Shellfish
    | Strawberries
    | Tomatoes
    | Chocolate
    | Pollen
    | Cats


isAllergicTo : Allergy -> Int -> Bool
isAllergicTo allergy score =
    List.member allergy <| toList score


toList : Int -> List Allergy
toList score =
    let
        listBuilder s l =
            let
                idx =
                    floor <| logBase 2 <| toFloat s

                next =
                    s - 2 ^ idx
            in
            case ( s, idx ) of
                ( 0, _ ) ->
                    l

                ( _, 0 ) ->
                    listBuilder next (Eggs :: l)

                ( _, 1 ) ->
                    listBuilder next (Peanuts :: l)

                ( _, 2 ) ->
                    listBuilder next (Shellfish :: l)

                ( _, 3 ) ->
                    listBuilder next (Strawberries :: l)

                ( _, 4 ) ->
                    listBuilder next (Tomatoes :: l)

                ( _, 5 ) ->
                    listBuilder next (Chocolate :: l)

                ( _, 6 ) ->
                    listBuilder next (Pollen :: l)

                ( _, 7 ) ->
                    listBuilder next (Cats :: l)

                _ ->
                    listBuilder next l
    in
    listBuilder score []
