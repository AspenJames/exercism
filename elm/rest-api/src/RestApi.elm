module RestApi exposing (databaseFromJsonString, get, post)

import Dict exposing (Dict)
import Json.Decode exposing (Decoder, Error, field, int, string)
import Json.Encode


type alias JsonString =
    String


type alias Name =
    String


type alias User =
    { name : Name
    , owes : Dict Name Int
    , owedBy : Dict Name Int
    , balance : Int
    }


userDecoder : Decoder User
userDecoder =
    Decoder.map4
        (field "name" string)
        (field "owes" userDecoder)
        (field "owedBy" userDecoder)
        (field "balance" int)


databaseDecoder : Decoder Database
databaseDecoder =
    field "user" (Decode.list userDecoder)
        |> Decode.andThen (\l -> Decode.succeed (List.foldl (\u d -> Dict.insert u.name u d) Dict.empty l))


type alias Database =
    Dict Name User


databaseFromJsonString : JsonString -> Result Error Database
databaseFromJsonString payload =
    databaseDecoder payload


get : Database -> String -> Maybe JsonString -> JsonString
get database url maybePayload =
    Debug.todo "Please implement get"


post : Database -> String -> JsonString -> JsonString
post database url payload =
    Debug.todo "Please implement post"
