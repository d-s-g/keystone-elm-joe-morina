module View exposing (..)

import Html exposing (..)
import Msgs exposing (Msg)
import Models exposing (Model)
import Posts.List exposing (viewPosts)

viewHeader : Html Msg
viewHeader =
    header []
        [ div []
            [ ul []
                [ li [] [ text "Joe Morina" ]
                , li [] [ text "work" ]
                , li [] [ text "contact" ]
                ]
            ]
        ]

viewFooter : Html Msg
viewFooter =
    footer []
        [ text "contact" ]

view : Model -> Html Msg
view model = 
    div []
        [ viewHeader
        , viewPosts model.posts
        , viewFooter
        ]