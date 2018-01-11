module Posts.List exposing (..)

import Html exposing (..)
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
        [ div [] (List.map postRow posts)]  


postRow : Post -> Html Msg
postRow post =
    text post.title