--main =
--    view
--half int =
--    int / 2
--px int =
--    (toString int) ++ "px"
--view =
--    let
--        w =
--            600
--        rectW =
--            100
--        rectH =
--            100
--        c =
--            half rectW
--        center =
--            (2 * rectW) + c
--        a =
--            half (w - center)
--        a2 =
--            a + rectW + c
--        rectOneX =
--            px a
--        rectoTwoX =
--            px a2
--        rectOneY =
--            px 75
--        rectoTwoY =
--            px 75
--    in
--        svg [ viewBox (String.join " " [ "0", "0", (toString w), (toString w) ]) ]
--            [ rect
--                [ x rectOneX
--                , y rectOneY
--                , width (toString rectW)
--                , height (toString rectH)
--                ]
--                []
--            , rect
--                [ x rectoTwoX
--                , y rectOneY
--                , width (toString rectW)
--                , height (toString rectH)
--                ]
--                []
--            ]


module Main exposing (..)

import Html exposing (..)


--import Html.Attributes exposing (..)

import Html.Events exposing (..)
import Svg exposing (circle, rect, svg)
import Svg.Attributes exposing (..)
import String
import List


-- TYPES


type Msg
    = NoOp



-- MODEL


init =
    Model [ "Sample Fish" ] ! []


type alias Model =
    { fish : List String
    }



-- VIEW


view : Model -> Html msg
view model =
    svg [ viewBox "0, 0, 320, 320" ]
        [ rect
            [ fill "#35469a"
            , x "0"
            , y "0"
            , width "100%"
            , height "100%"
            ]
            []
        , rect
            [ fill "#bbbbbb"
            , x "25%"
            , y "15%"
            , width "50%"
            , height "3%"
            ]
            []
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
