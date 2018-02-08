module Posts.Svg exposing (..)

import Html exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Msgs exposing (..)

svgFilter : Html Msg
svgFilter = 
    svg []
    [ defs [] 
        [ linearGradient 
            [id "test", x1 "60%", y1 "0%", x2 "100%", y2 "0%"]
            [ stop [ offset "0%", stopColor "#000000", stopOpacity "0.4" ] []
            , stop [ offset "100%", stopColor "#00000", stopOpacity "0" ] [] 
            ] 
        ]
    , rect [ x "0", y "0", width "100", height "100"
        , Svg.Attributes.style "fill:url(#test);"
        ] []
    ]