module View.Items exposing (render)


import Array exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class)
import Model exposing (Model)


render : Model -> Html a
render model =
  let
    numOpenSlot =
      model.slots
        |> filter (\x -> x.isOpen)
        |> length
    labels = ["인형제조슬롯", "대체코어", "인형제조계약", "쾌속제조"]
    values = [numOpenSlot, model.core, model.ticket, model.express]
  in
    div [class "contents"] (List.map2 subView labels values)


subView : String -> Int -> Html a
subView label num =
  div [class "item"]
    [ span [class "label"] [text label]
    , span [class "value"] [text <| toString num]
    ]
