module App.Main exposing (..)

import App.Model
import App.Model.Update
import App.Model.View
import App.Msg
import Browser
import Json.Decode


main : Program Json.Decode.Value App.Model.Model App.Msg.Msg
main =
    Browser.document
        { init = App.Model.Update.init
        , update = App.Model.Update.update
        , subscriptions = App.Model.Update.subscriptions
        , view = App.Model.View.view
        }
