module Main exposing (main)

import Routing
import Commands exposing (fetchPosts)
import Models exposing (Model, initialModel)
import Navigation exposing (Location)
import Msgs exposing (Msg)
import Update exposing (update)
import View exposing (view)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute = 
            Routing.parseLocation location
    in 
        ( initialModel currentRoute, fetchPosts )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
