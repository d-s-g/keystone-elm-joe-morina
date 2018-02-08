module Posts.List exposing (..)

import Html exposing (..)
import Posts.Svg exposing (..)
import Date.Extra as Date
import Html.Attributes exposing (href, class, property, style)
import Routing exposing (postSinglePath)
import Html.Events exposing (onWithOptions)
import Json.Decode as Decode
import Json.Encode exposing (string)
import Msgs exposing (Msg)
import Models exposing (Model, Post)
import RemoteData exposing (WebData)


viewPosts : WebData (List Post) -> Html Msg
viewPosts posts = 
    maybeList posts


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

cloudnaryHelper : String -> String -> String
cloudnaryHelper cloudnaryUrl options =
   let
       start = List.take 6 (String.split "/" cloudnaryUrl)
       end = List.drop 6 (String.split "/" cloudnaryUrl)
   in
     String.join "/" (start ++ [options] ++ end)

dateHelper : String -> String
dateHelper date =
    case Date.fromIsoString date of
        Nothing -> 
            ""
        Just date ->
            Date.toFormattedString "MMMM d, y" date

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
    [ div [class ("card") ]
        [ div [class "card-inner", style [ ("background-image", "url("++cloudnaryHelper post.image.secure_url "w_1440,f_auto"++")" ) ] ] 
            [ div [class "card__snippit"] 
                [ h1 [class "card__title"] [ text post.title ]
                , div [class "card__border"] []
                , div [class "card__date"] [ text (dateHelper post.publishedDate) ]
                , div [(class "card__brief"), (Html.Attributes.property "innerHTML" (Json.Encode.string post.content.brief)) ] []
                , postSingleLink post.slug
                ]
            , div [(class "card__content"), (Html.Attributes.property "innerHTML" (Json.Encode.string post.content.extended))] []
            ]
        ]
    ]

postSingleLink : String -> Html.Html Msg
postSingleLink postslug =
    let
        path =
            postSinglePath postslug
    in
        a [ class "readmore" , href path][ text "Read More" ]