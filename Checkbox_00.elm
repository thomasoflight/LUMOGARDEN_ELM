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
    | Page
    | Field
    | SubMenu
    | Error
    | InputError
    | Checkbox
    | CheckboxChecked
    | LabelBox
    | Button
    | CustomRadio
    | BlueFill
    | GreenButton


type Other
    = Thing Int


type alias Card =
    { description : String
    , completed : Bool
    , id : Int
    }


type alias Model =
    { cards : List Card }



-- options =
--     [ Style.unguarded
--     ]


stylesheet : StyleSheet Styles variation
stylesheet =
    Style.styleSheet
        [ style None []
        , style Error
            [ Color.text Color.red
            ]
        , style CustomRadio
            [ Border.rounded 5
            , Border.all 1
            , Border.solid
            , Color.border Color.grey
            ]
        , style LabelBox
            []
        , style Checkbox
            [ Color.background Color.white
            , Border.all 1
            , Border.solid
            , Color.border Color.grey
            ]
        , style CheckboxChecked
            [ Color.background Color.blue
            , Border.all 1
            , Border.solid
            , Color.border Color.blue
            ]
        , style Page
            [ Color.text Color.darkCharcoal
            , Color.background Color.white
            , Font.typeface
                [ Font.font "helvetica"
                , Font.font "arial"
                , Font.font "sans-serif"
                ]
            , Font.size 16
            , Font.lineHeight 1.3
            ]
        , style Field
            [ Border.rounded 5
            , Border.all 1
            , Border.solid
            , Color.border Color.lightGrey
            ]
        , style SubMenu
            [ Border.rounded 5
            , Border.all 2
            , Border.solid
            , Color.border Color.blue

            -- , focus
            --     [ Color.border Color.blue
            --     , prop "outline" "none"
            --     ]
            ]
        , style Button
            [ Border.rounded 5
            , Border.all 1
            , Border.solid
            , Color.border Color.blue
            , Color.background Color.lightBlue
            ]
        , style BlueFill
            [ Color.background Color.blue ]
        , style GreenButton
            [ Color.background Color.green
            , Font.center
            , Color.text Color.white
            ]
        ]


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


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type Msg
    = NoOp
    | Check Bool


update msg model =
    case msg of
        NoOp ->
            model ! []

        Check bool ->
            model ! []



--let
--    updateEntry c =
--        if c.id == id then
--            { c | completed = bool }
--        else
--            c
--in
--{ model | cards = List.map updateEntry model.cards } ! []


view model =
    Element.layout stylesheet <|
        el None [ center, width (px 1000), height (px 1000) ] <|
            column BlueFill
                [ height fill, width fill, padding 60, spacing 20 ]
                --[ el CheckboxChecked [ width fill ]
                [ viewRebloom
                , row None
                    [ spacing 40 ]
                    [ viewCardSteps model.cards
                    , viewCardSteps model.cards
                    ]
                ]


viewRebloom =
    row None [ center ] [ el GreenButton [ width (px 100), height (px 25) ] (text "rebloom") ]


viewCardSteps cards =
    column Page
        [ width (percent 50), spacing 20 ]
    <|
        List.map viewCheckbox cards



--<|
--List.map viewCheckbox cards
--[ el None [] (text (toString <| cards)) ]
--List.map viewCheckbox model.[] "step A" False
--, viewCheckbox "step B" False
--, viewCheckbox "step C" False
--, viewCheckbox "step D" False


viewCheckbox card =
    row None
        []
        [ el None [ width (percent 80) ] (text card.description)
        , Input.styledCheckbox Checkbox
            []
            { onChange = Check
            , checked = card.completed
            , label = el None [] (text "")
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
