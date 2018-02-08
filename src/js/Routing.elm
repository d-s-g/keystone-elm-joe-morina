module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PostSlug, Route(..))
import UrlParser exposing (..)

homePath : String
homePath = 
    "/"

postSinglePath : PostSlug -> String 
postSinglePath id =
    "/post/" ++ id
    
contactPath : String
contactPath =
    "/contact"


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute top 
        , map PostSingleRoute (s "post" </> string)
        , map ContactRoute (s "contact")
        ]

parseLocation : Location -> Route
parseLocation location = 
    case (parsePath matchers location) of
        Just route ->
            route
        
        Nothing ->
            NotFoundRoute