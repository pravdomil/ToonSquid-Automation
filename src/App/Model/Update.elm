module App.Model.Update exposing (..)

import App.Model
import App.Msg
import Bytes.Encode
import File.Download
import Json.Decode
import Platform.Extra
import Time
import Zip
import Zip.Entry


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
            \x -> ( x, generate x.script )


generate : String -> Cmd msg
generate a =
    let
        basePath : String
        basePath =
            "DAEBDB18-07DF-46CD-A696-2272B174ABAE/"
    in
    Zip.fromEntries
        [ Zip.Entry.store
            (Zip.Entry.Meta
                (basePath ++ "data")
                ( Time.customZone 0 [], Time.millisToPosix 1685220000 )
                Nothing
            )
            (Bytes.Encode.encode (Bytes.Encode.string a))
        ]
        |> Zip.toBytes
        |> File.Download.bytes "Project.tsproj" "application/zip"



--


subscriptions : App.Model.Model -> Sub App.Msg.Msg
subscriptions _ =
    Sub.none
