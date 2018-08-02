module Updates exposing (..)


type Msg
    = NoOp
    | Check Bool
    | ToggleComplete Int
    | Rebloom


update msg model =
    case msg of
        NoOp ->
            model ! []

        Check bool ->
            model ! []

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
            in
            { model
                | cardA = updateCard model.cardA
                , cardB = updateCard model.cardB
                , flaggedForComplete = []
            }
                ! []
