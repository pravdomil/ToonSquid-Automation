module App.Model.Utils exposing (..)

import App.Model
import App.Script
import Random
import Time
import ToonSquid.Animation
import ToonSquid.Layer
import ToonSquid.Project
import UUID


modelToProject : App.Model.Model -> ToonSquid.Project.Project
modelToProject model =
    let
        script : App.Script.Script
        script =
            App.Script.fromString model.script

        projectId : String
        projectId =
            UUID.toString (Random.step UUID.generator (Random.initialSeed (Time.posixToMillis model.time)) |> Tuple.first)

        animationId : String
        animationId =
            UUID.toString (Random.step UUID.generator (Random.initialSeed (Time.posixToMillis model.time + 1)) |> Tuple.first)

        layerId : String
        layerId =
            UUID.toString (Random.step UUID.generator (Random.initialSeed (Time.posixToMillis model.time + 2)) |> Tuple.first)

        backgroundId : String
        backgroundId =
            UUID.toString (Random.step UUID.generator (Random.initialSeed (Time.posixToMillis model.time + 3)) |> Tuple.first)

        seed : Random.Seed
        seed =
            Random.initialSeed (Time.posixToMillis model.time + 4)

        animation : ToonSquid.Animation.Animation
        animation =
            ToonSquid.Animation.Animation
                animationId
                "Automation"
                width
                height
                fps
                [ ToonSquid.Layer.SimpleLayer_
                    (ToonSquid.Layer.SimpleLayer layerId "Layer 1" (scriptToDrawings seed script))
                , ToonSquid.Layer.Background_
                    (ToonSquid.Layer.Background backgroundId "Background")
                ]
    in
    ToonSquid.Project.Project
        projectId
        "Automation"
        width
        height
        fps
        [ animation
        ]



--


width =
    3840


height =
    2160


fps =
    24
