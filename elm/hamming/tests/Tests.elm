module Tests exposing (tests)

import Expect
import Hamming exposing (distance)
import Test exposing (..)


tests : Test
tests =
    describe "Hamming"
        [ test "identical strands" <|
            \() -> Expect.equal (Ok 0) (distance "A" "A")
        , test "long identical strands" <|
            \() -> Expect.equal (Ok 0) (distance "GGACTGA" "GGACTGA")
        , test "complete distance in single nucleotide strands" <|
            \() -> Expect.equal (Ok 1) (distance "A" "G")
        , test "complete distance in small strands" <|
            \() -> Expect.equal (Ok 2) (distance "AG" "CT")
        , test "small distance in small strands" <|
            \() -> Expect.equal (Ok 1) (distance "AT" "CT")
        , test "small distance" <|
            \() -> Expect.equal (Ok 1) (distance "GGACG" "GGTCG")
        , test "small distance in long strands" <|
            \() -> Expect.equal (Ok 2) (distance "ACCAGGG" "ACTATGG")
        , test "non-unique character in first strand" <|
            \() -> Expect.equal (Ok 1) (distance "AGA" "AGG")
        , test "non-unique character in second strand" <|
            \() -> Expect.equal (Ok 1) (distance "AGG" "AGA")
        , test "large distance" <|
            \() -> Expect.equal (Ok 4) (distance "GATACA" "GCATAA")
        , test "large distance in off-by-one strand" <|
            \() -> Expect.equal (Ok 9) (distance "GGACGGATTCTG" "AGGACGGATTCT")
        , test "empty strands" <|
            \() -> Expect.equal (Ok 0) (distance "" "")
        , test "disallow first strand longer" <|
            \() -> Expect.equal (Err "strands must be of equal length") (distance "AATG" "AAA")
        , test "disallow second strand longer" <|
            \() -> Expect.equal (Err "strands must be of equal length") (distance "ATA" "AGTG")
        , test "disallow left empty strand" <|
            \() -> Expect.equal (Err "strands must be of equal length") (distance "" "G")
        , test "disallow right empty strand" <|
            \() -> Expect.equal (Err "strands must be of equal length") (distance "G" "")
        ]
