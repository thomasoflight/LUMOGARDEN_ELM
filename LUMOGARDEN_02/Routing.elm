module Routing exposing (..)

import Navigation exposing (Location)
import Types exposing (Page)
import UrlParser exposing (..)


extractRoute : Location -> Page
extractRoute location =
    case parsePath matchRoute location of
        Just page ->
            page

        Nothing ->
            Types.NotFoundPage


matchRoute : Parser (Page -> a) a
matchRoute =
    oneOf
        [ map Types.BlocksPage top
        , map Types.BlocksPage (s "blocks")
        , map Types.JarsPage (s "jars" </> string)
        ]
