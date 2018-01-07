module Models exposing (..)

type alias Model = 
    { posts : List Post
    }

initialModel : Model
initialModel =
    { posts = [Post "15" "test" "test" 1 "today" "test"]
    }
    
type alias Content =
    { brief : String
    , extended : String
    }

type alias PostId = 
    String 

type alias Post =
    { id : PostId
    , title : String
    , slug : String
    , v : Int
    , publishedDate : String
    , content : String
    }