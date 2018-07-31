module State exposing (..)

import Navigation exposing (Location)
import Routing
import Types exposing (..)
import Updates exposing (Msg)


initialModel : Page -> Model
initialModel page =
    { currentPage = page
    , allCards = [ cardA, cardB ] -- this will change to something else later maybe
    , cardsForBlocks = emptyBlocks
    , cardsForJars = emptyJars
    , flaggedForComplete = []
    }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentPage =
            Routing.extractRoute location
    in
    ( initialModel currentPage, Cmd.none )
