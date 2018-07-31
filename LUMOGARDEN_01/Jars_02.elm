module Jars exposing (..)

import Html
import Models
import Updates
import Views


main =
    Html.program
        { init = Models.init
        , update = Updates.update
        , view = Views.view
        , subscriptions = \_ -> Sub.none
        }
