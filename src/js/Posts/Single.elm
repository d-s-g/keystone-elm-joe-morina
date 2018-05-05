module Posts.Single exposing (..)

import Html exposing (..)
import Posts.Svg exposing (..)
import Html.Attributes exposing (href, class, property, style)
import Models exposing (Model, Post, PostSlug)
import RemoteData exposing (..)
import Msgs exposing (Msg)
import Posts.Helpers exposing (cloudnaryHelper, dateHelper)
import Json.Encode exposing (string)


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
                        postSingleView post

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)

notFoundView : Html msg 
notFoundView =
    div []
        [ text "Not Found"
        ]
        
allData : Post -> Html Msg
allData post
    = pre []
    [ text post.image.secure_url
    , text post.title
    , text (dateHelper post.publishedDate)
    , text post.content.brief
    , text post.content.extended
    ]

postSingleHero : Post -> Html Msg
postSingleHero post =
    section [ class "container card--first"]
        [ div [class "card card--hero"]
            [ div [class "card-inner card-inner--hero", style [ ("background-image", "url("++cloudnaryHelper post.image.secure_url "w_1440,f_auto"++")" ) ] ]
             [ -- span []
                --     [ h1 [class "card__title--hero"] [text "Joe Morina"]
                --     , div [class "card__border--hero"] []
                --     , p [class "card__tagline--hero"] [text "blurb here"]
                --     ]
                ]
            ]
        ]


postSingle : Post -> Html Msg
postSingle post =
    section [class "post"]
    [ h1 [class "post__title"] [text post.title]
    , p [class "post__date"] [text (dateHelper post.publishedDate)]
    , div [(class "post__content"), (Html.Attributes.property "innerHTML" (Json.Encode.string post.content.extended))] []
    ]


postSingleView : Post -> Html Msg
postSingleView post =
    div [class "container"]
    [ postSingleHero post
    -- , allData post
    , postSingle post
    ]
