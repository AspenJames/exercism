module GeoJSON exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Encoder)


type Geometry
    = Point (List Float)
    | LineString (List (List Float))


decodePointCoordinates : Decoder (List Float)
decodePointCoordinates =
    Decode.field "coordinates" (Decode.list Decode.float)


decodeLineStringCoordinates : Decoder (List (List Float))
decodeLineStringCoordinates =
    Decode.field "coordinates" (Decode.list (Decode.list Decode.float))


decodeGeometry : Decoder Geometry
decodeGeometry =
    Decode.field "type" Decode.string
        |> Decode.andThen
            (\value ->
                case value of
                    "Point" ->
                        decodePointCoordinates |> Decode.map Point

                    "LineString" ->
                        decodeLineStringCoordinates |> Decode.map LineString

                    _ ->
                        Decode.fail "Geometry not implemented yet, or invalid type value"
            )


encodeGeometry : Geometry -> Value
encodeGeometry geometry =
    case geometry of
        Point coord ->
            Encode.object
                [ ( "type", Encode.string "Point" )
                , ( "coordinates", Encode.list Encode.float coord )
                ]

        LineString coord ->
            Encode.object
                [ ( "type", Encode.string "LineString" )
                , ( "coordinates", Encode.list (Encode.list Encode.float) coord )
                ]


type alias Feature =
    { id : Maybe String
    , geometry : Maybe Geometry
    , properties : Maybe (Dict String Value)
    }


decodeFeatureId : Decoder String
decodeFeatureId =
    Decode.oneOf
        [ Decode.string
        , Decode.int |> Decode.map String.fromInt
        , Decode.float |> Decode.map String.fromFloat
        ]
        |> Decode.field "id"


decodeMaybeFeatureId : Decoder (Maybe String)
decodeMaybeFeatureId =
    Decode.maybe decodeFeatureId


decodeFeatureGeometry : Decoder (Maybe Geometry)
decodeFeatureGeometry =
    Decode.nullable decodeGeometry
        |> Decode.field "geometry"


decodeProperties : Decoder (Maybe (Dict String Value))
decodeProperties =
    Decode.nullable (Decode.dict Decode.value)
        |> Decode.field "properties"


decodeFeature : Decode Feature
decodeFeature =
    Decode.field "type" Decode.string
        |> Decode.andThen
            (\value ->
                if value /= "Feature" then
                    Decode.fail "not a Feature"

                else
                    Decode.map3 Feature
                        decodeMaybeFeatureId
                        decodeFeatureGeometry
                        decodeProperties
            )


encodeFeature : Feature -> Value
encodeFeature feature =
    let
        maybeId =
            case feature.id of
                Nothing ->
                    []

                Just id ->
                    [ ( "id", Encode.string id ) ]
    in
    Encode.object
        (maybeId
            ++ [ ( "type", Encode.string "Feature" )
               , ( "geometry"
                 , case feature.geometry of
                    Nothing ->
                        Encode.null

                    Just geometry ->
                        encodeGeometry geometry
                 )
               , ( "properties"
                 , case feature.properties of
                    Nothing ->
                        Encode.null

                    Just dict ->
                        Encode.dict identity identity dict
                 )
               ]
        )
