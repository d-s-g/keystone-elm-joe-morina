module Contact.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Posts.List exposing (viewHero)

view : Html Msg
view = 
    section [] 
        [ viewHero
        , div [class "post"] [text "Contact me at EMAILHERE"]
        ]