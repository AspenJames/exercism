module Anagram exposing (detect)


detect : String -> List String -> List String
detect word candidates =
    let
        sortWord =
            String.toLower >> String.toList >> List.sort

        isAnagram w =
            (String.toLower w /= String.toLower word) && (sortWord w == sortWord word)
    in
    List.filter isAnagram candidates
