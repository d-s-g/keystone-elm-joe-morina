module Msgs exposing (..)

import Models exposing (Post)
import Navigation exposing (Location)
import RemoteData exposing (WebData)

type Msg
    = OnFetchPosts (WebData (List Post))
    | ChangeLocation String
    | OnLocationChange Location
    | ImageLoaded