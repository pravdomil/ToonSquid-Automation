module App.Model.View exposing (..)

import App.Model
import App.Msg
import App.Utils.Theme exposing (..)
import Browser
import Element.PravdomilUi exposing (..)


view : App.Model.Model -> Browser.Document App.Msg.Msg
view _ =
    { title = "ToonSquid Automation"
    , body =
        [ layout theme [] none
        ]
    }
