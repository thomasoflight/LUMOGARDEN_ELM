module Blocks exposing (..)

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
    | BlocksContainer
    | Title
    | LumoHeader
    | LumoBlock
    | LumoBlockHeader
    | LumoBlockHeaderCenter


header =
    [ Font.font "raleway"
    , Font.font "helvetica"
    ]


stylesheet =
    Style.styleSheet
        [ Style.style None []
        , Style.style Title
            [ Color.text Color.white
            , Color.background Color.black
            , Font.size 22 -- all units given as px
            ]
        , Style.style LumoBlock
            [ Color.text Color.black
            , Color.background Color.white
            , Color.border Color.darkCharcoal
            , Border.all 1
            , Border.solid
            , Border.rounded 6
            , Font.uppercase
            ]
        , Style.style DebugFill
            [ Color.background Color.lightGrey ]
        , Style.style BlocksContainer
            []
        , Style.style LumoHeader
            [ Font.typeface header
            , Font.size 24
            , Font.uppercase
            , Font.light
            ]
        , Style.style LumoBlockHeader
            [ Border.bottom 1
            , Border.solid
            , Color.border Color.darkCharcoal
            , Font.typeface header
            , Font.size 20
            , Font.letterSpacing 1.5
            ]
        , Style.style LumoBlockHeaderCenter
            [ Border.all 1
            , Border.solid
            , Border.rounded 4
            , Color.border Color.darkCharcoal

            --, Color.background Color.darkCharcoal
            , Color.text Color.charcoal
            , Font.typeface header
            , Font.size 20
            , Font.letterSpacing 1.5
            ]
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
                    , viewBlocks originWidth
                    ]
            ]


viewHeader =
    row None
        [ height (px 50)
        , paddingXY 3 1
        , alignBottom
        ]
        [ el LumoHeader [] (text "lumogarden") ]


viewBlocks originWidth =
    let
        padAmt =
            originWidth / 62

        spaceAmt =
            2 * padAmt

        colW =
            (originWidth - (2 * spaceAmt)) / 3

        rowH =
            colW * 1.2
    in
    grid None
        [ spacing 20, paddingTop 15 ]
        { columns = [ px colW, px colW, px colW ]
        , rows =
            [ px rowH
            , px rowH
            , px rowH
            ]
        , cells =
            [ -- TOP ROW --
              viewLumoBlock ( 0, 0 ) "a"
            , viewLumoBlock ( 1, 0 ) "b"
            , viewLumoBlock ( 2, 0 ) "c"

            -- MIDDLE ROW --
            , viewLumoBlock ( 0, 1 ) "d"
            , viewLumoBlockCenter ( 1, 1 ) "..."
            , viewLumoBlock ( 2, 1 ) "f"

            -- BOTTOM ROM --
            , viewLumoBlock ( 0, 2 ) "g"
            , viewLumoBlock ( 1, 2 ) "h"
            , viewLumoBlock ( 2, 2 ) "i"
            ]
        }


viewLumoBlock coordinates blockName =
    let
        ( x, y ) =
            coordinates
    in
    cell
        { start = ( x, y )
        , width = 1
        , height = 1
        , content =
            column LumoBlock
                []
                [ row LumoBlockHeader [ height (px 40), center, alignBottom ] [ el None [] (text blockName) ] ]
        }


viewLumoBlockCenter coordinates blockName =
    let
        ( x, y ) =
            coordinates
    in
    cell
        { start = ( x, y )
        , width = 1
        , height = 1
        , content =
            column LumoBlock
                [ spacing 10, paddingXY 30 20, verticalCenter ]
                [ row LumoBlockHeaderCenter [ height (px 25) ] []
                , row LumoBlockHeaderCenter [ height (px 25) ] []
                , row LumoBlockHeaderCenter [ height (px 25) ] []
                , row LumoBlockHeaderCenter [ height (px 25) ] []
                ]
        }


main =
    view
