module Form exposing (..)

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


type alias Card =
    { description : String
    , completed : Bool
    , id : Int
    }


type alias Model =
    { cards : List Card
    , bool : Bool
    , int : Int
    }


stylesheet : StyleSheet Styles variation
stylesheet =
    Style.styleSheet
        [ style None []
        , style BlueFill
            [ Color.background Color.blue ]
        , style GreenButton
            [ Color.background Color.green
            , Font.center
            , Color.text Color.white
            ]
        ]


type Msg
    = NoOp
    | Check Bool
    | CheckInt Int


update msg model =
    case msg of
        NoOp ->
            model ! []

        Check bool ->
            { model | bool = bool } ! []

        CheckInt int ->
            { model | int = int } ! []


myCards =
    [ Card "A" True 1
    , Card "B" False 2
    ]


init =
    Model myCards True 0 ! []


view model =
    Element.layout stylesheet <|
        el None [ center, width (px 1000), height (px 1000) ] <|
            row None
                [ spacing 40 ]
                [ Input.checkbox None
                    [ Element.Events.onClick (CheckInt 5) ]
                    { onChange = Check
                    , checked = False
                    , label = el None [] (text "hello!")
                    , options = []
                    }
                , el None [] (text <| toString model.bool)
                , el None [] (text <| toString model.int)
                ]


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
