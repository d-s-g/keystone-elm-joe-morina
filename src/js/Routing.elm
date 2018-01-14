module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (Route(..))
import UrlParser exposing (..)

homePath = 
    "/"

contactPath =
    "/contact"

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute top 
        , map ContactRoute (s "contact")
        ]

parseLocation : Location -> Route
parseLocation location = 
    case (parsePath matchers location) of
        Just route ->
            route
        
        Nothing ->
            NotFoundRoute