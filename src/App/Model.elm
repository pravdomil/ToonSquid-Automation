module App.Model exposing (..)

import Time


type alias Model =
    { time : Time.Posix
    , name : String
    , script : String
    }
