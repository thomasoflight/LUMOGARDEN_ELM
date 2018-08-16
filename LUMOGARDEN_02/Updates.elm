module Updates exposing (..)

import Navigation exposing (Location)
import Routing
import Types exposing (..)


type Msg
    = NoOp
    | Check Bool
    | LocationChanged Location
    | ToggleComplete Int
    | Rebloom


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Check bool ->
            model ! []

        LocationChanged location ->
            let
                newPage =
                    Routing.extractRoute location
            in
            ( { model | currentPage = newPage }, Cmd.none )

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

                newAA =
                    updateCard model.cardsForJars.aa

                newBB =
                    updateCard model.cardsForJars.bb

                newA =
                    List.map updateCard model.cardsForBlocks.a
            in
            { model
                | cardsForBlocks = Blocks newA [] [] [] [] [] [] []
                , cardsForJars = Jars newAA newBB cardDflt cardDflt cardDflt cardDflt cardDflt cardDflt
                , allCards = List.map updateCard model.allCards
                , flaggedForComplete = []
            }
                ! []
