module View.Order exposing (render)


import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (..)
import Model exposing (Model, UIState(..), resName)
import Msg exposing (..)


render : Model -> Html Msg
render model =
  let
    foo = 0
  in
    case model.uiState of
      OrderForm slotNum -> form model slotNum
      _ -> div [] []


form : Model -> Int -> Html Msg
form model slotNum =
  div [class "order-form"]
    [ div [class "left"]
        [ divRemaining model
        , div []
            [ button
              [class "confirm", onClick <| CompleteOrder slotNum]
              [text "제조개시"]
            ]
        , div []
            [ button
              [class "cancel", onClick CancelOrder]
              [text "취소"]
            ]
        ]
    , div [class "right"] (List.indexedMap valueControl model.use)
    , div [class "box"] []
    ]


divRemaining : Model -> Html Msg
divRemaining model =
  let
    t = model.ticket
    str = String.concat [toString t, " > ", toString (t - 1)]
  in
    header []
      [ div []
          [ span [class "title"] [text "인형제조"]
          , span [class "label"] [text "잔여계약수량"]
          ]
      , div [class "tickets"] [text str]
      ]


valueControl : Int -> Int -> Html Msg
valueControl resId resValue =
  let
    digits = resValue |> toString |> String.padLeft 3 '0' |> String.toList
  in
    div [class "value-control"] (
      [ div [class "label"] [span [] [text <| resName resId]]
      ] ++ (List.map2 (digitControl resId) digits [100, 10, 1])
    )


digitControl : Int -> Char -> Int -> Html Msg
digitControl resId digit delta =
  div [class "digit-control"]
    [ button [onClick <| SetUse (+) resId delta] [text "▲"]
    , div [class "digit"] [span [] [text <| String.fromChar digit]]
    , button [onClick <| SetUse (-) resId delta] [text "▼"]
    ]
