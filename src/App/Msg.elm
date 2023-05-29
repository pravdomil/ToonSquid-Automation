module App.Msg exposing (..)

import Time


type Msg
    = NothingHappened
    | TimeReceived Time.Posix
    | ScriptChanged String
    | GenerateRequested
