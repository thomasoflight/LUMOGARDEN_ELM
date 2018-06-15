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
    | BlockHeader
    | Block


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
        , Style.style Block
            [ Color.text Color.black
            , Color.background Color.white
            , Color.border Color.darkGrey
            , Border.all 2
            , Border.solid
            , Border.rounded 6
            , Font.typeface header
            , Font.size 16
            , Font.uppercase
            , Font.center
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
                    , viewGrid originWidth
                    ]
            ]


viewHeader =
    row None
        [ height (px 50)
        , paddingXY 3 1
        , alignBottom
        ]
        [ el LumoHeader [] (text "lumogarden") ]


viewGrid originWidth =
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
              cell
                { start = ( 0, 0 )
                , width = 1
                , height = 1
                , content = el Block [] (text "box")
                }
            , cell
                { start = ( 1, 0 )
                , width = 1
                , height = 1
                , content = el Block [] (text "box")
                }
            , cell
                { start = ( 2, 0 )
                , width = 1
                , height = 1
                , content = el Block [] (text "box")
                }

            -- MIDDLE ROW --
            , cell
                { start = ( 0, 1 )
                , width = 1
                , height = 1
                , content = el Block [] (text "box")
                }
            , cell
                { start = ( 1, 1 )
                , width = 1
                , height = 1
                , content = el Block [] (text "box")
                }
            , cell
                { start = ( 2, 1 )
                , width = 1
                , height = 1
                , content = el Block [] (text "box")
                }

            -- BOTTOM ROM --
            , cell
                { start = ( 0, 2 )
                , width = 1
                , height = 1
                , content = el Block [] (text "box")
                }
            , cell
                { start = ( 1, 2 )
                , width = 1
                , height = 1
                , content = el Block [] (text "box")
                }
            , cell
                { start = ( 2, 2 )
                , width = 1
                , height = 1
                , content = el Block [] (text "box")
                }
            ]
        }


main =
    view
