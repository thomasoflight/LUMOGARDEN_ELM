module Main exposing (..)

-- What should the BlockPinnedCards data type be? Like a record with `Card`?


type alias Model =
    Blocks


type alias Block =
    { name : String
    , pinnedCards : BlockPinnedCards
    }


type alias Blocks =
    { topL : Maybe Block
    , topM : Maybe Block
    , topR : Maybe Block
    , midL : Maybe Block
    , midR : Maybe Block
    , botL : Maybe Block
    , botM : Maybe Block
    , botR : Maybe Block
    }


type alias BlockPinnedCards =
    { cardA : Maybe Card
    , cardB : Maybe Card
    , cardC : Maybe Card
    }



-- I'm not sure if I need this


type BlockPosition
    = TopL
    | TopM
    | TopR
    | MidL
    | MidR
    | BotL
    | BotM
    | BotR


type alias Card =
    { name : String
    , steps : List Step
    }


type alias Step =
    { description : String
    , stepNo : Int
    , completed : Bool
    }


type alias Jars =
    { topL : Maybe Card
    , topM : Maybe Card
    , topR : Maybe Card
    , midL : Maybe Card
    , midR : Maybe Card
    , botL : Maybe Card
    , botM : Maybe Card
    , botR : Maybe Card
    }
