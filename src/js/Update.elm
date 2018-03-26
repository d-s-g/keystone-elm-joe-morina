module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model)
import Routing exposing (parseLocation)
import Navigation exposing (newUrl)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchPosts response ->
            ( { model | posts = response }, Cmd.none )
        
        Msgs.ChangeLocation path ->
            ( { model | changes = model.changes + 1}, newUrl path )

        Msgs.OnLocationChange location ->
            let
                newRoute = 
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )
        Msgs.ImageLoaded ->
            ( { model | info = "Image loaded successfully!" }, Cmd.none )