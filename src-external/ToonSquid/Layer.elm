module ToonSquid.Layer exposing (..)

import Json.Encode


type Layer
    = SimpleLayer_ SimpleLayer
    | Text_ Text
    | Background_ Background


id : Layer -> String
id a =
    case a of
        SimpleLayer_ b ->
            b.id

        Text_ b ->
            b.id

        Background_ b ->
            b.id


toJson : Layer -> String
toJson a =
    case a of
        SimpleLayer_ b ->
            simpleLayerToJson b

        Text_ b ->
            textToJson b

        Background_ b ->
            backgroundToJson b



--


type alias SimpleLayer =
    { id : String
    , name : String
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
    "dr": [],
    "DI": null
  }
}
"""



--


type alias Text =
    { id : String
    }


textToJson : Text -> String
textToJson _ =
    """
    {}
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
