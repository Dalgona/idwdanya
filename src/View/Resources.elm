module View.Resources exposing (render)


import Html exposing (..)
import Html.Attributes exposing (class)
import Model exposing (Model, resName)


render : Model -> Html a
render model =
  div [class "contents"] (List.indexedMap subView model.resources)


subView : Int -> Int -> Html a
subView resId num =
  div [class "item"]
    [ span [class "label"] [text <| resName resId]
    , span [class "value"] [text <| toString num]
    ]
