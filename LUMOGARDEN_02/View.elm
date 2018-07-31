module View exposing (..)

import Html exposing (Html, h3, text)
import Pages.BlocksPage
import Pages.JarsPage
import Types exposing (..)
import Updates exposing (Msg)


view : Model -> Html Msg
view model =
    case model.currentPage of
        BlocksPage ->
            Pages.BlocksPage.viewPage model.cardsForBlocks

        JarsPage string ->
            Pages.JarsPage.viewPage

        NotFoundPage ->
            notFoundPage


notFoundPage : Html msg
notFoundPage =
    h3 [] [ text "..." ]
