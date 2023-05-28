module ToonSquid.Project exposing (..)

import Bytes
import Bytes.Encode
import Json.Encode
import Time
import ToonSquid.Animation
import Zip
import Zip.Entry


type alias Project =
    { id : String
    , name : String
    , animations : List ToonSquid.Animation.Animation
    }


toBytes : Project -> Bytes.Bytes
toBytes a =
    let
        lastModified : ( Time.Zone, Time.Posix )
        lastModified =
            ( Time.customZone 0 []
            , Time.millisToPosix 1685220000
            )

        files : List Zip.Entry.Entry
        files =
            [ Zip.Entry.store
                (Zip.Entry.Meta (a.id ++ "/data") lastModified Nothing)
                (Bytes.Encode.encode (Bytes.Encode.string (toJson a)))
            ]
                ++ List.map
                    (\x ->
                        Zip.Entry.store
                            (Zip.Entry.Meta (a.id ++ "/Animations/" ++ x.id ++ ".tsanim") lastModified Nothing)
                            (Bytes.Encode.encode (Bytes.Encode.string (ToonSquid.Animation.toJson x)))
                    )
                    a.animations
    in
    Zip.toBytes (Zip.fromEntries files)


toJson : Project -> String
toJson a =
    let
        encodeAnimation : ToonSquid.Animation.Animation -> Json.Encode.Value
        encodeAnimation b =
            Json.Encode.object
                [ ( "v", Json.Encode.int 1 )
                , ( "id", Json.Encode.string b.id )
                ]
    in
    """
{
  "v": 3,
  "id": """ ++ Json.Encode.encode 0 (Json.Encode.string a.id) ++ """,
  "na": """ ++ Json.Encode.encode 0 (Json.Encode.string a.name) ++ """,
  "re": { "w": 3840, "h": 2160 },
  "rs": {
    "tO": [],
    "dRI": [],
    "auD": [],
    "an": """ ++ Json.Encode.encode 0 (Json.Encode.list encodeAnimation a.animations) ++ """,
    "sT": [],
    "anD": [],
    "vi": [],
    "au": [],
    "txD": [],
    "viD": [],
    "tx": [],
    "v": 2
  },
  "oD": "2023-05-28T16:30:48Z",
  "cD": "2023-05-28T16:30:48Z",
  "tC": null,
  "fr": 24,
  "sc": [],
  "eS": {
    "mT": true,
    "pCS": [],
    "exS": null,
    "eP": [],
    "cF": 1,
    "sP": [],
    "cAG": [],
    "sC": null,
    "oS": {
      "o": 0,
      "t": 0,
      "bO": [0.58333331346511841, 0.46666666865348816, 0.34999999403953552, 0.23333333432674408, 0.11666666716337204],
      "aO": [0.58333331346511841, 0.46666666865348816, 0.34999999403953552, 0.23333333432674408, 0.11666666716337204],
      "m": 0,
      "v": 3,
      "bC": { "r": 0.8970000147819519, "g": 0.2630000114440918, "b": 0.1679999977350235 },
      "a": 5,
      "aC": { "r": 0.3529999852180481, "g": 0.76899999380111694, "b": 0.19200000166893005 },
      "b": 5
    },
    "sAL": null,
    "ssCL": [],
    "cCG": [],
    "ssAL": [],
    "sD": null,
    "ssAD": [],
    "sCL": null,
    "v": 5,
    "hP": []
  },
  "mO": 0
}
"""
