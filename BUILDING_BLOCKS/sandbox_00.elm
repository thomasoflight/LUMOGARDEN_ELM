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
    { cards : List Card }


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


update msg model =
    case msg of
        NoOp ->
            model ! []

        Check bool ->
            model ! []


init =
    { cards =
        [ { description = "A"
          , completed = False
          , id = 0
          }
        , { description = "B"
          , completed = True
          , id = 1
          }
        ]
    }
        ! []


view model =
    Element.layout stylesheet <|
        el None [ center, width (px 1000), height (px 1000) ] <|
            row None
                [ spacing 40 ]
                [ viewCardSteps model.cards
                , viewCardSteps model.cards
                ]


viewRebloom =
    row None [ center ] [ el GreenButton [ width (px 100), height (px 25) ] (text "rebloom") ]


viewCardSteps cards =
    column None
        [ width (percent 50), spacing 20 ]
    <|
        List.map viewCheckbox cards


viewCheckbox card =
    row None
        []
        [ Input.styledCheckbox Checkbox
            []
            { onChange = Check
            , checked = card.completed
            , label = el None [] (text "a checkbox")
            , options = []
            , icon =
                \on ->
                    circle 10
                        (if on then
                            CheckboxChecked
                         else
                            Checkbox
                        )
                        []
                        empty
            }
        ]


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
