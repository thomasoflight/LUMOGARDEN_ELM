module App exposing (..)

import Html
import Navigation exposing (Location)
import State exposing (init)
import Types exposing (..)
import Updates exposing (..)
import View exposing (view)


main : Program Never Model Msg
main =
    Navigation.program LocationChanged
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
