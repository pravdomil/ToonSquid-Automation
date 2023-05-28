module ToonSquid.Layer exposing (..)

import Json.Encode


type Layer
    = SimpleLayer_ SimpleLayer
    | Background_ Background


id : Layer -> String
id a =
    case a of
        SimpleLayer_ b ->
            b.id

        Background_ b ->
            b.id


drawings : Layer -> List Drawing
drawings a =
    case a of
        SimpleLayer_ b ->
            b.drawings

        Background_ _ ->
            []


toJson : Layer -> String
toJson a =
    case a of
        SimpleLayer_ b ->
            simpleLayerToJson b

        Background_ b ->
            backgroundToJson b



--


type alias SimpleLayer =
    { id : String
    , name : String
    , drawings : List Drawing
    }


simpleLayerToJson : SimpleLayer -> String
simpleLayerToJson a =
    """
{
  "v": 1,
  "t": 10,
  "l": {
    "v": 2,
    "Id": """ ++ Json.Encode.encode 0 (Json.Encode.string a.id) ++ """,
    "Na": """ ++ Json.Encode.encode 0 (Json.Encode.string a.name) ++ """,
    "V": 3,
    "LD": "2023-05-28T16:30:53Z",
    "dr": [""" ++ String.join "," (List.map (\x -> Json.Encode.encode 0 (Json.Encode.string x.id)) a.drawings) ++ """],
    "DI": null
  }
}
"""



--


type alias Background =
    { id : String
    , name : String
    }


backgroundToJson : Background -> String
backgroundToJson a =
    """
{
  "v": 1,
  "t": 11,
  "l": {
    "v": 1,
    "Id": """ ++ Json.Encode.encode 0 (Json.Encode.string a.id) ++ """,
    "Na": """ ++ Json.Encode.encode 0 (Json.Encode.string a.name) ++ """,
    "if": false,
    "V": 3,
    "LD": "2023-05-28T16:30:53Z",
    "co": {
      "v": 1,
      "k": [{ "vl": { "r": 1, "g": 1, "b": 1 }, "e": { "md": 2, "tp": 0 }, "v": 1, "f": 0 }]
    },
    "DI": null,
    "iS": false
  }
}
"""



--


type alias Drawing =
    { id : String
    , length : Int
    }


drawingToJson : Layer -> Drawing -> String
drawingToJson layer a =
    """
{
  "v": 3,
  "id": """ ++ Json.Encode.encode 0 (Json.Encode.string a.id) ++ """,
  "e": """ ++ Json.Encode.encode 0 (Json.Encode.int a.length) ++ """,
  "l": """ ++ Json.Encode.encode 0 (Json.Encode.string (id layer)) ++ """,
  "lMD": "2023-05-28T17:43:29Z",
  "ly": [],
  "s": 1
}
"""
