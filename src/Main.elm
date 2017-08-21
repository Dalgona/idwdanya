module Main exposing (update, view, subscriptions, init)


import Array
import Html exposing (..)
import Html.Attributes exposing (class)
import Maybe
import Time exposing (Time, millisecond)
import Model exposing (Model, Slot, UIState(..))
import Msg exposing (..)
import View.Items
import View.Order
import View.Resources
import View.Result
import View.Slots


main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    StartOrder slotNum ->
      if model.ticket > 0
        then ({model | uiState = OrderForm slotNum}, Cmd.none)
        else (model, Cmd.none) -- TODO: show error when not enough ticket

    CompleteOrder slotNum ->
      let
        --newSlot = Slot True True 2000
        newSlot = Slot True True 420000
        newModel =
          case Model.useResource model model.use of
            Ok newModel ->
              { newModel
              | ticket = model.ticket - 1
              , slots = Array.set slotNum newSlot model.slots
              }
            Err _ ->
              model -- TODO: show error when not enough ticket
      in
        ({newModel | uiState = Normal}, Cmd.none)

    CancelOrder ->
      ({model | uiState = Normal}, Cmd.none)

    SetUse op which amount ->
      let
        useArray = Array.fromList model.use
        value =
          case Array.get which useArray of
            Just x -> x
            _ -> 0
        newValue = clamp 30 999 (op value amount)
        newArray = Array.set which newValue useArray
      in
        ({model | use = Array.toList newArray}, Cmd.none)

    Finish slotNum ->
      let
        slot = Slot True False 0
        newSlots = Array.set slotNum slot model.slots
      in
        ({model | slots = newSlots, uiState = ShowIDW True}, Cmd.none)

    FinishNow slotNum ->
      let
        slot = Slot True False 0
        newSlots = Array.set slotNum slot model.slots
        newModel =
          if model.express > 0
            then
              { model
              | slots = newSlots
              , express = model.express - 1
              , uiState = ShowIDW True
              }
            else model -- TODO: show error when not enough ticket
      in
        (newModel, Cmd.none)

    HideVideo ->
      ({model | uiState = ShowIDW False}, Cmd.none)

    HideIDW ->
      ({model | uiState = Normal}, Cmd.none)

    Tick _ ->
      let
        decreaseTime slot =
          if slot.isInUse && slot.timeRemaining > 0
            then {slot | timeRemaining = slot.timeRemaining - 1}
            else slot
        updatedSlots = Array.map decreaseTime model.slots
      in
        ({model | slots = updatedSlots}, Cmd.none)  


view : Model -> Html Msg
view model =
  let
    mainView =
      case model.uiState of
        OrderForm _ ->
          div [] [View.Order.render model]
        _ ->
          div [class "slot-list"] [View.Slots.render model]
  in
    div [class "main"]
      [ div [class "resources"] [View.Resources.render model]
      , div [class "items"] [View.Items.render model]
      , mainView
      , div [class "doll-result"] (View.Result.render model)
      ]


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every (10 * millisecond) Tick


init : (Model, Cmd Msg)
init =
  (Model.init, Cmd.none)
