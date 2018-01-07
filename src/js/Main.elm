module Main exposing (main)

import Html
import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Update exposing (update)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


subscriptions model =
    Sub.none

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
