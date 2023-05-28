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
  "re": { "w": 3840, "h": 2160 },
  "fr": 24,
  "lO":  """ ++ Json.Encode.encode 0 (Json.Encode.list (\x -> Json.Encode.string (ToonSquid.Element.id x)) (List.reverse a.elements)) ++ """,
  "ly": [""" ++ String.join "," (List.map ToonSquid.Element.toJson a.elements) ++ """],
  "tF": 1,
  "tH": { "v": 1, "r": [], "c": [] },
  "cL": null,
  "dr": [],
  "ma": [],
  "lMD": "2023-05-28T16:30:53Z",
  "cD": "2023-05-28T16:30:53Z"
}
"""
