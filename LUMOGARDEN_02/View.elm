module View exposing (..)

import Html exposing (Html, h3, text)
import Pages.BlocksPage
import Pages.CardsPage
import Pages.JarsPage
import Types exposing (..)
import Updates exposing (Msg)


view : Model -> Html Msg
view model =
    case model.currentPage of
        BlocksPage ->
            Pages.BlocksPage.viewPage model.cardsForBlocks

        JarsPage string ->
            Pages.JarsPage.viewPage model

        CardsPage int ->
            case findCardById int model.allCards of
                Just card ->
                    Pages.CardsPage.viewPage card

                Nothing ->
                    notFoundPage

        NotFoundPage ->
            notFoundPage


notFoundPage : Html msg
notFoundPage =
    h3 [] [ text "..." ]


findCardById id cards =
    cards
        |> List.filter (\c -> c.id == id)
        |> List.head
