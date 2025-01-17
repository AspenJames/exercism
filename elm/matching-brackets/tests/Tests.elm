module Tests exposing (tests)

import Expect
import MatchingBrackets exposing (isPaired)
import Test exposing (..)


tests : Test
tests =
    describe "MatchingBrackets"
        [ test "paired square brackets" <|
            \_ ->
                Expect.equal True (isPaired "[]")
        , test "empty string" <|
            \_ ->
                Expect.equal True (isPaired "")
        , test "unpaired brackets" <|
            \_ ->
                Expect.equal False (isPaired "[[")
        , test "wrong ordered brackets" <|
            \_ ->
                Expect.equal False (isPaired "}{")
        , test "wrong closing bracket" <|
            \_ ->
                Expect.equal False (isPaired "{]")
        , test "paired with whitespace" <|
            \_ ->
                Expect.equal True (isPaired "{ }")
        , test "partially paired brackets" <|
            \_ ->
                Expect.equal False (isPaired "{[])")
        , test "simple nested brackets" <|
            \_ ->
                Expect.equal True (isPaired "{[]}")
        , test "seceral paired brackets" <|
            \_ ->
                Expect.equal True (isPaired "{}[]")
        , test "paired and nested brackets" <|
            \_ ->
                Expect.equal True (isPaired "([{}({}[])])")
        , test "unopened closing brackets" <|
            \_ ->
                Expect.equal False (isPaired "{[)][]}")
        , test "unpaired and nested brackets" <|
            \_ ->
                Expect.equal False (isPaired "([{])")
        , test "paired and wrong nested brackets" <|
            \_ ->
                Expect.equal False (isPaired "[({]})")
        , test "paired and wrong nested brackets but innermost are correct" <|
            \_ ->
                Expect.equal False (isPaired "[({}])")
        , test "early unexpected brackets" <|
            \_ ->
                Expect.equal False (isPaired ")()")
        , test "early mismatched brackets" <|
            \_ ->
                Expect.equal False (isPaired "{)()")
        , test "math expression" <|
            \_ ->
                Expect.equal True (isPaired "(((185 + 223.85) * 15) - 543)/2")
        , test "complex latex expression" <|
            \_ ->
                Expect.equal True (isPaired "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)")
        ]
