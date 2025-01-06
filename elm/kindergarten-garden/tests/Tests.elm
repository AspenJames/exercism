module Tests exposing (tests)

import Expect
import KindergartenGarden exposing (Plant(..), Student(..))
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "KindergartenGarden"
        [ describe "partial garden"
            [ --
              test "garden with single student" <|
                \() ->
                    KindergartenGarden.plants "RC\nGG" Alice
                        |> Expect.equal [ Radish, Clover, Grass, Grass ]
            , test "different garden with single student" <|
                \() ->
                    KindergartenGarden.plants "VC\nRC" Alice
                        |> Expect.equal [ Violet, Clover, Radish, Clover ]
            , test "garden with two students" <|
                \() ->
                    KindergartenGarden.plants "VVCG\nVVRC" Bob
                        |> Expect.equal [ Clover, Grass, Radish, Clover ]
            , describe "multiple students for the same garden with three students"
                [ test "second student's garden" <|
                    \() ->
                        KindergartenGarden.plants "VVCCGG\nVVCCGG" Bob
                            |> Expect.equal [ Clover, Clover, Clover, Clover ]
                , test "third student's garden" <|
                    \() ->
                        KindergartenGarden.plants "VVCCGG\nVVCCGG" Charlie
                            |> Expect.equal [ Grass, Grass, Grass, Grass ]
                ]
            ]
        , describe "full garden"
            [ test "for Alice, first student's garden" <|
                \() ->
                    KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Alice
                        |> Expect.equal [ Violet, Radish, Violet, Radish ]
            , test "for Bob, second student's garden" <|
                \() ->
                    KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Bob
                        |> Expect.equal [ Clover, Grass, Clover, Clover ]
            , test "for Charlie" <|
                \() ->
                    KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Charlie
                        |> Expect.equal [ Violet, Violet, Clover, Grass ]
            , test "for David" <|
                \() ->
                    KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" David
                        |> Expect.equal [ Radish, Violet, Clover, Radish ]
            , test "for Eve" <|
                \() ->
                    KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Eve
                        |> Expect.equal [ Clover, Grass, Radish, Grass ]
            , test "for Fred" <|
                \() ->
                    KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Fred
                        |> Expect.equal [ Grass, Clover, Violet, Clover ]
            , test "for Ginny" <|
                \() ->
                    KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Ginny
                        |> Expect.equal [ Clover, Grass, Grass, Clover ]
            , test "for Harriet" <|
                \() ->
                    KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Harriet
                        |> Expect.equal [ Violet, Radish, Radish, Violet ]
            , test "for Ileana" <|
                \() ->
                    KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Ileana
                        |> Expect.equal [ Grass, Clover, Violet, Clover ]
            , test "for Joseph" <|
                \() ->
                    KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Joseph
                        |> Expect.equal [ Violet, Clover, Violet, Grass ]
            , test "for Kincaid, second to last student's garden" <|
                \() ->
                    KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Kincaid
                        |> Expect.equal [ Grass, Clover, Clover, Grass ]
            , test "for Larry, last student's garden" <|
                \() ->
                    KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Larry
                        |> Expect.equal [ Grass, Violet, Clover, Violet ]
            ]
        ]
