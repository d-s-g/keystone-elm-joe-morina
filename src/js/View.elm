module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href)
import Html.Events exposing (onWithOptions)
import Json.Decode as Decode
import Msgs exposing (Msg)
import Models exposing (Model)
import Posts.List exposing (viewPosts)
import Contact.View
import Routing exposing (homePath, contactPath)

onLinkClick : msg -> Attribute msg
onLinkClick message = 
    let 
        options = 
            { stopPropagation = False
            , preventDefault = True
            } 
    in
        onWithOptions "click" options (Decode.succeed message)


viewHeader : Model -> Html Msg
viewHeader model =
    header []
        [ div []
            [ ul []
                [ li [] [ a [ href homePath, onLinkClick (Msgs.ChangeLocation homePath) ] [ text "Home" ] ]
                , li [] [  a [ href contactPath, onLinkClick (Msgs.ChangeLocation contactPath) ] [ text "Contact" ] ]
                ]
            ]
        ]

viewFooter : Html Msg
viewFooter =
    footer []
        [ text "contact" ]

page : Model -> Html Msg
page model =
    case model.route of
        Models.HomeRoute ->
            Posts.List.viewPosts model.posts

        Models.ContactRoute ->
            Contact.View.view

        Models.NotFoundRoute -> 
            notFoundView


notFoundView : Html msg 
notFoundView =
    div []
        [ text "Not Found"
        ]


view : Model -> Html Msg
view model = 
    div []
        [ viewHeader model
        , page model
        , viewFooter
        ]
