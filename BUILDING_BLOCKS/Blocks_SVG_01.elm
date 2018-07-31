module Main exposing (..)

import Array
import Html exposing (Html, program)
import String
import Svg exposing (circle, rect, svg)
import Svg.Attributes exposing (..)


toPercent : Float -> String
toPercent num =
    let
        stringNum =
            toString num
    in
    stringNum ++ "%"


main =
    view


view =
    let
        total =
            100

        cardWidth =
            50

        cardHeight =
            80

        marginHoriz =
            (total - cardWidth) / 2

        marginTop =
            10
    in
    svg [ x "0", y "0", width "100%", height "100%" ]
        [ rect
            [ x (toPercent marginHoriz)
            , y (toPercent marginTop)
            , width (toPercent cardWidth)
            , height (toPercent cardHeight)
            ]
            []
        ]
