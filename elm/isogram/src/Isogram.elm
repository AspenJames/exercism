module Isogram exposing (isIsogram)

import Set


isIsogram : String -> Bool
isIsogram sentence =
    let
        letters =
            sentence
                |> String.toLower
                |> String.filter Char.isAlpha
                |> String.toList
    in
    List.length letters == Set.size (Set.fromList letters)
