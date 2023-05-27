module App.Model.Update exposing (..)

import App.Model
import App.Msg
import Json.Decode
import Platform.Extra


init : Json.Decode.Value -> ( App.Model.Model, Cmd App.Msg.Msg )
init _ =
    ( App.Model.Model "786 Hello\n983 Word"
    , Cmd.none
    )



--


update : App.Msg.Msg -> App.Model.Model -> ( App.Model.Model, Cmd App.Msg.Msg )
update msg =
    case msg of
        App.Msg.NothingHappened ->
            Platform.Extra.noOperation

        App.Msg.GenerateRequested ->
            Platform.Extra.noOperation



--


subscriptions : App.Model.Model -> Sub App.Msg.Msg
subscriptions _ =
    Sub.none
