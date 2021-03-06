module Pages.CardsPage exposing (..)

import Color
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events
import Element.Input as Input
import Element.Keyed as Keyed
import Html
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Transition as Transition
import Updates


viewPage card =
    let
        originWidth =
            580
    in
    Element.layout stylesheet <|
        column None
            []
            [ el None [ center, width (px originWidth) ] <|
                column None
                    [ spacing 10 ]
                    [ viewHeader
                    , viewCard card
                    , viewRebloom
                    , viewDebug
                    ]
            ]


viewHeader =
    row None
        [ height (px 50)
        , paddingXY 3 1
        , alignBottom
        ]
        [ el LumoHeader [] (text "lumogarden : cards") ]


viewCard card =
    row LumoBlock [ minHeight (px 580), padding 20 ] [ viewCardSteps card ]



--viewGrid originWidth model =
--    let
--        padAmt =
--            originWidth / 62
--        spaceAmt =
--            2 * padAmt
--        colW =
--            (originWidth - (2 * spaceAmt)) / 3
--        rowH =
--            colW * 1.2
--    in
--    grid None
--        [ spacing 20 ]
--        { columns =
--            [ px colW
--            , px colW
--            , px colW
--            ]
--        , rows =
--            [ px rowH
--            , px rowH
--            , px rowH
--            ]
--        , cells =
--            [ -- TOP ROW --
--              viewLumoBlock ( 0, 0 ) model.cardsForJars.aa
--            , viewLumoBlock ( 1, 0 ) model.cardsForJars.bb
--            , viewLumoBlock ( 2, 0 ) model.cardsForJars.cc
--            -- MIDDLE ROW --
--            , viewLumoBlock ( 0, 1 ) model.cardsForJars.dd
--            , viewLumoBlockCenter ( 1, 1 )
--            , viewLumoBlock ( 2, 1 ) model.cardsForJars.ff
--            -- BOTTOM ROM --
--            , viewLumoBlock ( 0, 2 ) model.cardsForJars.gg
--            , viewLumoBlock ( 1, 2 ) model.cardsForJars.hh
--            , viewLumoBlock ( 2, 2 ) model.cardsForJars.ii
--            ]
--        }
--viewLumoBlock coordinates card =
--    let
--        ( x, y ) =
--            coordinates
--    in
--    cell
--        { start = ( x, y )
--        , width = 1
--        , height = 1
--        , content =
--            column LumoBlock
--                []
--                [ row LumoBlockHeader [ height (px 40), center, alignBottom ] [ el None [] (text "...") ]
--                , viewCardSteps card
--                ]
--        }
--viewLumoBlockCenter coordinates =
--    let
--        ( x, y ) =
--            coordinates
--    in
--    cell
--        { start = ( x, y )
--        , width = 1
--        , height = 1
--        , content =
--            column LumoBlock
--                [ spacing 10, paddingXY 30 20, verticalCenter ]
--                [ row LumoBlockHeaderCenter [ height (px 25), verticalCenter ] [ viewRebloom ]
--                , row LumoBlockHeaderCenter [ height (px 25) ] []
--                , row LumoBlockHeaderCenter [ height (px 25) ] []
--                , row LumoBlockHeaderCenter [ height (px 25) ] []
--                ]
--        }


viewCardSteps card =
    let
        viewCheckbox step =
            ( toString step.id
            , row None
                []
                [ el None [ width (percent 80) ] (text step.description)
                , Input.checkbox None
                    [ alignRight, Element.Events.onClick (Updates.ToggleComplete step.id) ]
                    { onChange = Updates.Check
                    , checked = step.completed
                    , label = el None [] (text "")
                    , options = []
                    }
                ]
            )
    in
    Keyed.column None
        [ width fill, padding 10, spacing 20 ]
    <|
        List.map viewCheckbox card.steps


viewRebloom =
    el LumoActions [ width fill, Element.Events.onClick Updates.Rebloom ] (text "Rebloom")


viewDebug =
    row Debug [ height (px 30), center, verticalCenter ] [ el None [] (text "...") ]



-- STYLES


type MyStyles
    = None
    | Debug
    | BlocksContainer
    | Title
    | LumoHeader
    | LumoBlock
    | LumoBlockHeader
    | LumoBlockHeaderCenter
    | LumoActions


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
        , Style.style Debug
            [ Color.background Color.darkCharcoal
            , Color.text Color.white
            , Border.rounded 6
            , Font.typeface header
            , Font.size 10
            ]
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
            [ Color.text Color.charcoal
            , Border.all 1
            , Border.solid
            , Border.rounded 6
            , Font.typeface header
            , Font.size 20
            , Font.letterSpacing 1.5
            ]
        , Style.style LumoActions
            [ Font.size 14
            , Font.center
            ]
        ]


header =
    [ Font.font "raleway"
    , Font.font "helvetica"
    ]
