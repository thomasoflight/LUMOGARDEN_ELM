module Main exposing (..)

import Color
import Element exposing (..)
import Element.Attributes exposing (..)
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Transition as Transition


type MyStyles
    = None
    | DebugFill
    | Title
    | Box


stylesheet =
    Style.styleSheet
        [ Style.style None []
        , Style.style Title
            [ Color.text Color.white
            , Color.background Color.black
            , Font.size 22 -- all units given as px
            ]
        , Style.style Box
            [ Color.text Color.black
            , Color.background Color.white
            , Color.border Color.darkGrey
            , Border.all 2
            , Border.solid
            , Border.rounded 6
            ]
        , Style.style DebugFill
            [ Color.background Color.lightGrey ]
        ]



-- Element.layout renders the elements as html
-- Every layout requires a stylesheet.


view =
    let
        originWidth =
            620
    in
    Element.layout stylesheet <|
        -- An el is the most basic element, like a <div>
        column None
            []
            [ el None [ center, width (px originWidth) ] <|
                column None
                    []
                    [ viewHeader
                    , viewCardThreeRows originWidth
                    , viewCardThreeRows originWidth
                    , viewCardThreeRows originWidth
                    ]
            ]


viewHeader =
    row None
        [ height (px 42)
        , paddingLeft 3
        , alignBottom
        ]
        [ el None [] (text "lumogarden") ]


viewCardThreeRows originWidth =
    let
        padAmt =
            originWidth / 63

        spaceAmt =
            2 * padAmt

        --0
        xWidth =
            (originWidth - (2 * spaceAmt)) / 3

        yHeight =
            xWidth * 1.2
    in
    row None
        [ center
        , spacingXY spaceAmt spaceAmt
        , padding padAmt
        ]
        [ el Box
            [ width (px xWidth)
            , height (px yHeight)
            ]
            empty
        , el Box
            [ width (px xWidth)
            , height (px yHeight)
            ]
            empty
        , el Box
            [ width (px xWidth)
            , height (px yHeight)
            ]
            empty
        ]


main =
    view
