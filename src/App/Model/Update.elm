module App.Model.Update exposing (..)

import App.Model
import App.Model.Utils
import App.Msg
import File.Download
import Json.Decode
import Platform.Extra
import ToonSquid.Project


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

        App.Msg.ScriptChanged b ->
            \x -> ( { x | script = b }, Cmd.none )

        App.Msg.GenerateRequested ->
            \x -> ( x, File.Download.bytes "Project.tsproj" "application/zip" (ToonSquid.Project.toBytes (App.Model.Utils.modelToProject x)) )



--


subscriptions : App.Model.Model -> Sub App.Msg.Msg
subscriptions _ =
    Sub.none
