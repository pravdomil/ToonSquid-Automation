module ToonSquid.Animation exposing (..)

import Json.Encode
import ToonSquid.Element


type alias Animation =
    { id : String
    , name : String
    , elements : List ToonSquid.Element.Element
    }


toJson : Animation -> String
toJson a =
    """
{
  "v": 5,
  "id": """ ++ Json.Encode.encode 0 (Json.Encode.string a.id) ++ """,
  "na": """ ++ Json.Encode.encode 0 (Json.Encode.string a.name) ++ """,
  "tF": 1,
  "re": { "w": 3840, "h": 2160 },
  "lO":  """ ++ Json.Encode.encode 0 (Json.Encode.list (\x -> Json.Encode.string (ToonSquid.Element.id x)) a.elements) ++ """,
  "ly": [
    {
      "v": 1,
      "t": 10,
      "l": {
        "V": 3,
        "Na": "Layer 1",
        "Id": "73296017-F838-4114-B2B4-1729329B3E7A",
        "LD": "2023-05-28T16:30:53Z",
        "dr": [],
        "v": 2,
        "DI": null
      }
    },
    {
      "v": 1,
      "t": 11,
      "l": {
        "if": false,
        "V": 3,
        "Na": "Background",
        "Id": "C01FE01D-1201-4312-BF86-F1A1386D66E2",
        "LD": "2023-05-28T16:30:53Z",
        "co": {
          "v": 1,
          "k": [{ "vl": { "r": 1, "g": 1, "b": 1 }, "e": { "md": 2, "tp": 0 }, "v": 1, "f": 0 }]
        },
        "v": 1,
        "DI": null,
        "iS": false
      }
    }
  ],
  "lMD": "2023-05-28T16:30:53Z",
  "fr": 24,
  "tH": { "v": 1, "r": [], "c": [] },
  "cL": null,
  "dr": [],
  "ma": [],
  "cD": "2023-05-28T16:30:53Z"
}
"""
