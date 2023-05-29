module App.Script exposing (..)

import Regex


type alias Script =
    { scenes : List Scene
    }


fromString : String -> Script
fromString a =
    Script
        (String.split "\n" a
            |> List.map stringToScene
        )



--


type alias Scene =
    { text : String
    , length : Maybe Float
    }


stringToScene : String -> Scene
stringToScene a =
    let
        regex : Regex.Regex
        regex =
            Regex.fromString "^([\\d]+ )?(.*)$"
                |> Maybe.withDefault Regex.never
    in
    Regex.find regex a
        |> List.head
        |> Maybe.andThen
            (\x ->
                case x.submatches of
                    length :: (Just text) :: _ ->
                        Just
                            (Scene
                                text
                                (length
                                    |> Maybe.andThen (\x2 -> String.toInt (String.dropRight 1 x2))
                                    |> Maybe.map (\x2 -> toFloat x2 / 100)
                                )
                            )

                    _ ->
                        Nothing
            )
        |> Maybe.withDefault (Scene a Nothing)
