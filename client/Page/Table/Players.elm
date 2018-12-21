module Page.Table.Players exposing (PlayerVote(..), view)

import Css
import Data exposing (Player, Vote)
import Dict exposing (Dict)
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attrs
import Maybe.Extra as Maybe
import Theme


type PlayerVote
    = Hidden
    | Unknown
    | Voted Vote


voteIndicator : PlayerVote -> Html msg
voteIndicator playerVote =
    let
        show txt =
            Html.styled Html.span
                [ Theme.pill
                , Css.backgroundColor Theme.values.primaryColor
                , Css.borderRadius <| Css.pct 100
                ]
                []
                [ Html.text txt ]
    in
    case playerVote of
        Hidden ->
            Html.text ""

        Unknown ->
            show "?"

        Voted vote ->
            show <| String.fromInt <| Data.voteToInt vote


bankerIndicator : Bool -> Html msg
bankerIndicator isBanker =
    if isBanker then
        Html.styled Html.span
            [ Theme.pill
            , Css.backgroundColor Theme.values.secondaryColor
            , Css.marginLeft Css.zero
            ]
            [ Attrs.title "Banker" ]
            [ Html.text "B" ]

    else
        Html.text ""


onlineIndicator : Bool -> Html msg
onlineIndicator isActive =
    let
        size =
            Css.px 8

        text =
            if isActive then
                "online"

            else
                "offlie"
    in
    Html.styled Html.span
        [ Css.display Css.inlineBlock
        , Css.width size
        , Css.height size
        , Css.borderRadius <| Css.pct 100
        , Css.overflow <| Css.hidden
        , Css.textIndent <| Css.px -999
        , Css.margin4 Css.zero (Css.px 6) (Css.px 2) Css.zero
        , Css.backgroundColor <|
            if isActive then
                Theme.values.greenColor

            else
                Theme.values.primaryColor
        ]
        [ Attrs.title text ]
        [ Html.text text
        ]


viewPlayer : (Player -> PlayerVote) -> (Player -> Bool) -> Player -> Html msg
viewPlayer toVote isBanker player =
    Html.styled Html.li
        [ Css.listStyle Css.none
        , Css.margin4 Css.zero Css.zero (Css.px 6) Css.zero
        , Css.fontWeight <| Css.int 200
        , Css.overflow Css.hidden
        , Css.textOverflow Css.ellipsis
        ]
        []
        [ onlineIndicator player.isConnected
        , bankerIndicator <| isBanker player
        , Html.text player.name
        , voteIndicator <| toVote player
        ]


{-| @TODO: Odd api
-}
view : (Player -> PlayerVote) -> Maybe Player -> Dict String Player -> Html msg
view toVote banker players =
    let
        isBanker =
            (==) banker << Just
    in
    Html.div []
        [ Html.h3 [] [ Html.text "Players:" ]
        , Html.styled Html.ul
            [ Css.listStyle Css.none
            , Css.margin Css.zero
            , Css.padding Css.zero
            ]
            []
          <|
            Maybe.unwrap (Html.text "") (viewPlayer toVote isBanker) banker
                :: (List.map (viewPlayer toVote isBanker) <|
                        Dict.values players
                   )
        ]