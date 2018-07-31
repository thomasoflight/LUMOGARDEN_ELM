module Jars exposing (..)

import Color
import Element exposing (..)
import Element.Attributes exposing (..)
import Html
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Transition as Transition


type alias Model =
    { cardA : Card
    , cardB : Card
    }


type alias Step =
    { description : String
    , completed : Bool
    , id : Int
    }


type alias Card =
    { title : String
    , steps : List Step
    , flaggedForComplete : List Int
    }


type Msg
    = NoOp
    | Check Bool
    | ToggleComplete CardPosition Int
    | Rebloom


type CardPosition
    = TopL
    | TopC
    | TopR
    | MidL
    | MidR
    | BtmL
    | BtmC
    | BtmR


type MyStyles
    = None
    | DebugFill
    | BlocksContainer
    | Title
    | LumoHeader
    | LumoBlock
    | LumoBlockHeader
    | LumoBlockHeaderCenter


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
            [ Color.text Color.charcoal
            , Border.all 1
            , Border.solid
            , Border.rounded 6
            , Font.typeface header
            , Font.size 20
            , Font.letterSpacing 1.5
            ]
        ]


header =
    [ Font.font "raleway"
    , Font.font "helvetica"
    ]



-- MODEL


someSteps =
    [ Step "A" True 1
    , Step "B" False 2
    , Step "C" False 3
    , Step "D" False 4
    , Step "E" False 5
    , Step "..." False 6
    , Step "..." False 7
    , Step "..." False 8
    , Step "..." False 9
    ]


moreSteps =
    [ Step "C" False 10
    , Step "D" False 11
    ]


cardA =
    Card "A" someSteps []


cardB =
    Card "B" moreSteps []


init =
    Model cardA cardB ! []



-- UPDATE


update msg model =
    case msg of
        NoOp ->
            model ! []

        Check bool ->
            model ! []

        ToggleComplete cardPosition id ->
            model ! []

        Rebloom ->
            model ! []



-- VIEW


view model =
    let
        originWidth =
            620
    in
    Element.layout stylesheet <|
        column None
            []
            [ el None [ center, width (px originWidth) ] <|
                column None
                    []
                    [ viewHeader
                    , viewBlocks model originWidth
                    ]
            ]


viewHeader =
    row None
        [ height (px 50)
        , paddingXY 3 1
        , alignBottom
        ]
        [ el LumoHeader [] (text "lumogarden") ]


viewBlocks model originWidth =
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
              viewLumoBlock ( 0, 0 ) (toString model.cardA.title)
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
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
