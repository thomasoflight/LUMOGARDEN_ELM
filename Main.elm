module Main exposing (..)

import Dom
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as JsonDec
import List
import String


type Msg
    = NoOp


type alias Step =
    { description : String
    , stepNo : Int
    , completed : Bool
    , id : Int
    }


type alias Card =
    { cardName : String
    , steps : List Step
    }


type alias Jar =
    { jarName : String
    , activeCardsJar : List Card
    , allCardsJar : List Card
    }


type alias Block =
    { blockName : String
    , activeCardsBlock : List Card
    }


type alias Model =
    { cards : List Card }


cardOne =
    Card "cardOne"
        [ Step "one" 0 False 1
        , Step "two" 1 False 2
        ]


cardTwo =
    Card "cardTwo"
        [ Step "one" 0 False 3
        , Step "two" 1 False 4
        ]


init =
    Model [] ! []


update msg model =
    case msg of
        NoOp ->
            model ! []


view model =
    div []
        [ viewCard cardOne
        , viewCard cardTwo
        ]


viewCard card =
    let
        cardName =
            .cardName card

        steps =
            List.map .description card.steps
    in
    div [] (List.concat [ [ h1 [] [ text cardName ] ], viewSteps steps ])


viewSteps steps =
    List.map (\a -> li [] [ text a ]) steps



--text <| toString card


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
