module View.Slots exposing (render)


import Array
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (Model, Slot)
import Msg exposing (..)


render : Model -> Html Msg
render model =
  let
    slots = Array.toIndexedList model.slots
  in
    div [] (List.map subView slots)


subView : (Int, Slot) -> Html Msg
subView (index, slot) =
  let
    leftView =
      if slot.isInUse then progressView index slot else startButton index
  in
    if slot.isOpen
      then
        div [class "slot"]
          [ div [class "left"] [leftView]
          , div [class "mid"] (slotTitle <| index + 1)
          , div [class "right"] []
          ]
      else
        div [class "slot locked"]
          [ div [class "label"] [span [] [text "LOCKED"], span [] [text "잠김"]]
          , div [class "mid"] (slotTitle <| index + 1)
          ]


locked : Html a
locked =
  div [] [span [] [text "잠김"]]


slotTitle : Int -> List (Html a)
slotTitle index =
  let
    numStr = index |> toString |> String.padLeft 2 '0'
  in
    [ span [class "title"] [text "SLOT"]
    , span [class "num"] [text numStr]
    , span [class "standby"] [text "PLEASE STAND BY"]
    ]


startButton : Int -> Html Msg
startButton index =
  div [class "start-button", onClick <| StartOrder index]
    [ span [class "caption"] [text "인형제조"]
    , span [class "title"] [text "개시"]
    ]


progressView : Int -> Slot -> Html Msg
progressView index slot =
  let
    time = slot.timeRemaining
    seconds = time // 100
    hundredth = time % 100 |> toString |> String.padLeft 2 '0'
    buttonToShow =
      if time == 0
        then button
          [class "finish", onClick <| Finish index]
          [text "제조완료"]
        else button
          [class "finish-now", onClick <| FinishNow index]
          [text "즉시완성"]
  in
    div [class "progress"]
      [ div [class "time-remaining"]
          [ span [] [text <| formatTime seconds]
          , span [class "hundredth"] [text <| hundredth]
          ]
      , buttonToShow
      ]


formatTime : Int -> String
formatTime time =
  let
    (time1, seconds) = (time // 60, time % 60)
    (hours, minutes) = (time1 // 60, time1 % 60)
    convert num = num |> toString |> String.padLeft 2 '0'
    hh = convert hours
    mm = convert minutes
    ss = convert seconds
  in
    String.concat <| List.intersperse ":" [hh, mm, ss]
