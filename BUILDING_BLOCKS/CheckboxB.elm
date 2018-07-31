module Main exposing (..)

import Color
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events
import Element.Input as Input
import Html
import Style exposing (..)
import Style.Background as Background
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Shadow as Shadow
import Style.Transition as Transition


(=>) =
    (,)


type Styles
    = None
    | BlueFill
    | GreenButton
    | GreyOutline
    | Debug


type alias Step =
    { description : String
    , completed : Bool
    , id : Int
    }


type alias Card =
    { title : String
    , steps : List Step
    }


type alias Model =
    { cardA : Card
    , cardB : Card
    , bool : Bool
    , int : Int
    }


stylesheet : StyleSheet Styles variation
stylesheet =
    Style.styleSheet
        [ style None []
        , style BlueFill
            [ Color.background Color.blue ]
        , style GreyOutline
            [ Border.all 1
            , Border.solid
            , Color.border Color.grey
            ]
        , style GreenButton
            [ Color.background Color.green
            , Font.center
            , Color.text Color.white
            ]
        , style Debug
            [ Color.text Color.lightCharcoal
            , Font.uppercase
            , Font.size 10
            ]
        ]


type Msg
    = NoOp
    | Check Bool
    | CheckInt Int
    | ToggleComplete Bool Int
    | Rebloom


update msg model =
    case msg of
        NoOp ->
            model ! []

        Check bool ->
            { model | bool = bool } ! []

        CheckInt int ->
            { model | int = int } ! []

        ToggleComplete bool id ->
            let
                updateStep s =
                    if s.id == id then
                        { s | completed = not bool }
                    else
                        s

                updateCard c =
                    { c | steps = List.map updateStep c.steps }
            in
            { model
                | cardA = updateCard model.cardA
                , cardB = updateCard model.cardB
            }
                ! []

        Rebloom ->
            --let
            --     =
            --in
            model ! []


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
    Card "A" someSteps


cardB =
    Card "B" moreSteps


init =
    Model cardA cardB True 0 ! []


view model =
    Element.layout stylesheet <|
        el None [ center, width (px 1000), height (px 1000) ] <|
            column GreyOutline
                [ height fill, width fill, padding 60, spacing 20 ]
                [ viewRebloom
                , row None
                    [ spacing 40 ]
                    [ viewCardSteps model.cardA
                    , viewCardSteps model.cardB
                    ]
                , viewDebug model.cardA
                , viewDebug model.cardB
                ]


viewRebloom =
    row None [ center ] [ el GreenButton [ width (px 100), height (px 25) ] (text "rebloom") ]


viewCardSteps card =
    let
        viewCheckbox step =
            row None
                []
                [ el None [ width (percent 80) ] (text step.description)
                , Input.checkbox None
                    [ Element.Events.onClick (ToggleComplete step.completed step.id) ]
                    { onChange = Check
                    , checked = step.completed
                    , label = el None [] (text "")
                    , options = []
                    }
                ]

        activeSteps =
            List.filter (\s -> not s.completed) card.steps
    in
    column None
        [ width (percent 50), spacing 20 ]
    <|
        List.map viewCheckbox activeSteps


viewDebug c =
    row Debug
        [ center ]
        [ text <| toString c
        ]



--viewCheckbox step =
--    row None
--        []
--        [ el None [ width (percent 80) ] (text step.description)
--        , Input.checkbox None
--            [ Element.Events.onClick NoOp ]
--            { onChange = Check
--            , checked = step.completed
--            , label = el None [] (text "")
--            , options = []
--            }
--        ]


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
