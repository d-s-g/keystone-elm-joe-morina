module Msgs exposing (..)

import Models exposing (Post)
import RemoteData exposing (WebData)

type Msg
    = OnFetchPosts (WebData (List Post))