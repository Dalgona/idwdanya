module View.Result exposing (render)


import Html exposing (..)
import Html.Attributes exposing (attribute, autoplay, class, src)
import Html.Events exposing (..)
import Json.Decode exposing (succeed)
import Model exposing (Model, UIState(..))
import Msg exposing (..)


render : Model -> List (Html Msg)
render model =
  case model.uiState of
    ShowIDW introPlaying ->
      let
        (videoClass, imgClass) =
          if introPlaying
            then ("", "hidden")
            else ("idw-image hidden", "idw-image")
      in
        [ div
            [ class imgClass
            , onClick HideIDW
            ] []
        , video
            [ class videoClass
            , onEnded HideVideo
            , src "./result-intro.mp4"
            , autoplay True
            , attribute "muted" "muted"
            ] []
        ]

    _ ->
      []


onEnded : Msg -> Attribute Msg
onEnded msg =
  on "ended" (succeed msg)
