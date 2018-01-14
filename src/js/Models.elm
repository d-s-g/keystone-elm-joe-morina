module Models exposing (..)

import RemoteData exposing (WebData)

initialModel : Route -> Model
initialModel route =
    { posts = RemoteData.Loading
    , route = route
    , changes = 0
    }

type alias Model = 
    { posts : WebData (List Post)
    , route : Route
    , changes : Int
    }

    
type alias Content =
    { brief : String
    , extended : String
    }

type alias PostId = 
    String 

type alias Post =
    { id : PostId
    , slug : String
    , title : String
    , publishedDate : String
    , content : Content
    }

type Route
    = HomeRoute
    | ContactRoute
    | NotFoundRoute