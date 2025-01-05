module Pangram exposing (isPangram)

import Char
import Set


isPangram : String -> Bool
isPangram sentence =
    sentence
        |> String.filter Char.isAlpha
        |> String.map Char.toLower
        |> String.toList
        |> Set.fromList
        |> Set.size
        |> (==) 26
