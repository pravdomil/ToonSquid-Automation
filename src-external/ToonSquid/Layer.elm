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
    , layers : List DrawingLayer
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
  "ly": [""" ++ String.join "," (List.map (\x -> Json.Encode.encode 0 (Json.Encode.string (drawingLayerId x))) a.layers) ++ """],
  "s": 1
}
"""



--


type DrawingLayer
    = Text_ Text


drawingLayerId : DrawingLayer -> String
drawingLayerId a =
    case a of
        Text_ b ->
            b.id


drawingLayerToJson : Drawing -> DrawingLayer -> String
drawingLayerToJson drawing a =
    case a of
        Text_ b ->
            textToJson drawing b



--


type alias Text =
    { id : String
    , name : String
    , text : String
    }


textToJson : Drawing -> Text -> String
textToJson drawing a =
    """
{
  "v": 1,
  "t": 2,
  "l": {
    "v": 3,
    "Id": """ ++ Json.Encode.encode 0 (Json.Encode.string a.id) ++ """,
    "Na": """ ++ Json.Encode.encode 0 (Json.Encode.string a.name) ++ """,
    "t": """ ++ Json.Encode.encode 0 (Json.Encode.string a.text) ++ """,
    "DI": """ ++ Json.Encode.encode 0 (Json.Encode.string drawing.id) ++ """,
    "op": { "v": 1, "k": [{ "vl": 1, "e": { "md": 2, "tp": 0 }, "v": 1, "f": 0 }] },
    "V": 3,
    "li": { "v": 1, "k": [{ "vl": 1, "e": { "md": 2, "tp": 0 }, "v": 1, "f": 0 }] },
    "eT": { "v": 1, "k": [{ "vl": 1, "e": { "md": 2, "tp": 0 }, "v": 1, "f": 0 }] },
    "bM": 0,
    "sW": { "v": 1, "k": [{ "vl": 0, "e": { "md": 2, "tp": 0 }, "v": 1, "f": 0 }] },
    "lBM": 0,
    "fS": { "v": 1, "k": [{ "vl": 100, "e": { "md": 2, "tp": 0 }, "v": 1, "f": 0 }] },
    "tf": {
      "sX": { "v": 1, "k": [{ "vl": 1, "e": { "md": 2, "tp": 0 }, "v": 1, "f": 0 }] },
      "pi": [164.0380859375, 60],
      "sY": { "v": 1, "k": [{ "vl": 1, "e": { "md": 2, "tp": 0 }, "v": 1, "f": 0 }] },
      "pX": {
        "v": 1,
        "k": [
          {
            "vl": { "i": 0, "vl": 1864.5462646484375, "v": 1, "o": 0 },
            "e": { "md": 2, "tp": 0 },
            "v": 1,
            "f": 0
          }
        ]
      },
      "r": { "v": 1, "k": [{ "vl": 0, "e": { "md": 2, "tp": 0 }, "v": 1, "f": 0 }] },
      "v": 1,
      "aU": true,
      "pY": {
        "v": 1,
        "k": [
          {
            "vl": { "i": 0, "vl": 909.42254638671875, "v": 1, "o": 0 },
            "e": { "md": 2, "tp": 0 },
            "v": 1,
            "f": 0
          }
        ]
      }
    },
    "lBW": 0,
    "wg": 400,
    "le": { "v": 1, "k": [{ "vl": 0, "e": { "md": 2, "tp": 0 }, "v": 1, "f": 0 }] },
    "LD": "2023-05-28T17:50:08Z",
    "al": 0,
    "co": {
      "v": 1,
      "k": [
        { "vl": { "r": 0, "b": 0, "g": 0, "a": 1 }, "e": { "md": 2, "tp": 0 }, "v": 1, "f": 0 }
      ]
    },
    "ty": "Helvetica",
    "st": 0,
    "sC": {
      "v": 1,
      "k": [
        { "vl": { "r": 0, "b": 0, "g": 0, "a": 1 }, "e": { "md": 2, "tp": 0 }, "v": 1, "f": 0 }
      ]
    }
  }
}
"""
