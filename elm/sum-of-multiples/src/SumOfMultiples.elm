module SumOfMultiples exposing (sumOfMultiples)

import Set


sumOfMultiples : List Int -> Int -> Int
sumOfMultiples divisors limit =
    let
        divisibleBy : Int -> Int -> Bool
        divisibleBy =
            \x y -> modBy x y == 0

        multiples : List (List Int)
        multiples =
            divisors
                |> List.map
                    (\d ->
                        List.range d (limit - 1)
                            |> List.filter (\e -> divisibleBy d e)
                    )

        points : Set.Set Int
        points =
            List.foldl Set.insert Set.empty (List.concat multiples)
    in
    Set.foldl (+) 0 points
