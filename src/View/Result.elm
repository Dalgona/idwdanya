module View.Result exposing (render)


import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (..)
import Model exposing (Model, UIState(..))
import Msg exposing (..)


render : Model -> Html Msg
render model =
  if model.uiState == IDWDANYA
    then div [class "doll-result"] []
    else div [] []
