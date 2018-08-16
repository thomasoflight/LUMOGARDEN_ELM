module Fish exposing (..)

import Dom
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as JsonDec
import List
import String


-- TYPES


type Msg
    = NoOp
    | UpdateFishField String
    | Add



-- MODEL


defaultModel : Model
defaultModel =
    { fish =
        [ makeFish "..." -1
        , makeFish "..." -2
        , makeFish "..." -3
        ]
    , fishField = ""
    , fishUid = 0
    }


init =
    defaultModel ! []


type alias Fish =
    { fishName : String
    , fishUid : Int
    }


type alias Model =
    { fish : List Fish
    , fishField : String
    , fishUid : Int
    }


makeFish : String -> Int -> Fish
makeFish str uid =
    { fishName = str
    , fishUid = uid
    }


onEnter : Msg -> Attribute Msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                JsonDec.succeed msg
            else
                JsonDec.fail "not ENTER"
    in
    on "keydown" (JsonDec.andThen isEnter keyCode)



-- VIEW


view model =
    div [ class "fish-container" ]
        [ renderFishInput model.fishField
        , div [] (List.map renderFish model.fish)
        ]


renderFish fish =
    li [] [ text fish.fishName ]


renderFishInput fishName =
    input
        [ placeholder "pls...tell us your fish"
        , value fishName
        , onInput UpdateFishField
        , onEnter Add
        ]
        []



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        UpdateFishField str ->
            { model | fishField = str } ! []

        Add ->
            { model
                | fishField = ""
                , fish =
                    if String.isEmpty model.fishField then
                        model.fish
                    else
                        model.fish ++ [ makeFish model.fishField model.fishUid ]
                , fishUid = model.fishUid + 1
            }
                ! []



--main : Program Never Model Msg


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
