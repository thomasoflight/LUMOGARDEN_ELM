module Models exposing (..)


type alias Model =
    { cardA : Card
    , cardB : Card
    , flaggedForComplete : List Int
    }


type alias Step =
    { description : String
    , completed : Bool
    , id : Int
    }


type alias Card =
    { title : String
    , steps : List Step
    }


someSteps =
    [ Step "A" True 1
    , Step "B" False 2
    , Step "C" False 3
    , Step "D" False 4
    , Step "E" False 5
    , Step "..." False 6
    , Step "..." False 7
    , Step "..." False 8
    , Step "..." False 9
    ]


moreSteps =
    [ Step "C" False 10
    , Step "D" False 11
    ]


cardDflt =
    Card "..." []


cardA =
    Card "A" someSteps


cardB =
    Card "B" moreSteps


init =
    Model cardA cardB [] ! []
