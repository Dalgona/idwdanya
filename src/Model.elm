module Model exposing (Model, Slot, UIState(..), init, useResource, resName)


import Array exposing (..)
import Maybe exposing (..)
import Result


type alias Model =
  { resources : List Int
  , slots : Array Slot
  , core : Int
  , ticket : Int
  , express : Int
  , use : List Int
  , uiState : UIState
  }


type alias Slot =
  { isOpen : Bool
  , isInUse : Bool
  , timeRemaining : Int
  }


type UIState
  = Normal
  | OrderForm Int
  | ShowIDW Bool


init : Model
init =
  let
    openSlot = Slot True False 0
    closedSlot = {openSlot | isOpen = False}
    slots = append (repeat 2 openSlot) (repeat 6 closedSlot)
  in
    Model
      [300000, 300000, 300000, 300000]
      slots
      500 100 100
      [30, 30, 30, 30]
      Normal


useResource : Model -> List Int -> Result String Model
useResource model use =
  let
    resources = model.resources
    remaining = List.map2 (-) resources use
  in
    if List.length remaining /= 4
      then Err "list length mismatch (must be 4)"
      else if List.all (\x -> x > 0) remaining
        then Ok {model | resources = remaining}
        else Err "not enough resource"


resName : Int -> String
resName resId =
  let
    names = Array.fromList ["인력", "탄약", "식량", "부품"]
  in
    case Array.get resId names of
      Just str -> str
      Nothing -> ""
