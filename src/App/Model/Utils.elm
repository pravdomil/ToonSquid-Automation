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
                model.name
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
        model.name
        width
        height
        fps
        [ animation
        ]



--


scriptToDrawings : Random.Seed -> App.Script.Script -> List ToonSquid.Layer.Drawing
scriptToDrawings initialSeed a =
    let
        sceneToDrawing : Random.Seed -> Int -> App.Script.Scene -> ToonSquid.Layer.Drawing
        sceneToDrawing seed time b =
            let
                ( drawingId, textId ) =
                    Random.step (Random.map2 Tuple.pair UUID.generator UUID.generator) seed |> Tuple.first
            in
            ToonSquid.Layer.Drawing
                (UUID.toString drawingId)
                time
                (time + max 1 (round (Maybe.withDefault 1 b.length * fps)))
                [ ToonSquid.Layer.Text_
                    (ToonSquid.Layer.Text
                        (UUID.toString textId)
                        "Text"
                        b.text
                        48
                        (160 + 16)
                        (height + 48 + 32)
                    )
                ]
    in
    List.foldl
        (\x ( acc, time, seed ) ->
            let
                drawing : ToonSquid.Layer.Drawing
                drawing =
                    sceneToDrawing seed time x
            in
            ( drawing :: acc
            , drawing.end + 1
            , Random.step Random.independentSeed seed |> Tuple.first
            )
        )
        ( []
        , 1
        , initialSeed
        )
        a.scenes
        |> (\( x, _, _ ) -> x)
        |> List.reverse



--


width =
    3840


height =
    2160


fps =
    24
