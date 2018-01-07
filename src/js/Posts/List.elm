module Posts.List exposing (..)

import Html exposing (..)
import Msgs exposing (Msg)
import Models exposing (Post)

viewPosts : List Post -> Html Msg
viewPosts posts = 
    list posts 

list : List Post -> Html Msg
list posts =
    div []
        [ div [] (List.map postRow posts)]  

postRow : Post -> Html Msg
postRow post =
    text post.title