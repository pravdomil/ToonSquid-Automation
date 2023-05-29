module App.Msg exposing (..)

import Time


type Msg
    = NothingHappened
    | TimeReceived Time.Posix
    | NameChanged String
    | ScriptChanged String
    | GenerateRequested
