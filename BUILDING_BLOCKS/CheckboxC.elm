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
    , flaggedForComplete : List Int
    }


type alias Model =
    { cardA : Card
    , cardB : Card
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
    Model cardA cardB ! []


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


update msg model =
    case msg of
        NoOp ->
            model ! []

        Check bool ->
            let
                bool =
                    False
            in
            model ! []

        ToggleComplete cardPosition id ->
            let
                addFlag c =
                    not (List.member id c.flaggedForComplete)

                removeFlag c =
                    List.member id c.flaggedForComplete

                updateFlags c =
                    { c
                        | flaggedForComplete =
                            if addFlag c then
                                id :: c.flaggedForComplete
                            else if removeFlag c then
                                List.filter (\i -> i /= id) c.flaggedForComplete
                            else
                                c.flaggedForComplete
                    }
            in
            case cardPosition of
                TopL ->
                    { model | cardA = updateFlags model.cardA } ! []

                TopC ->
                    { model | cardB = updateFlags model.cardB } ! []

                TopR ->
                    model ! []

                MidL ->
                    model ! []

                MidR ->
                    model ! []

                BtmL ->
                    model ! []

                BtmC ->
                    model ! []

                BtmR ->
                    model ! []

        Rebloom ->
            let
                updateCheck flagged step =
                    if List.member step.id flagged then
                        { step | completed = not step.completed }
                    else
                        step

                update c =
                    { c
                        | steps = List.map (updateCheck c.flaggedForComplete) c.steps
                        , flaggedForComplete = []
                    }
            in
            { model
                | cardA = update model.cardA
                , cardB = update model.cardB
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
                    [ viewCardSteps TopL model.cardA
                    , viewCardSteps TopC model.cardB
                    ]
                , viewDebug (.flaggedForComplete model.cardA)
                , viewDebug model.cardB.flaggedForComplete
                , viewDebugList model.cardA.steps
                , viewDebugList model.cardB.steps
                ]


viewRefresh =
    row None
        [ center ]
        [ el GreenButton [ Element.Events.onClick Rebloom, width (px 100), height (px 25) ] (text "refresh") ]


viewCardSteps cardPosition card =
    let
        viewCheckbox step =
            row None
                []
                [ el None [ width (percent 80) ] (text step.description)
                , Input.checkbox None
                    [ Element.Events.onClick (ToggleComplete cardPosition step.id) ]
                    { onChange = Check
                    , checked = step.completed
                    , label = el None [] (text "")
                    , options = []
                    }
                ]

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
