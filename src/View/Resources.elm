module View.Resources exposing (render)


import Html exposing (..)
import Html.Attributes exposing (class)
import Model exposing (Model)


render : Model -> Html a
render model =
  let
    labels = ["인력", "탄약", "식량", "부품"]
  in
    div [class "contents"] (List.map2 subView labels model.resources)


subView : String -> Int -> Html a
subView label num =
  div [class "item"]
    [ span [class "label"] [text label]
    , span [class "value"] [text <| toString num]
    ]
