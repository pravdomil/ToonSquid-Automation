module App.Model.View exposing (..)

import App.Model
import App.Msg
import App.Utils.Theme exposing (..)
import Browser
import Element.Input
import Element.PravdomilUi exposing (..)
import Html


view : App.Model.Model -> Browser.Document App.Msg.Msg
view model =
    { title = "ToonSquid Automation"
    , body =
        [ layout theme [] (viewBody model)
        , Html.node "style" [] [ Html.text "body{background-color:rgb(31,36,38)}" ]
        ]
    }


viewBody : App.Model.Model -> Element App.Msg.Msg
viewBody model =
    column [ width (fill |> maximum 800), centerX, padding 16, spacing 16 ]
        [ row [ width fill ]
            [ heading1 theme
                []
                [ text "ToonSquid Automation"
                ]
            , el [ width fill ] none
            , button theme
                []
                { label = text "Generate"
                , active = True
                , onPress = Just App.Msg.GenerateRequested
                }
            ]
        , inputMultiline theme
            []
            { label = Element.Input.labelAbove [] (text "Script")
            , placeholder = Nothing
            , text = model.script
            , spellcheck = False
            , onChange = App.Msg.ScriptChanged
            }
        ]
