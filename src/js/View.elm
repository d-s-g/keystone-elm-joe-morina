module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class)
import Html.Events exposing (onWithOptions)
import Json.Decode as Decode
import Msgs exposing (Msg)
import Models exposing (Model, PostSlug)
import Routing exposing (homePath, contactPath, postSinglePath)
import Posts.List exposing (viewPosts)
import Posts.Single exposing (postSinglePage)
import Contact.View

onLinkClick : msg -> Attribute msg
onLinkClick message = 
    let 
        options = 
            { stopPropagation = False
            , preventDefault = True
            } 
    in
        onWithOptions "click" options (Decode.succeed message)

nav : Model -> Html Msg
nav model =
    div [class "menu-header"]
            [ ul [class "menu-header-inner"]
                [ li [class "menu-header__item"] [ a [ (class "menu-header__link"), href homePath, onLinkClick (Msgs.ChangeLocation homePath) ] [ text "Home" ] ]
                , li [class "menu-header__item"] [ a [ (class "menu-header__link"), href contactPath, onLinkClick (Msgs.ChangeLocation contactPath) ] [ text "Contact" ] ]
                ]
            ]

viewHeader : Model -> Html Msg
viewHeader model =
    header [] [ nav model ]
        
viewFooter : Model -> Html Msg
viewFooter model =
    footer [] [ nav model ]

page : Model -> Html Msg
page model =
    case model.route of
        Models.HomeRoute ->
            Posts.List.viewPosts model.posts

        Models.PostSingleRoute slug ->
            Posts.Single.postSinglePage model slug

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
        , viewFooter model
        ]
