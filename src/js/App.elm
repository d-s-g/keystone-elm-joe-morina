module App exposing (..)

import Html exposing (..)
import Http 
-- import RemoteData
-- import Json.Decode as Decode
-- import Json.Decode.Pipeline exposing (decode, required)


-- MODEL

-- type Posts
--     = OnFetchPosts (WebData (List Post))

    
init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


-- COMMANDS

-- getPostsUrl : String
-- getPostsUrl = 
--     "http://localhost:8888/api/post/list"

-- getPosts : Cmd Msg
-- getPosts =
--     Http.send PostResponse (Http.getString getPostsUrl)

-- VIEW

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

-- View posts needs to map over a post list and return results to dom
viewPosts : List Post -> Html Msg
viewPosts posts = 
    div []
        [ list posts ]

list : List Post -> Html Msg
list posts = (List.map getValues posts)

getValues : Post -> Html Msg
getValues post = 
    div [] [ text post.title] 

view : Model -> Html Msg
view model = 
    div []
        [ viewHeader
        , viewPosts model.posts
        , viewFooter
        ]

-- UPDATE

type Msg = PostResponse (Result Http.Error String)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PostResponse (Ok jsonString) -> 
            let
                _ = Debug.log "200" jsonString 
            in
                (model, Cmd.none)
        PostResponse (Err error) ->
            let
                _ = Debug.log "500" error
            in
                (model, Cmd.none)


-- DECODERS


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN
