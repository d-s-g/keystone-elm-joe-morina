module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class)
import Html.Events exposing (onWithOptions)
import RemoteData exposing (..)
import Json.Decode as Decode
import Msgs exposing (Msg)
import Models exposing (Model, PostSlug)
import Routing exposing (homePath, contactPath, postSinglePath)
import Posts.List exposing (viewPosts)
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


viewHeader : Model -> Html Msg
viewHeader model =
    header []
        [ div [class "menu-header"]
            [ ul [class "menu-header-inner"]
                [ li [class "menu-header__item"] [ a [ (class "menu-header__link"), href homePath, onLinkClick (Msgs.ChangeLocation homePath) ] [ text "Home" ] ]
                , li [class "menu-header__item"] [ a [ (class "menu-header__link"), href contactPath, onLinkClick (Msgs.ChangeLocation contactPath) ] [ text "Contact" ] ]
                ]
            ]
        ]

viewHero : Html Msg
viewHero =
    section [ class "container card--first"]
        [ div [class "card card--hero"]
            [ div [class "card-inner background-image card-inner--hero"]
                [ h1 [class "card__title--hero"] [text "Joe Morina"]
                , div [class "card__border--hero"] []
                , p [class "card__tagline--hero"] [text "blurb here"]
                ]
            ]
        ]
        
viewFooter : Html Msg
viewFooter =
    footer []
        [ text "contact" ]

postSinglePage : Model -> PostSlug -> Html Msg
postSinglePage model postSlug =
    case model.posts of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success posts ->
            let
                maybePost =
                    posts
                        |> List.filter (\post -> post.slug == postSlug)
                        |> List.head
            in
                case maybePost of
                    Just post ->
                        div [] [text post.title]

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)

page : Model -> Html Msg
page model =
    case model.route of
        Models.HomeRoute ->
            Posts.List.viewPosts model.posts

        Models.PostSingleRoute slug ->
            postSinglePage model slug

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
        , viewHero
        , page model
        , viewFooter
        ]
