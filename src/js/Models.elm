module Models exposing (..)

import RemoteData exposing (WebData)

type alias Model = 
    { posts : WebData (List Post)
    }

initialModel : Model
initialModel =
    { posts = RemoteData.Loading 
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