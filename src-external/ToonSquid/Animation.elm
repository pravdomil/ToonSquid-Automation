module ToonSquid.Animation exposing (..)

import Json.Encode
import ToonSquid.Layer


type alias Animation =
    { id : String
    , name : String
    , width : Int
    , height : Int
    , fps : Int
    , layers : List ToonSquid.Layer.Layer
    }


toJson : Animation -> String
toJson a =
    let
        layers : List String
        layers =
            List.map ToonSquid.Layer.toJson a.layers
                ++ List.concatMap
                    (\x ->
                        List.concatMap
                            (\x3 ->
                                List.map (ToonSquid.Layer.drawingLayerToJson x3) x3.layers
                            )
                            (ToonSquid.Layer.drawings x)
                    )
                    a.layers
    in
    """
{
  "v": 5,
  "id": """ ++ Json.Encode.encode 0 (Json.Encode.string a.id) ++ """,
  "na": """ ++ Json.Encode.encode 0 (Json.Encode.string a.name) ++ """,
  "re": """ ++ Json.Encode.encode 0 (Json.Encode.object [ ( "w", Json.Encode.int a.width ), ( "h", Json.Encode.int a.height ) ]) ++ """,
  "fr": """ ++ Json.Encode.encode 0 (Json.Encode.int a.fps) ++ """,
  "lO": """ ++ Json.Encode.encode 0 (Json.Encode.list (\x -> Json.Encode.string (ToonSquid.Layer.id x)) (List.reverse a.layers)) ++ """,
  "ly": [""" ++ String.join "," layers ++ """],
  "tF": 1,
  "tH": { "v": 1, "r": [], "c": [] },
  "cL": null,
  "dr": [""" ++ String.join "," (List.concatMap (\x -> List.map (ToonSquid.Layer.drawingToJson x) (ToonSquid.Layer.drawings x)) a.layers) ++ """],
  "ma": [],
  "lMD": "2023-05-28T16:30:53Z",
  "cD": "2023-05-28T16:30:53Z"
}
"""
