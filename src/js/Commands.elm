module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)
import Msgs exposing (Msg)
import Models exposing (PostId, Post, Content, CloudImage)
import RemoteData

fetchPosts : Cmd Msg
fetchPosts =
    Decode.field "posts" postsDecoder
    |> Http.get fetchPostsUrl
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchPosts

fetchPostsUrl : String
fetchPostsUrl = "http://localhost:8888/api/post/list"

postsDecoder : Decode.Decoder (List Post) 
postsDecoder =
    Decode.list postDecoder

postDecoder : Decode.Decoder Post
postDecoder = 
    decode Post
        |> required "_id" Decode.string
        |> required "slug" Decode.string
        |> required "image" imageDecoder
        |> required "title" Decode.string
        |> required "publishedDate" Decode.string
        |> required "content" contentDecoder

contentDecoder : Decode.Decoder Content
contentDecoder =
    decode Content
        |> required "brief" Decode.string
        |> required "extended" Decode.string

imageDecoder : Decode.Decoder CloudImage
imageDecoder =
    decode CloudImage
        |> required "secure_url" Decode.string