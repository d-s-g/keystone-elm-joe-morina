module Posts.List exposing (..)

import Html exposing (..)
import Posts.Helpers exposing (cloudnaryHelper, dateHelper)
import Html.Attributes exposing (href, class, property, style)
import Routing exposing (postSinglePath)
import Html.Events exposing (onWithOptions, on)
import Html.Events.Extra exposing (onClickPreventDefault)
import Json.Decode as Decode
import Json.Encode exposing (string)
import Msgs exposing (Msg)
import Models exposing (Model, Post)
import RemoteData exposing (WebData)


viewHero : Html Msg
viewHero =
    section [ class "container card--first"]
        [ div [class "card card--hero"]
            [ div [class "card-inner background-image card-inner--hero", on "load" (Decode.succeed Msgs.ImageLoaded)]
                [ h1 [class "card__title--hero"] [text "Joe Morina"]
                , div [class "card__border--hero"] []
                , p [class "card__tagline--hero"] [text "Virginia Sea Grant graduate research fellow, and PhD student at VCU"]
                ]
            ]
        ]
        

viewPosts : WebData (List Post) -> Html Msg
viewPosts posts = 
    div [] 
        [ viewHero
        , maybeList posts 
        ]

maybeList : WebData (List Post) -> Html Msg
maybeList response =
    case response of 
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading -> 
            text "loading..."

        RemoteData.Success posts ->
            list posts
        
        RemoteData.Failure error ->
            text ("Error: " ++ toString error)


list : List Post -> Html Msg
list posts =
    div []
        [ div [] (List.map postRow posts) ]

onReadmoreClick : msg -> Attribute msg
onReadmoreClick message =
    let 
        options = 
            { stopPropagation = False
            , preventDefault = True
            } 
    in
        onWithOptions "click" options (Decode.succeed message)

postRow : Post -> Html Msg
postRow post =
    section [class "container"]
    [ div [class "card" ]
        [ div [class "card-inner", style [ ("background-image", "url("++cloudnaryHelper post.image.secure_url "w_1440,f_auto"++")" ) ] ] 
            [ div [class "card__snippit"] 
                [ h1 [class "card__title"] [ text post.title ]
                , div [class "card__border"] []
                , div [class "card__date"] [ text (dateHelper post.publishedDate) ]
                , div [(class "card__brief"), (Html.Attributes.property "innerHTML" (Json.Encode.string post.content.brief)) ] []
                , postSingleLink post.slug
                ]
            ]
        ]
    ]

postSingleLink : String -> Html.Html Msg
postSingleLink postslug =
    let
        path =
            postSinglePath postslug
    in
        a [ class "readmore", onClickPreventDefault (Msgs.ChangeLocation path), href path ][ text "Read More" ]