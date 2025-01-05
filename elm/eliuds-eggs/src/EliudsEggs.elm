module EliudsEggs exposing (eggCount)


type Bit
    = Zero
    | One


type alias Binary =
    List Bit


toBinary : Int -> Binary
toBinary n =
    let
        toBinHelper m acc =
            let
                sym =
                    if modBy 2 m == 0 then
                        Zero

                    else
                        One

                div =
                    m // 2
            in
            if div == 0 then
                sym :: acc

            else
                toBinHelper div (sym :: acc)
    in
    toBinHelper n []



{- We don't need this function, but it was fun to make -}


fromBinary : Binary -> Int
fromBinary bin =
    let
        fromBinaryHelper level binary =
            case binary of
                [] ->
                    0

                x :: xs ->
                    case x of
                        Zero ->
                            fromBinaryHelper (level + 1) xs

                        One ->
                            (2 ^ level) + fromBinaryHelper (level + 1) xs
    in
    bin |> List.reverse |> fromBinaryHelper 0


eggCount : Int -> Int
eggCount n =
    toBinary n
        |> List.filter (\x -> x == One)
        |> List.length
