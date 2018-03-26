module Posts.Helpers exposing (..)

import Date.Extra as Date


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