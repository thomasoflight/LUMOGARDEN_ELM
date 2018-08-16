module Types exposing (..)


type alias Model =
    { currentPage : Page
    , allCards : List Card
    , cardsForBlocks : Blocks
    , cardsForJars : Jars
    , flaggedForComplete : List Int
    }


type CardActive
    = ActiveBlock String
    | ActiveJar String
    | Inactive


type Page
    = BlocksPage
    | JarsPage String
    | CardsPage Int
    | NotFoundPage


type alias Card =
    { id : Int
    , title : String
    , steps : List Step
    , active : CardActive
    }


type alias Step =
    { description : String
    , completed : Bool
    , id : Int
    }


type alias Blocks =
    { a : List Card
    , b : List Card
    , c : List Card
    , d : List Card
    , f : List Card
    , g : List Card
    , h : List Card
    , i : List Card
    }


type alias Jars =
    { aa : Card
    , bb : Card
    , cc : Card
    , dd : Card
    , ff : Card
    , gg : Card
    , hh : Card
    , ii : Card
    }


someSteps : List Step
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


moreSteps : List Step
moreSteps =
    [ Step "C" False 10
    , Step "D" False 11
    ]


cardA : Card
cardA =
    Card 1 "A" someSteps Inactive


cardB : Card
cardB =
    Card 2 "B" moreSteps (ActiveBlock "arte")


emptyBlocks : Blocks
emptyBlocks =
    Blocks [ cardA, cardB ] [] [] [] [] [] [] []


emptyJars : Jars
emptyJars =
    Jars cardA cardB cardDflt cardDflt cardDflt cardDflt cardDflt cardDflt


cardDflt =
    Card 0 "..." [] Inactive
