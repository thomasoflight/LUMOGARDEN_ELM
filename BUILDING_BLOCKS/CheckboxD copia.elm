module Main exposing (..)

import Color
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events
import Element.Input as Input
import Element.Keyed as Keyed
import Html
import Style exposing (..)
import Style.Background as Background
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font


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
    , flaggedForComplete : List Int
    }


type alias Model =
    { cardA : Card
    , cardB : Card
    , flaggedForComplete : List Int
    }


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
    Model cardA cardB [] ! []


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
    | ToggleComplete Int
    | Rebloom


update msg model =
    case msg of
        NoOp ->
            model ! []

        Check bool ->
            model ! []

        ToggleComplete id ->
            let
                addFlag id =
                    not (List.member id model.flaggedForComplete)

                removeFlag id =
                    List.member id model.flaggedForComplete

                updateFlags flaggedIds id =
                    if addFlag id then
                        id :: flaggedIds
                    else if removeFlag id then
                        List.filter (\i -> i /= id) flaggedIds
                    else
                        flaggedIds
            in
            { model | flaggedForComplete = updateFlags model.flaggedForComplete id } ! []

        Rebloom ->
            let
                updateCheck step =
                    if List.member step.id model.flaggedForComplete then
                        { step | completed = True }
                    else
                        step

                updateCard c =
                    { c
                        | steps = List.map updateCheck c.steps
                    }
            in
            { model
                | cardA = updateCard model.cardA
                , cardB = updateCard model.cardB
                , flaggedForComplete = []
            }
                ! []


view model =
    Element.layout stylesheet <|
        el None [ center, width (px 650), height (px 650) ] <|
            column GreyOutline
                [ height fill, width fill, padding 60, spacing 20 ]
                [ viewRefresh
                , row None
                    [ spacing 40 ]
                    [ viewCardSteps model.cardA
                    , viewCardSteps model.cardB
                    ]
                , viewDebug model.flaggedForComplete
                , viewDebugList model.cardA.steps
                , viewDebugList model.cardB.steps
                ]


viewRefresh =
    row None
        [ center ]
        [ el GreenButton [ Element.Events.onClick Rebloom, width (px 100), height (px 25) ] (text "refresh") ]


viewCardSteps card =
    let
        viewCheckbox step =
            ( toString step.id
            , row None
                []
                [ el None [ width (percent 80) ] (text step.description)
                , Input.checkbox None
                    [ Element.Events.onClick (ToggleComplete step.id) ]
                    { onChange = Check
                    , checked = step.completed
                    , label = el None [] (text "")
                    , options = []
                    }
                ]
            )

        activeSteps =
            List.filter (\s -> not s.completed) card.steps

        selectedSteps =
            List.take 3 activeSteps
    in
    Keyed.column None
        [ width (percent 50), spacing 20 ]
    <|
        List.map viewCheckbox selectedSteps


viewDebug c =
    row Debug
        [ center ]
        [ text <| toString c
        ]


viewDebugList items =
    column None [] (List.map viewDebug items)


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
